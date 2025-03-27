inherited CxOperUmValorEdForm: TCxOperUmValorEdForm
  Caption = 'CxOperUmValorEdForm'
  ClientHeight = 371
  ClientWidth = 552
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 568
  ExplicitHeight = 410
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 299
    Width = 552
    ExplicitTop = 299
  end
  inherited ObjetivoLabel: TLabel
    Width = 552
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 319
    Width = 552
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 319
  end
  object ObsLabel: TLabel [3]
    Left = 0
    Top = 17
    Width = 552
    Height = 13
    Align = alTop
    Caption = 
      ' '#201' poss'#237'vel escolher entre indicar o valor da opera'#231#227'o OU a quan' +
      'tidade de notas e moedas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    StyleElements = [seClient, seBorder]
    ExplicitWidth = 464
  end
  inherited BasePanel: TPanel
    Top = 334
    Width = 552
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 334
    ExplicitWidth = 552
    DesignSize = (
      552
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 81
      ExplicitLeft = 81
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 194
      ExplicitLeft = 194
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 295
      ExplicitLeft = 295
    end
  end
  inherited MeioPanel: TPanel
    Top = 30
    Width = 552
    Height = 269
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 30
    ExplicitWidth = 552
    ExplicitHeight = 269
    inherited ObsPanel: TPanel
      Top = 186
      Width = 552
      TabOrder = 1
      StyleElements = [seFont, seClient, seBorder]
      ExplicitTop = 186
      ExplicitWidth = 552
      inherited Label2: TLabel
        Width = 552
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited ObsMemo: TMemo
        Width = 552
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 552
      end
    end
    object TrabPageControl: TPageControl
      Left = 0
      Top = 0
      Width = 552
      Height = 186
      ActivePage = ValorTabSheet
      Align = alClient
      TabOrder = 0
      object ValorTabSheet: TTabSheet
        Caption = 'F3 - Indicar o Valor'
        object ValorNumEditBtu: TNumEditBtu
          Left = 64
          Top = 16
          Width = 129
          Height = 28
          AutoExit = True
          Caption = 'Valor R$'
          EditLabel.Width = 55
          EditLabel.Height = 28
          EditLabel.Caption = 'Valor R$'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -15
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          LabelPosition = lpLeft
          LabelSpacing = 5
          ParentFont = False
          ReadOnly = False
          TabOrder = 0
          Text = '0,00'
          OnKeyPress = ValorNumEditBtuKeyPress
          NCasas = 2
          NCasasEsq = 7
          Valor = 0
          MascEsq = '######0'
        end
      end
      object NumerarioTabSheet: TTabSheet
        Caption = 'F4 - Indicar a Quantidade de Notas'
        ImageIndex = 1
      end
    end
  end
end
