inherited ActBasForm: TActBasForm
  Caption = 'ActBasForm'
  ClientWidth = 616
  ExplicitWidth = 628
  ExplicitHeight = 469
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
      Caption = 'Fechar'
      Hint = 'Fechar'
      ImageIndex = 0
      OnExecute = FecharAction_ActBasFormExecute
      OnHint = FecharAction_ActBasFormHint
    end
  end
end
