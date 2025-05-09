inherited EstSaidaEdForm: TEstSaidaEdForm
  Caption = 'EstSaidaEdForm'
  ClientHeight = 229
  ClientWidth = 702
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 718
  ExplicitHeight = 268
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 157
    Width = 702
    ExplicitTop = 157
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 177
    Width = 702
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 177
  end
  inherited BasePanel: TPanel
    Top = 192
    Width = 702
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 192
    ExplicitWidth = 702
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 287
      ExplicitLeft = 287
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 400
      ExplicitLeft = 400
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 501
      ExplicitLeft = 501
    end
  end
  inherited NotaGroupBox: TGroupBox
    Top = 27
    Height = 49
    ExplicitTop = 27
    ExplicitHeight = 49
    object SaidaMotivoLabel: TLabel [0]
      Left = 192
      Top = 21
      Width = 38
      Height = 15
      Caption = 'Motivo'
    end
    object SaidaMotivoComboBox: TComboBox
      Left = 236
      Top = 18
      Width = 418
      Height = 23
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 1
      OnChange = SaidaMotivoComboBoxChange
      OnKeyPress = SaidaMotivoComboBoxKeyPress
    end
  end
  inherited ItemGroupBox: TGroupBox
    Top = 83
    Height = 55
    ExplicitTop = 83
    ExplicitHeight = 55
    inherited QtdNumEditBtu: TNumEditBtu
      Text = '1,000'
      OnChange = QtdNumEditBtuChange
      OnKeyPress = QtdNumEditBtuKeyPress
      Valor = '1'
    end
  end
end
