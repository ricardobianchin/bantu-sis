inherited CxOperUmValorEdForm: TCxOperUmValorEdForm
  Caption = 'CxOperUmValorEdForm'
  ClientHeight = 562
  ClientWidth = 788
  ExplicitWidth = 804
  ExplicitHeight = 601
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 490
    Width = 788
    ExplicitTop = 490
  end
  inherited ObjetivoLabel: TLabel
    Width = 788
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 510
    Width = 788
    ExplicitTop = 510
  end
  object ObsLabel: TLabel [3]
    Left = 0
    Top = 17
    Width = 788
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
    Top = 525
    Width = 788
    ExplicitTop = 524
    ExplicitWidth = 784
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 345
      ExplicitLeft = 341
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 458
      ExplicitLeft = 454
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 559
      ExplicitLeft = 555
    end
  end
  inherited MeioPanel: TPanel
    Top = 30
    Width = 788
    Height = 460
    ExplicitTop = 30
    ExplicitWidth = 784
    ExplicitHeight = 459
    inherited CupomPanel: TPanel
      Left = 497
      Width = 291
      Height = 460
      ExplicitLeft = 497
      ExplicitWidth = 291
      ExplicitHeight = 460
      inherited Label1: TLabel
        Width = 289
      end
      inherited CupomListBox: TListBox
        Width = 289
        Height = 441
        ExplicitWidth = 289
        ExplicitHeight = 441
      end
    end
    inherited TrabPanel: TPanel
      Width = 497
      Height = 460
      ExplicitWidth = 545
      ExplicitHeight = 459
      object TrabPageControl: TPageControl [0]
        Left = 0
        Top = 0
        Width = 497
        Height = 406
        ActivePage = ValorTabSheet
        Align = alClient
        TabOrder = 0
        OnChange = TrabPageControlChange
        ExplicitWidth = 545
        ExplicitHeight = 405
        object ValorTabSheet: TTabSheet
          Caption = 'F3 - Indicar o Valor'
          object ValorEdit: TEdit
            Left = 75
            Top = 3
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
      inherited ObsPanel: TPanel
        Top = 406
        Width = 497
        Height = 54
        TabOrder = 1
        ExplicitTop = 405
        ExplicitWidth = 545
        ExplicitHeight = 54
        inherited Label2: TLabel
          Width = 497
        end
        inherited ObsMemo: TMemo
          Width = 497
          Height = 39
          Lines.Strings = (
            
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ' +
              'eiusmod tempor incididunt '
            'ut labore et '
            
              'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerc' +
              'itation ullamco exercit '
            'ati')
          ExplicitWidth = 497
          ExplicitHeight = 39
        end
      end
    end
  end
end
