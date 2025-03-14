inherited CxOperUmValorEdForm: TCxOperUmValorEdForm
  Caption = 'CxOperUmValorEdForm'
  ClientHeight = 454
  ClientWidth = 776
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 792
  ExplicitHeight = 493
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 382
    Width = 776
    ExplicitTop = 382
  end
  inherited ObjetivoLabel: TLabel
    Width = 776
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 402
    Width = 776
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 402
  end
  object ObsLabel: TLabel [3]
    Left = 0
    Top = 17
    Width = 776
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
    Top = 417
    Width = 776
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 417
    ExplicitWidth = 776
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 305
      ExplicitLeft = 305
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 418
      ExplicitLeft = 418
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 519
      ExplicitLeft = 519
    end
  end
  inherited MeioPanel: TPanel
    Top = 30
    Width = 776
    Height = 352
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 30
    ExplicitWidth = 776
    ExplicitHeight = 352
    inherited ObsPanel: TPanel
      Top = 269
      Width = 776
      StyleElements = [seFont, seClient, seBorder]
      ExplicitTop = 269
      ExplicitWidth = 776
      inherited Label2: TLabel
        Width = 152
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited ObsMemo: TMemo
        Width = 776
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 776
      end
    end
    object TrabPageControl: TPageControl
      Left = 0
      Top = 0
      Width = 776
      Height = 269
      ActivePage = ValorTabSheet
      Align = alClient
      TabOrder = 1
      object ValorTabSheet: TTabSheet
        Caption = 'F3 - Indicar o Valor'
        object ValorEdit: TEdit
          Left = 75
          Top = 11
          Width = 81
          Height = 29
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '12345.65'
          StyleElements = [seClient, seBorder]
        end
      end
      object NumerarioTabSheet: TTabSheet
        Caption = 'F4 - Indicar a Quantidade de Notas'
        ImageIndex = 1
      end
    end
  end
end
