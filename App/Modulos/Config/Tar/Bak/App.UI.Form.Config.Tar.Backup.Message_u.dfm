inherited BackupMessageForm: TBackupMessageForm
  Caption = 'Daros - Backup Iniciado'
  ClientHeight = 361
  ClientWidth = 784
  StyleElements = [seFont, seClient, seBorder]
  ExplicitLeft = -177
  ExplicitTop = -11
  ExplicitWidth = 800
  ExplicitHeight = 400
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 341
    Width = 784
    Visible = False
    ExplicitTop = 242
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 326
    Width = 784
    Visible = False
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 227
  end
  object WebBrowser1: TWebBrowser [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 284
    TabStop = False
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 24
    ExplicitTop = 16
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000075100005A1D00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object BasePanel: TPanel [3]
    Left = 0
    Top = 284
    Width = 784
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 4
    ExplicitTop = 283
    object CopyNamesButton: TButton
      Left = 176
      Top = 8
      Width = 201
      Height = 25
      Caption = 'C - Copiar os Nome dos Arquivos'
      TabOrder = 0
      OnClick = CopyNamesButtonClick
    end
    object PastaExplorarButton: TButton
      Left = 410
      Top = 8
      Width = 164
      Height = 25
      Caption = 'A - Abrir a Pasta'
      TabOrder = 1
      OnClick = PastaExplorarButtonClick
    end
    object FecharButton: TButton
      Left = 608
      Top = 8
      Width = 164
      Height = 25
      Caption = 'Esc - Fechar'
      TabOrder = 2
      OnClick = FecharButtonClick
    end
  end
end
