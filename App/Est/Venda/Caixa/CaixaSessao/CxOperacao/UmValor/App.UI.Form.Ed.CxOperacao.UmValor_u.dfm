inherited CxOperUmValorEdForm: TCxOperUmValorEdForm
  Caption = 'CxOperUmValorEdForm'
  ClientHeight = 457
  ClientWidth = 788
  ExplicitWidth = 800
  ExplicitHeight = 495
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 385
    Width = 788
    ExplicitTop = 385
  end
  inherited ObjetivoLabel: TLabel
    Width = 788
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 405
    Width = 788
    ExplicitTop = 405
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
    Top = 420
    Width = 788
    ExplicitTop = 419
    ExplicitWidth = 784
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 321
      ExplicitLeft = 317
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 434
      ExplicitLeft = 430
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 535
      ExplicitLeft = 531
    end
  end
  inherited MeioPanel: TPanel
    Top = 30
    Width = 788
    Height = 355
    ExplicitTop = 30
    ExplicitWidth = 784
    ExplicitHeight = 354
    inherited TrabPanel: TPanel
      Width = 788
      Height = 355
      ExplicitWidth = 784
      ExplicitHeight = 354
      object TrabPageControl: TPageControl [0]
        Left = 0
        Top = 0
        Width = 788
        Height = 272
        ActivePage = ValorTabSheet
        Align = alClient
        TabOrder = 0
        OnChange = TrabPageControlChange
        ExplicitWidth = 784
        ExplicitHeight = 271
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
        Top = 272
        Width = 788
        TabOrder = 1
        ExplicitTop = 271
        ExplicitWidth = 784
        inherited Label2: TLabel
          Width = 788
        end
        inherited ObsMemo: TMemo
          Width = 788
          ExplicitWidth = 784
        end
      end
    end
  end
end
