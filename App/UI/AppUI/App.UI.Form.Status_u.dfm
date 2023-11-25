object StatusForm: TStatusForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'StatusForm'
  ClientHeight = 70
  ClientWidth = 288
  Color = 16744448
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = [fsBold]
  Position = poDesktopCenter
  StyleElements = []
  OnShow = FormShow
  TextHeight = 21
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 288
    Height = 70
    Align = alClient
    Caption = '   '
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 286
      Height = 68
      Align = alClient
      Alignment = taCenter
      Caption = 'Administrador do Sistema Daros'
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
      ExplicitWidth = 246
      ExplicitHeight = 21
    end
  end
end
