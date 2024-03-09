inherited ObrigatoriosProdEdFrame: TObrigatoriosProdEdFrame
  Width = 800
  Height = 171
  ExplicitWidth = 800
  ExplicitHeight = 171
  inherited FundoPanel: TPanel
    Width = 800
    Height = 171
    ExplicitWidth = 800
    ExplicitHeight = 171
    inherited TopoPanel: TPanel
      Width = 798
      ExplicitWidth = 798
    end
    inherited MeioPanel: TPanel
      Width = 798
      Height = 150
      ExplicitTop = 20
      ExplicitWidth = 798
      ExplicitHeight = 150
      object NatuLabel: TLabel
        Left = 113
        Top = 6
        Width = 47
        Height = 15
        Caption = 'Natureza'
      end
      object DescrLabeledEdit: TLabeledEdit
        Left = 59
        Top = 28
        Width = 406
        Height = 23
        EditLabel.Width = 51
        EditLabel.Height = 23
        EditLabel.Caption = 'Descri'#231#227'o'
        LabelPosition = lpLeft
        LabelSpacing = 4
        MaxLength = 120
        TabOrder = 0
        Text = ''
        OnChange = DescrLabeledEditChange
        OnKeyPress = DescrLabeledEditKeyPress
      end
      object DescrRedLabeledEdit: TLabeledEdit
        Left = 581
        Top = 28
        Width = 194
        Height = 23
        EditLabel.Width = 102
        EditLabel.Height = 23
        EditLabel.Caption = 'Descri'#231#227'o Reduzida'
        LabelPosition = lpLeft
        MaxLength = 29
        TabOrder = 1
        Text = ''
        OnChange = DescrRedLabeledEditChange
        OnKeyPress = DescrRedLabeledEditKeyPress
      end
      object NatuComboBox: TComboBox
        Left = 164
        Top = 2
        Width = 119
        Height = 23
        TabOrder = 2
      end
    end
  end
  inherited ActionList1: TActionList
    Left = 153
    Top = 81
  end
end
