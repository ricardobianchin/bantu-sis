object Thr1Form: TThr1Form
  Left = 0
  Top = 0
  Caption = 'Thr1Form'
  ClientHeight = 269
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object StatusLabel1: TLabel
    Left = 8
    Top = 8
    Width = 66
    Height = 15
    Caption = 'StatusLabel1'
  end
  object StatusLabel2: TLabel
    Left = 8
    Top = 24
    Width = 60
    Height = 15
    Caption = 'StatusLabel'
  end
  object Button1: TButton
    Left = 224
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorHome = 'C:\Program Files (x86)\Firebird\Firebird_5_0'
    VendorLib = 'fbclient.dll'
    Left = 256
    Top = 136
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 120
    Top = 40
  end
end
