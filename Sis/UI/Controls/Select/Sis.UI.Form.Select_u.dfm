inherited SelectForm: TSelectForm
  BorderStyle = bsNone
  Caption = 'SelectForm'
  ClientHeight = 347
  ClientWidth = 633
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 633
  ExplicitHeight = 347
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 327
    Width = 633
    ExplicitTop = 327
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 312
    Width = 633
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 312
  end
  object FundoPanel: TPanel [2]
    Left = 0
    Top = 0
    Width = 633
    Height = 312
    Align = alClient
    Caption = ' '
    TabOrder = 0
    object BasePanel: TPanel
      Left = 1
      Top = 282
      Width = 631
      Height = 29
      Align = alBottom
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      StyleElements = [seClient, seBorder]
      ExplicitTop = 252
      DesignSize = (
        631
        29)
      object QtdRegsLabel: TLabel
        Left = 621
        Top = 0
        Width = 9
        Height = 15
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '   '
      end
      object ToolsPanel_SelectForm: TPanel
        Left = 8
        Top = 0
        Width = 353
        Height = 29
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 0
        object ToolBar1_SelectForm: TToolBar
          Left = 0
          Top = 0
          Width = 272
          Height = 38
          Align = alNone
          ButtonHeight = 21
          ButtonWidth = 81
          Caption = 'ToolBar1_SelectForm'
          List = True
          ShowCaptions = True
          TabOrder = 0
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            Action = AtuAction
            AutoSize = True
          end
        end
      end
    end
  end
  object ActionList1_SelectForm: TActionList
    Left = 312
    Top = 32
    object AtuAction: TAction
      Caption = 'F5 - Atualizar'
      OnExecute = AtuActionExecute
    end
  end
end
