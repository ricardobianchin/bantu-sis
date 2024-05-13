object FileSelectLabeledEditFrame: TFileSelectLabeledEditFrame
  Left = 0
  Top = 0
  Width = 526
  Height = 24
  TabOrder = 0
  object MeioPanel: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 24
    Align = alClient
    BevelOuter = bvNone
    Caption = '   '
    TabOrder = 0
    DesignSize = (
      526
      24)
    object SpeedButton1: TSpeedButton
      Left = 501
      Top = 0
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      ImageIndex = 3
      Images = SisImgDataModule.ImageList16Flat
      OnClick = SpeedButton1Click
      ExplicitLeft = 585
    end
    object NomeArqLabeledEdit: TLabeledEdit
      Left = 101
      Top = 1
      Width = 400
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 95
      EditLabel.Height = 23
      EditLabel.Caption = 'Nome do Arquivo'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 0
      Text = ''
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.txt|*.txt|*.*|*.*'
    Title = 'Selecione o Arquivo...'
    Left = 160
    Top = 8
  end
end
