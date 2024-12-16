inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  ClientHeight = 266
  ClientWidth = 582
  ExplicitWidth = 598
  ExplicitHeight = 305
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 194
    Width = 582
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 582
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
    Top = 214
    Width = 582
  end
  inherited BasePanel: TPanel
    Top = 229
    Width = 582
    ExplicitWidth = 590
    DesignSize = (
      582
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 155
      ExplicitLeft = 159
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 268
      ExplicitLeft = 272
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 369
      ExplicitLeft = 373
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 17
    Width = 582
    Height = 177
    Align = alClient
    BevelOuter = bvNone
    Caption = '  '
    TabOrder = 1
    object CupomPanel: TPanel
      Left = 343
      Top = 0
      Width = 239
      Height = 177
      Align = alRight
      BevelOuter = bvLowered
      Caption = '  '
      TabOrder = 0
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
        Height = 158
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
      end
    end
    object TrabPanel: TPanel
      Left = 0
      Top = 0
      Width = 343
      Height = 177
      Align = alClient
      BevelOuter = bvNone
      Caption = '  '
      TabOrder = 1
      ExplicitWidth = 347
      ExplicitHeight = 180
      object ObsPanel: TPanel
        Left = 0
        Top = 96
        Width = 347
        Height = 83
        Align = alBottom
        BevelOuter = bvNone
        Caption = '  '
        TabOrder = 0
        ExplicitTop = 97
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
