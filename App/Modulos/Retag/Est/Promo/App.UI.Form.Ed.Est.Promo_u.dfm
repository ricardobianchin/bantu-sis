inherited PromoEdForm: TPromoEdForm
  Caption = 'PromoEdForm'
  ClientHeight = 359
  ClientWidth = 742
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 758
  ExplicitHeight = 398
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 287
    Width = 742
    ExplicitTop = 287
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 307
    Width = 742
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 307
  end
  inherited BasePanel: TPanel
    Top = 322
    Width = 742
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 322
    ExplicitWidth = 742
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 327
      ExplicitLeft = 327
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 440
      ExplicitLeft = 440
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 541
      ExplicitLeft = 541
    end
  end
  object MasterGroupBox: TGroupBox [4]
    Left = 8
    Top = 29
    Width = 726
    Height = 112
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 96
      Width = 653
      Height = 13
      Caption = 
        'Data inicial '#233' obrigat'#243'ria, e a data final '#233' opcional; se n'#227'o pr' +
        'eenchida, a promo'#231#227'o permanecer'#225' vigente at'#233' nova configura'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
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
    object NomeLabeledEdit: TLabeledEdit
      Left = 229
      Top = 18
      Width = 345
      Height = 23
      EditLabel.Width = 33
      EditLabel.Height = 23
      EditLabel.Caption = 'Nome'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 1
      Text = ''
      OnKeyPress = NomeLabeledEditKeyPress
    end
    object AtivoCheckBox: TCheckBox
      Left = 582
      Top = 21
      Width = 71
      Height = 17
      Caption = 'Ativo'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnKeyPress = AtivoCheckBoxKeyPress
    end
  end
  object ItemGroupBox: TGroupBox [5]
    Left = 5
    Top = 152
    Width = 726
    Height = 103
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Item'
    TabOrder = 2
    object PrecoPromoNumEditBtu: TNumEditBtu
      Left = 567
      Top = 24
      Width = 81
      Height = 23
      AutoExit = True
      Caption = 'Pre'#231'o'
      EditLabel.Width = 30
      EditLabel.Height = 23
      EditLabel.Caption = 'Pre'#231'o'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 0
      Text = '0,00'
      NCasas = 2
      NCasasEsq = 9
      Valor = 0
      MascEsq = '########0'
    end
    object ItemAtivoCheckBox: TCheckBox
      Left = 660
      Top = 27
      Width = 71
      Height = 17
      Caption = 'Ativo'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnKeyPress = ItemAtivoCheckBoxKeyPress
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 112
    Top = 8
  end
  inherited ActionList1_Diag: TActionList
    Left = 256
    Top = 8
  end
end
