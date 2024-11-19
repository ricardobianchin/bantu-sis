inherited AppMenuForm: TAppMenuForm
  BorderStyle = bsNone
  Caption = 'AppMenuForm'
  ClientHeight = 395
  ClientWidth = 475
  ExplicitHeight = 395
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 375
    Width = 475
    ExplicitTop = 375
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 360
    Width = 475
    ExplicitTop = 360
  end
  object FundoPanel_AppMenuForm: TPanel [2]
    Left = 0
    Top = 0
    Width = 475
    Height = 360
    Align = alClient
    Caption = ' '
    TabOrder = 0
    object FecharModuloButton_AppMenuForm: TButton
      Left = 248
      Top = 8
      Width = 116
      Height = 25
      Caption = 'F4 - Fechar M'#243'dulo'
      TabOrder = 2
      OnClick = FecharModuloButton_AppMenuFormClick
    end
    object OcultarModuloButton_AppMenuForm: TButton
      Left = 123
      Top = 8
      Width = 120
      Height = 25
      Caption = 'F3 - Ocultar M'#243'dulo'
      TabOrder = 1
      OnClick = OcultarModuloButton_AppMenuFormClick
    end
    object OcultarMenuButton_AppMenuForm: TButton
      Left = 8
      Top = 8
      Width = 111
      Height = 25
      Caption = 'Esc - Ocultar Menu'
      TabOrder = 0
      OnClick = OcultarMenuButton_AppMenuFormClick
    end
  end
end
