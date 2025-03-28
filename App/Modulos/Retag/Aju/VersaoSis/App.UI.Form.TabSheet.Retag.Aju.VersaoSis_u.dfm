inherited RetagAjuVersaoSisForm: TRetagAjuVersaoSisForm
  Caption = 'RetagAjuVersaoSisForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  object RichEdit1: TRichEdit [1]
    Left = 0
    Top = 21
    Width = 632
    Height = 456
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
end
