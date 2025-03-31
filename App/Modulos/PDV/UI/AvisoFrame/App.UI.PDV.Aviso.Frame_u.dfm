inherited AvisoPDVFrame: TAvisoPDVFrame
  Width = 800
  Height = 600
  ExplicitWidth = 800
  ExplicitHeight = 600
  inherited MeioPanel: TPanel
    Width = 800
    Height = 600
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 600
    object Panel1: TPanel
      Left = 16
      Top = 136
      Width = 569
      Height = 273
      Caption = '   '
      TabOrder = 0
      DesignSize = (
        569
        273)
      object MensagemLabel: TLabel
        Left = 20
        Top = 17
        Width = 529
        Height = 80
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'N'#227'o h'#225' caixa aberto.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Button1: TButton
        Left = 108
        Top = 200
        Width = 168
        Height = 25
        Caption = 'Abrir o Caixa'
        TabOrder = 0
      end
      object GavButton: TButton
        Left = 292
        Top = 200
        Width = 168
        Height = 25
        Caption = 'Abrir Gaveta'
        TabOrder = 1
        OnClick = GavButtonClick
      end
    end
  end
end
