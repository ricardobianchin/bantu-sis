unit App.UI.FormEd.CxOperacao.Desspesa_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Ed.CxOperacao_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, CustomEditBtu, CustomNumEditBtu, NumEditBtu;

type
  TCxOperDespesaEdForm = class(TCxOperacaoEdForm)
    ValorNumEditBtu: TNumEditBtu;
    FornecLabeledEdit: TLabeledEdit;
    FornecComboBox: TComboBox;
    DespTIpoLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CxOperDespesaEdForm: TCxOperDespesaEdForm;

implementation

{$R *.dfm}

end.
