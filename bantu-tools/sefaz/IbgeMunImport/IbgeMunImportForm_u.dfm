object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Importa planilha da sefaz'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    628
    442)
  TextHeight = 15
  object ArqLabeledEdit: TLabeledEdit
    Left = 8
    Top = 32
    Width = 562
    Height = 23
    EditLabel.Width = 89
    EditLabel.Height = 15
    EditLabel.Caption = 'Planilha do Excel'
    TabOrder = 0
    Text = '\\VBOXSVR\d_drive\Doc\sefaz\DTB_2022\MUNICIPIOs.csv'
    OnKeyPress = ArqLabeledEditKeyPress
  end
  object ArqSelectButton: TButton
    Left = 576
    Top = 32
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = ArqSelectButtonClick
  end
  object ImportarButton: TButton
    Left = 520
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Importar'
    TabOrder = 2
    OnClick = ImportarButtonClick
  end
  object StatusMemo: TMemo
    Left = 8
    Top = 104
    Width = 501
    Height = 330
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    ExplicitWidth = 497
    ExplicitHeight = 329
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.csv|*.csv|*.txt|*.txt|*.xls|*.xls|*.*|*.*'
    Title = 'Indique o arquivo do Excel...'
    Left = 544
    Top = 120
  end
end
