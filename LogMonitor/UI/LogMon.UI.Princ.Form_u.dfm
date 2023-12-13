inherited LogMonForm: TLogMonForm
  Caption = 'LogMonForm'
  ClientWidth = 726
  ExplicitWidth = 738
  ExplicitHeight = 479
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 726
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 620
    object ArqLabeledEdit: TLabeledEdit
      Left = 8
      Top = 20
      Width = 621
      Height = 23
      EditLabel.Width = 78
      EditLabel.Height = 15
      EditLabel.Caption = 'Arquivo de log'
      TabOrder = 0
      Text = 
        'C:\Pr\app\bantu\bantu-sis\Exe\Tmp\ProcessLog\2023\12\12\ShopPrin' +
        'cForm 2023-12-12_19-24-11.processlog.txt'
    end
    object Button1: TButton
      Left = 633
      Top = 19
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object StringGrid1: TStringGrid [1]
    Left = 0
    Top = 51
    Width = 726
    Height = 390
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 64
    ExplicitTop = 160
    ExplicitWidth = 320
    ExplicitHeight = 120
  end
end
