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
        Left = 124
        Top = 5
        Width = 47
        Height = 15
        Caption = 'Natureza'
      end
      object DescrLabeledEdit: TLabeledEdit
        Left = 175
        Top = 25
        Width = 360
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
        Left = 647
        Top = 1
        Width = 150
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
      object FabrIdLabeledEdit: TLabeledEdit
        Left = 24
        Top = 48
        Width = 121
        Height = 23
        EditLabel.Width = 36
        EditLabel.Height = 15
        EditLabel.Caption = 'fabr_id'
        TabOrder = 2
        Text = ''
      end
      object ComboBox1: TComboBox
        Left = 175
        Top = 1
        Width = 125
        Height = 23
        TabOrder = 3
        Text = 'MATERIA-PRIMA'
      end
    end
  end
  inherited ActionList1: TActionList
    Left = 153
    Top = 81
  end
end
