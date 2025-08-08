inherited MaqNomeEdFrame: TMaqNomeEdFrame
  Width = 322
  Height = 86
  ExplicitWidth = 322
  ExplicitHeight = 86
  object ErroLabel: TLabel
    Left = 0
    Top = 73
    Width = 48
    Height = 13
    Align = alBottom
    Caption = 'ErroLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 322
    Height = 73
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 0
    ExplicitWidth = 300
    ExplicitHeight = 96
    object ObsLabel: TLabel
      Left = 5
      Top = 49
      Width = 264
      Height = 18
      AutoSize = False
      Caption = 'Pelo menos um dos campos deve ser preenchido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object NomeLabeledEdit: TLabeledEdit
      AlignWithMargins = True
      Left = 46
      Top = 23
      Width = 135
      Height = 23
      EditLabel.Width = 33
      EditLabel.Height = 23
      EditLabel.Caption = 'Nome'
      LabelPosition = lpLeft
      LabelSpacing = 4
      MaxLength = 20
      TabOrder = 0
      Text = ''
      OnChange = NomeLabeledEditChange
      OnKeyPress = NomeLabeledEditKeyPress
    end
    object IpLabeledEdit: TLabeledEdit
      AlignWithMargins = True
      Left = 200
      Top = 23
      Width = 112
      Height = 23
      EditLabel.Width = 10
      EditLabel.Height = 23
      EditLabel.Caption = 'IP'
      LabelPosition = lpLeft
      LabelSpacing = 4
      MaxLength = 20
      TabOrder = 1
      Text = ''
      OnChange = IpLabeledEditChange
      OnExit = IpLabeledEditExit
    end
  end
end
