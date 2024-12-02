inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  ClientWidth = 586
  ExplicitWidth = 602
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 586
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 586
    Height = 17
    Align = alTop
    Font.Height = -13
    ParentFont = False
    WordWrap = True
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 16
    ExplicitHeight = 17
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 586
  end
  inherited BasePanel: TPanel
    Width = 586
    ExplicitWidth = 586
    DesignSize = (
      586
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 163
      ExplicitLeft = 159
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 276
      ExplicitLeft = 272
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 377
      ExplicitLeft = 373
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 17
    Width = 586
    Height = 179
    Align = alClient
    BevelOuter = bvNone
    Caption = '  '
    TabOrder = 1
    ExplicitWidth = 582
    ExplicitHeight = 178
    object CupomPanel: TPanel
      Left = 347
      Top = 0
      Width = 239
      Height = 179
      Align = alRight
      BevelOuter = bvLowered
      Caption = '  '
      TabOrder = 0
      ExplicitLeft = 343
      ExplicitHeight = 178
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 237
        Height = 17
        Align = alTop
        Alignment = taCenter
        Caption = 'CUPOM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        StyleElements = [seClient, seBorder]
        ExplicitWidth = 46
      end
      object CupomListBox: TListBox
        Left = 1
        Top = 18
        Width = 237
        Height = 160
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 15
        Items.Strings = (
          'TESTE DE IMPRESSAO'
          ''
          ''
          'TESTE DE IMPRESSAO'
          ''
          ''
          '--------------'
          '      ---------------'
          '123456789 123456789 123456789 123456789 123456789 ')
        ParentFont = False
        TabOrder = 0
        StyleElements = [seClient, seBorder]
        ExplicitLeft = 136
        ExplicitTop = 96
        ExplicitWidth = 121
        ExplicitHeight = 97
      end
    end
    object TrabPanel: TPanel
      Left = 0
      Top = 0
      Width = 347
      Height = 179
      Align = alClient
      BevelOuter = bvNone
      Caption = '  '
      TabOrder = 1
      ExplicitWidth = 343
      ExplicitHeight = 178
      object ObsPanel: TPanel
        Left = 0
        Top = 96
        Width = 347
        Height = 83
        Align = alBottom
        BevelOuter = bvNone
        Caption = '  '
        TabOrder = 0
        ExplicitTop = 95
        ExplicitWidth = 343
        object Label2: TLabel
          Left = 0
          Top = 0
          Width = 152
          Height = 15
          Align = alTop
          Caption = 'Observa'#231#245'es (200 caracteres)'
        end
        object ObsMemo: TMemo
          Left = 0
          Top = 15
          Width = 347
          Height = 68
          Align = alClient
          BorderStyle = bsNone
          MaxLength = 200
          TabOrder = 0
          WantReturns = False
        end
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 160
  end
  inherited ActionList1_Diag: TActionList
    Left = 152
    Top = 160
  end
end
