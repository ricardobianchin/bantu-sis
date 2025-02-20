inherited CxOperUmValorEdForm: TCxOperUmValorEdForm
  Caption = 'CxOperUmValorEdForm'
  ClientHeight = 456
  ClientWidth = 784
  ExplicitWidth = 796
  ExplicitHeight = 494
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 384
    Width = 784
    ExplicitTop = 384
  end
  inherited ObjetivoLabel: TLabel
    Width = 784
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 404
    Width = 784
    ExplicitTop = 404
  end
  object ObsLabel: TLabel [3]
    Left = 0
    Top = 17
    Width = 784
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
    Top = 419
    Width = 784
    ExplicitTop = 418
    ExplicitWidth = 780
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 309
      ExplicitLeft = 305
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 422
      ExplicitLeft = 418
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 523
      ExplicitLeft = 519
    end
  end
  inherited MeioPanel: TPanel
    Top = 30
    Width = 784
    Height = 354
    ExplicitTop = 30
    ExplicitWidth = 780
    ExplicitHeight = 353
    inherited ObsPanel: TPanel
      Top = 271
      Width = 784
      ExplicitTop = 271
      ExplicitWidth = 784
      inherited Label2: TLabel
        Width = 784
      end
      inherited ObsMemo: TMemo
        Width = 784
        ExplicitWidth = 784
      end
    end
    object TrabPageControl: TPageControl
      Left = 0
      Top = 0
      Width = 784
      Height = 271
      ActivePage = ValorTabSheet
      Align = alClient
      TabOrder = 1
      ExplicitTop = 8
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
