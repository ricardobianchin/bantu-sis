object TabDefaultForm: TTabDefaultForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Bem-vindo!'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 67
    Height = 17
    Caption = 'Novidades'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Black'
    Font.Style = []
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 32
    Width = 545
    Height = 353
    Lines.Strings = (
      'Nesta vers'#226'o'
      ''
      '- Alterado tamanho de letra do Felat'#225'rio de vendas'
      '- Corrigido erro ao conectar ao email da Yahoo')
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
    StyleElements = []
  end
end
