inherited ActBasForm: TActBasForm
  Caption = 'ActBasForm'
  ExplicitWidth = 636
  ExplicitHeight = 479
  TextHeight = 15
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 32
  end
  object ActionList1_ActBasForm: TActionList
    Images = SisImgDataModule.ImageList_40_24
    Left = 240
    Top = 32
    object FecharAction_ActBasForm: TAction
      Caption = 'FecharAction_ActBasForm'
      Hint = 'Fechar'
      ImageIndex = 0
      OnExecute = FecharAction_ActBasFormExecute
    end
  end
end