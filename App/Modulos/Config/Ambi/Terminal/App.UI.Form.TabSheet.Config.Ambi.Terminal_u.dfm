inherited ConfigAmbiTermForm: TConfigAmbiTermForm
  Caption = 'ConfigAmbiTermForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitAuxPanel_BasTabSheet: TPanel
      Height = 21
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      Height = 21
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  object ServFDConnection: TFDConnection
    Left = 384
    Top = 72
  end
end
