object DiagForm: TDiagForm
  Left = 0
  Top = 0
  Caption = 'DiagForm'
  ClientHeight = 210
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    587
    210)
  TextHeight = 15
  object ErroLabel: TLabel
    Left = 8
    Top = 192
    Width = 49
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'ErroLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
  end
  object OkButton: TButton
    Left = 376
    Top = 168
    Width = 75
    Height = 25
    Action = OkAction
    Anchors = [akRight, akBottom]
    TabOrder = 0
  end
  object CancButton: TButton
    Left = 488
    Top = 168
    Width = 75
    Height = 25
    Action = CancAction
    Anchors = [akRight, akBottom]
    TabOrder = 1
  end
  object ActionList1: TActionList
    Left = 200
    Top = 144
    object OkAction: TAction
      Caption = 'Ok'
      OnExecute = OkActionExecute
    end
    object CancAction: TAction
      Caption = 'Cancelar'
      OnExecute = CancActionExecute
    end
  end
end
