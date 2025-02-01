inherited ToolsDBAtuForm: TToolsDBAtuForm
  Caption = 'Tools - DB Atualizador'
  ClientHeight = 301
  ClientWidth = 379
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 391
  ExplicitHeight = 339
  DesignSize = (
    379
    301)
  TextHeight = 15
  object ApresLabel: TLabel [0]
    Left = 6
    Top = 5
    Width = 307
    Height = 15
    Caption = 'Esta ferramenta atualiza o banco de dados caso necess'#225'rio'
  end
  object StatusMemo: TMemo [1]
    Left = 6
    Top = 128
    Width = 365
    Height = 135
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object BancosListBox: TListBox [2]
    Left = 6
    Top = 28
    Width = 366
    Height = 93
    ItemHeight = 15
    TabOrder = 1
  end
  object ExecutarButton: TButton [3]
    Left = 275
    Top = 269
    Width = 97
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Executar'
    TabOrder = 2
    OnClick = ExecutarButtonClick
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 120
    Top = 56
  end
end
