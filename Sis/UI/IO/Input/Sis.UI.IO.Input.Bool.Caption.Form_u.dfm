inherited InputBoolCaptionForm: TInputBoolCaptionForm
  Caption = 'InputBoolCaptionForm'
  ClientHeight = 149
  ClientWidth = 424
  Position = poDesktopCenter
  StyleElements = [seFont, seClient, seBorder]
  OnKeyPress = FormKeyPress
  ExplicitWidth = 440
  ExplicitHeight = 188
  TextHeight = 15
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 424
    Height = 149
    Align = alClient
    Caption = ' '
    TabOrder = 0
    ExplicitLeft = 136
    ExplicitTop = 64
    ExplicitWidth = 185
    ExplicitHeight = 41
    DesignSize = (
      424
      149)
    object PerguntaLabel: TLabel
      Left = 12
      Top = 16
      Width = 400
      Height = 73
      Alignment = taCenter
      AutoSize = False
      Caption = 'Deseja fechar o Modulo Retaguarda?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      StyleElements = [seClient, seBorder]
    end
    object SimBitBtn: TBitBtn
      Left = 91
      Top = 113
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Sim'
      ModalResult = 6
      TabOrder = 0
      StyleName = 'Luna'
      ExplicitTop = 383
    end
    object NaoBitBtn: TBitBtn
      Left = 259
      Top = 113
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&N'#227'o'
      ModalResult = 7
      TabOrder = 1
      StyleName = 'Luna'
      ExplicitTop = 383
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 8
    Top = 112
  end
end
