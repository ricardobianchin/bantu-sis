inherited EstEdBasForm: TEstEdBasForm
  Caption = 'EstEdBasForm'
  ClientHeight = 333
  ClientWidth = 704
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 720
  ExplicitHeight = 372
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 261
    Width = 704
    ExplicitTop = 261
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 281
    Width = 704
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 281
  end
  inherited BasePanel: TPanel
    Top = 296
    Width = 704
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 296
    ExplicitWidth = 704
    DesignSize = (
      704
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 289
      ExplicitLeft = 289
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 402
      ExplicitLeft = 402
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 503
      ExplicitLeft = 503
    end
  end
  object NotaGroupBox: TGroupBox [4]
    Left = 8
    Top = 32
    Width = 688
    Height = 105
    Caption = 'Nota'
    TabOrder = 1
    object CodLabeledEdit: TLabeledEdit
      Left = 48
      Top = 18
      Width = 137
      Height = 23
      ParentCustomHint = False
      Color = clBtnFace
      EditLabel.Width = 39
      EditLabel.Height = 23
      EditLabel.Caption = 'C'#243'digo'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 0
      Text = ''
      StyleElements = []
    end
  end
  object ItemGroupBox: TGroupBox [5]
    Left = 8
    Top = 152
    Width = 688
    Height = 103
    Caption = 'Item'
    TabOrder = 2
    object QtdNumEditBtu: TNumEditBtu
      Left = 567
      Top = 24
      Width = 81
      Height = 23
      AutoExit = True
      Caption = 'Quantidade'
      EditLabel.Width = 62
      EditLabel.Height = 23
      EditLabel.Caption = 'Quantidade'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 0
      Text = '0,000'
      NCasas = 3
      NCasasEsq = 9
      Valor = 0
      MascEsq = '########0'
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 40
    Top = 80
  end
  inherited ActionList1_Diag: TActionList
    Left = 160
    Top = 104
  end
end
