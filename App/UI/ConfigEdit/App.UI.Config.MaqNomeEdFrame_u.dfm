object MaqNomeEdFrame: TMaqNomeEdFrame
  Left = 0
  Top = 0
  Width = 279
  Height = 109
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  StyleElements = [seFont, seBorder]
  object ErroLabel: TLabel
    Left = 0
    Top = 96
    Width = 279
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
    StyleElements = [seBorder]
    ExplicitWidth = 48
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 279
    Height = 96
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 0
    object ObsLabel: TLabel
      Left = 9
      Top = 70
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
      Left = 9
      Top = 39
      Width = 135
      Height = 25
      EditLabel.Width = 36
      EditLabel.Height = 17
      EditLabel.Caption = 'Nome'
      MaxLength = 20
      TabOrder = 0
      Text = ''
      OnChange = NomeLabeledEditChange
      OnKeyPress = NomeLabeledEditKeyPress
    end
    object IpLabeledEdit: TLabeledEdit
      AlignWithMargins = True
      Left = 150
      Top = 39
      Width = 106
      Height = 25
      EditLabel.Width = 10
      EditLabel.Height = 17
      EditLabel.Caption = 'IP'
      MaxLength = 20
      TabOrder = 1
      Text = ''
      OnChange = IpLabeledEditChange
      OnExit = IpLabeledEditExit
    end
  end
end
