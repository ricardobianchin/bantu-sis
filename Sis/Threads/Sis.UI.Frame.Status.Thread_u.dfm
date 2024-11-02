inherited ThreadStatusFrame: TThreadStatusFrame
  Height = 69
  Align = alTop
  Color = clRed
  Font.Height = -11
  ParentColor = False
  ParentFont = False
  StyleElements = []
  ExplicitHeight = 69
  inherited TitLabel: TLabel
    Height = 30
    AutoSize = False
    Caption = 'a'#13#10'b'
    StyleElements = []
    ExplicitWidth = 7
    ExplicitHeight = 30
  end
  inherited StatusLabel: TLabel
    Top = 30
    Height = 39
    AutoSize = False
    Caption = 'a'#13#10'b'#13#10'c'
    Font.Height = -11
    ParentFont = False
    StyleElements = []
    ExplicitTop = 30
    ExplicitWidth = 7
    ExplicitHeight = 39
  end
end
