object FrmCadCli: TFrmCadCli
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 513
  ClientWidth = 757
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 4
    Top = 6
    Width = 745
    Height = 507
    ActivePage = TabCad
    TabOrder = 0
    object TabCad: TTabSheet
      Caption = 'Dados Cliente'
      object Label1: TLabel
        Left = 20
        Top = 21
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label2: TLabel
        Left = 20
        Top = 64
        Width = 52
        Height = 13
        Caption = 'Identidade'
      end
      object Label3: TLabel
        Left = 20
        Top = 104
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label4: TLabel
        Left = 178
        Top = 66
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object Label6: TLabel
        Left = 178
        Top = 104
        Width = 24
        Height = 13
        Caption = 'Email'
      end
      object Label7: TLabel
        Left = 51
        Top = 256
        Width = 3
        Height = 13
      end
      object Label5: TLabel
        Left = 20
        Top = 179
        Width = 45
        Height = 13
        Caption = 'Endere'#231'o'
      end
      object Label9: TLabel
        Left = 20
        Top = 141
        Width = 19
        Height = 13
        Caption = 'Cep'
      end
      object Label10: TLabel
        Left = 20
        Top = 221
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object Label11: TLabel
        Left = 177
        Top = 222
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label12: TLabel
        Left = 21
        Top = 262
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label13: TLabel
        Left = 178
        Top = 262
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label14: TLabel
        Left = 255
        Top = 262
        Width = 19
        Height = 13
        Caption = 'Pa'#237's'
      end
      object BtnConsCep: TButton
        Left = 146
        Top = 153
        Width = 75
        Height = 25
        Caption = 'Consulta Cep'
        TabOrder = 0
        OnClick = BtnConsCepClick
      end
      object EdtNome: TEdit
        Left = 17
        Top = 40
        Width = 341
        Height = 21
        TabOrder = 1
      end
      object EdtIdent: TEdit
        Left = 17
        Top = 80
        Width = 133
        Height = 21
        TabOrder = 2
      end
      object EdtCpf: TEdit
        Left = 177
        Top = 80
        Width = 181
        Height = 21
        TabOrder = 3
      end
      object EdtTel: TEdit
        Left = 17
        Top = 118
        Width = 136
        Height = 21
        TabOrder = 4
      end
      object EdtEmail: TEdit
        Left = 177
        Top = 118
        Width = 181
        Height = 21
        TabOrder = 5
      end
      object EdtCep: TEdit
        Left = 17
        Top = 155
        Width = 121
        Height = 21
        TabOrder = 6
      end
      object EdtEnd: TEdit
        Left = 17
        Top = 193
        Width = 342
        Height = 21
        TabOrder = 7
      end
      object EdtCompl: TEdit
        Left = 17
        Top = 235
        Width = 121
        Height = 21
        TabOrder = 8
      end
      object EdtBairro: TEdit
        Left = 175
        Top = 235
        Width = 185
        Height = 21
        TabOrder = 9
      end
      object EdtCid: TEdit
        Left = 17
        Top = 277
        Width = 121
        Height = 21
        TabOrder = 10
      end
      object EdtUf: TEdit
        Left = 175
        Top = 277
        Width = 53
        Height = 21
        TabOrder = 11
      end
      object EdtPais: TEdit
        Left = 250
        Top = 277
        Width = 112
        Height = 21
        TabOrder = 12
      end
      object DBGrid1: TDBGrid
        Left = 17
        Top = 336
        Width = 717
        Height = 120
        DataSource = DsCad
        TabOrder = 13
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 277
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Identidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Width = 223
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Width = 262
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'complemento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'bairro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'estado'
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'pais'
            Visible = True
          end>
      end
      object BitBtn1: TBitBtn
        Left = 400
        Top = 38
        Width = 97
        Height = 25
        Caption = 'Gravar Registro'
        TabOrder = 14
        OnClick = BitBtn1Click
      end
    end
  end
  object CdsCad: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 86
    object CdsCadNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object CdsCadIdentidade: TStringField
      FieldName = 'Identidade'
    end
    object CdsCadtelefone: TStringField
      FieldName = 'telefone'
    end
    object CdsCademail: TStringField
      FieldName = 'email'
      Size = 100
    end
    object CdsCadcep: TStringField
      FieldName = 'cep'
    end
    object CdsCadendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object CdsCadcomplemento: TStringField
      FieldName = 'complemento'
    end
    object CdsCadbairro: TStringField
      FieldName = 'bairro'
    end
    object CdsCadcidade: TStringField
      FieldName = 'cidade'
    end
    object CdsCadestado: TStringField
      FieldName = 'estado'
      Size = 2
    end
    object CdsCadpais: TStringField
      FieldName = 'pais'
    end
  end
  object DsCad: TDataSource
    DataSet = CdsCad
    Left = 472
    Top = 86
  end
end
