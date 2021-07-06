program ProjInfo;

uses
  Vcl.Forms,
  UntCadCli in 'UntCadCli.pas' {FrmCadCli};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmCadCli, FrmCadCli);
  Application.Run;
end.
