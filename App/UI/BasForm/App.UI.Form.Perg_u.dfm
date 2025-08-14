inherited PergForm: TPergForm
  Caption = 'PergForm'
  ClientHeight = 169
  ClientWidth = 429
  Position = poDesktopCenter
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 445
  ExplicitHeight = 208
  TextHeight = 15
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 429
    Height = 169
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object PerguntaLabel: TLabel
      Left = 9
      Top = 8
      Width = 411
      Height = 108
      Alignment = taCenter
      AutoSize = False
      Caption = 'PerguntaLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      StyleElements = [seClient, seBorder]
    end
    object SimBitBtn: TBitBtn
      Left = 47
      Top = 122
      Width = 111
      Height = 31
      Caption = '&Sim'
      ModalResult = 6
      TabOrder = 0
    end
    object NaoBitBtn: TBitBtn
      Left = 271
      Top = 122
      Width = 111
      Height = 31
      Caption = '&N'#227'o'
      ModalResult = 7
      TabOrder = 1
    end
  end
end
