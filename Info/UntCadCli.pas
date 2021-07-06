unit UntCadCli;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,system.json,idSSLOpenSSL,idHTTP,
  uDWAbout, uDWResponseTranslator,Vcl.ExtCtrls, Data.DB, Vcl.Buttons,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,IdMessage, IdSMTP,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,IdAttachmentFile;

type
  TFrmCadCli = class(TForm)
    PageControl1: TPageControl;
    TabCad: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    BtnConsCep: TButton;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EdtNome: TEdit;
    EdtIdent: TEdit;
    EdtCpf: TEdit;
    EdtTel: TEdit;
    EdtEmail: TEdit;
    EdtCep: TEdit;
    EdtEnd: TEdit;
    EdtCompl: TEdit;
    EdtBairro: TEdit;
    EdtCid: TEdit;
    EdtUf: TEdit;
    EdtPais: TEdit;
    DBGrid1: TDBGrid;
    CdsCad: TClientDataSet;
    CdsCadNome: TStringField;
    CdsCadIdentidade: TStringField;
    CdsCadtelefone: TStringField;
    CdsCademail: TStringField;
    CdsCadcep: TStringField;
    CdsCadendereco: TStringField;
    CdsCadcomplemento: TStringField;
    CdsCadbairro: TStringField;
    CdsCadcidade: TStringField;
    CdsCadestado: TStringField;
    CdsCadpais: TStringField;
    DsCad: TDataSource;
    BitBtn1: TBitBtn;
    procedure BtnConsCepClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
     function GetCEP(pCEP:string): TJSONObject;
     procedure CarregaCep(JSON : TJSONObject);
     procedure Limpar_Objetos(pLimpaCep : Boolean = true);
     procedure Gmail(username,password,tortarget,subject,body:string);

  public
    { Public declarations }


  end;

var
  FrmCadCli: TFrmCadCli;
const
  C_SYS_CEP                = '<<CEP>>'                                        ;
  C_SYS_HTTP_URL           = 'https://viacep.com.br/ws/' + C_SYS_CEP + '/json';
  C_MSG_CEP_NAO_ENCONTRADO = 'CEP NAO ENCONTRADO'                             ;
  C_MSG_CEP_INVALIDO       = 'CEP Invalido'                                   ;

implementation

{$R *.dfm}


function TFrmCadCli.GetCEP(pCEP : string): TJSONObject;
var
  _idHTTP : TIdHTTP;
  _idSSLHandler : TIdSSLIOHandlerSocketOpenSSL;
  _ssRetorno : TStringStream;
  LJsonObj: TJSONObject;
begin
   try
      _idHTTP                              := TIdHTTP.Create;
      _idSSLHandler                        := TIdSSLIOHandlerSocketOpenSSL.Create;
      _idHTTP.IOHandler                    := _idSSLHandler;
      _idSSLHandler.SSLOptions.SSLVersions := [sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];

   _ssRetorno := TStringStream.Create('');

   _idHTTP.Get(StringReplace(C_SYS_HTTP_URL,C_SYS_CEP,pCEP,[rfReplaceAll, rfIgnoreCase]), _ssRetorno);

   if (_idHTTP.ResponseCode = 200) and
      (not(Utf8ToAnsi(_ssRetorno.DataString) = '{'#$A' "erro": true'#$A'}' )) then
    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Utf8ToAnsi(_ssRetorno.DataString)),0) as TJSONObject;

   finally
       FreeAndNIl(_idHTTP);
       FreeAndNIl(_idSSLHandler);
       _ssRetorno.Destroy

   end;


end;
procedure TFrmCadCli.Gmail(username,password,tortarget,subject,body:string);
var DATA: TIdMessage;
    SMTP: TIdSMTP;
    SSL : TIdSSLIOHandlerSocketOpenSSL;
    ATC : TIdAttachmentFile;
begin
  SMTP := TIdSMTP.Create(NIL);
  DATA := TIdMessage.Create(NIL);
  SSL  := TIdSSLIOHandlerSocketOpenSSL.Create(NIL);
  ATC  := TIdAttachmentFile.Create(nil);

  SSL.SSLOptions.Method       := sslvTLSv1;
  SSL.SSLOptions.Mode         := sslmUnassigned;
  SSL.SSLOptions.VerifyMode   := [];
  SSL.SSLOptions.VerifyDepth  :=0;

  DATA.From.Address              := username;
  DATA.Recipients.EMailAddresses := tortarget;
  DATA.Subject                   := subject;
  DATA.Body.Text                 := body;

  SMTP.IOHandler := SSL;
  SMTP.Host      :='smtp.gmail.com';
  SMTP.Port      := 587;
  SMTP.Username  := username;
  SMTP.Password  := password;
  SMTP.UseTLS    := utUseExplicitTLS;

  ATC.Create(DATA.MessageParts,'C:\Users\ODAIR\Documents\Info\Win32\Debug\'+EdtNome.Text+'.xml');

  SMTP.Connect;
  SMTP.Send(DATA);
  SMTP.Disconnect;

  SMTP.free;
  DATA.Free;
  SSL.Free;
//  ATC.Free;



end;

procedure TFrmCadCli.Limpar_Objetos(pLimpaCep : Boolean = True);
begin
  if (pLimpaCep) then
   EdtCep.Text := '';

   EdtBairro.Text :='';
   EdtCid.Text := '';
   EdtUf.Text := '';
   EdtPais.Text := 'Brasil';
   EdtUf.Text := '';
   EdtEnd.Text :='';
   EdtCompl.Text := '';

end;

procedure TFrmCadCli.CarregaCep(JSON: TJSONObject);
begin
  Limpar_Objetos(false);

  EdtEnd.Text    := JSON.Get('logradouro'          ).JsonValue.Value;
  EdtCid.Text    := UpperCase(JSON.Get('localidade').JsonValue.Value);
  EdtBairro.Text := JSON.Get('bairro'              ).JsonValue.Value;
  EdtUf.Text     := JSON.Get('uf'              ).JsonValue.Value;
  EdtPais.Text   := 'Brasil';
  EdtCompl.Text  := JSON.Get('complemento'              ).JsonValue.Value;


end;

procedure TFrmCadCli.FormShow(Sender: TObject);
begin

  CdsCad.Filtered := false;
  CdsCad.Close;
  CdsCad.CreateDataSet;
  cdscad.Open;
  EdtNome.SetFocus
end;

procedure TFrmCadCli.BitBtn1Click(Sender: TObject);
begin
  CdsCad.Insert;
  CdsCad.Append;
  CdsCadNome.AsString        := EdtNome.Text;
  CdsCadIdentidade.AsString  := EdtIdent.Text;
  CdsCadtelefone.AsString    := EdtTel.Text;
  CdsCademail.AsString       := EdtEmail.Text;
  CdsCadcep.AsString         := EdtCep.Text;
  CdsCadendereco.AsString    := EdtEnd.Text;
  CdsCadcomplemento.AsString := EdtCompl.Text;
  CdsCadbairro.AsString      := EdtBairro.Text;
  CdsCadcidade.AsString      := EdtCid.Text;
  CdsCadestado.AsString      := EdtUf.Text;
  CdsCadpais.AsString        := EdtPais.Text;
  CdsCad.Post;

  cdscad.SaveToFile(EdtNome.Text+'.xml');

  Gmail('murilo.infoteste@gmail.com','infoteste123',EdtEmail.Text,'Cadastro Teste','Segue em anexo o cadastro realizado');

  EdtNome.Text    :='';
  EdtIdent.Text   :='';
  EdtTel.Text     :='';
  EdtEmail.Text   :='';
  EdtCep.Text     :='';
  EdtEnd.Text     :='';
  EdtCompl.Text   :='';
  edtBairro.Text  :='';
  EdtCid.Text     :='';
  EdtUf.Text      :='';
  EdtPais.Text    :='';
end;

procedure TFrmCadCli.BtnConsCepClick(Sender: TObject);
var _LJsonobj: TJSONObject;

procedure exibe_erro(pMensagem:string);
begin
  ShowMessage(pMensagem);
  Limpar_Objetos;
  EdtCep.SetFocus;
end;
begin
  Limpar_Objetos(false);

  if Length(EdtCep.Text) <> 8 then
    exibe_erro(C_MSG_CEP_INVALIDO)
  else
  begin
  _LJsonobj := GetCEP(EdtCep.Text);

  if _LJsonobj <> nil then
    CarregaCep(_LJsonobj)
  else
    exibe_erro(C_MSG_CEP_NAO_ENCONTRADO);
  end;
end;




end.



