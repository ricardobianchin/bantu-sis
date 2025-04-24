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
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      StyleElements = [seClient, seBorder]
    end
    object SimBitBtn: TBitBtn
      Left = 77
      Top = 111
      Width = 102
      Height = 28
      Anchors = [akLeft, akBottom]
      Caption = '&Sim'
      ModalResult = 6
      TabOrder = 0
    end
    object NaoBitBtn: TBitBtn
      Left = 245
      Top = 111
      Width = 102
      Height = 28
      Anchors = [akLeft, akBottom]
      Caption = '&N'#227'o'
      ModalResult = 7
      TabOrder = 1
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 8
    Top = 112
  end
end
