object ExibirPausaF: TExibirPausaF
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'ExibirPausaF'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object GeralPanel: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    Align = alClient
    Caption = ' '
    TabOrder = 0
    object TopoPanel: TPanel
      Left = 1
      Top = 1
      Width = 638
      Height = 64
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      object DlgTypeLabel: TLabel
        Left = 24
        Top = 24
        Width = 84
        Height = 17
        Caption = 'DlgTypeLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object MensagemMemo: TMemo
      Left = 136
      Top = 88
      Width = 449
      Height = 273
      ReadOnly = True
      TabOrder = 1
    end
    object BasePanel: TPanel
      Left = 1
      Top = 432
      Width = 638
      Height = 47
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 2
      object Button1: TButton
        Left = 496
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Fechar'
        ModalResult = 8
        TabOrder = 0
      end
    end
  end
end
