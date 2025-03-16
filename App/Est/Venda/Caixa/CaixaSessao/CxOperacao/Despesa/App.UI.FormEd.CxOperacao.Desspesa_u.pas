unit App.UI.FormEd.CxOperacao.Desspesa_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.CxOperacao_u, App.Ent.Ed, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, CustomEditBtu, App.Ent.DBI,
  CustomNumEditBtu, NumEditBtu, App.AppObj, App.Est.Venda.Caixa.CxValor.DBI;

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
    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI); reintroduce; virtual;
  end;

var
  CxOperDespesaEdForm: TCxOperDespesaEdForm;

implementation

{$R *.dfm}
{ TCxOperDespesaEdForm }

constructor TCxOperDespesaEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI);
begin
  inherited Create(AOwner, pAppObj, pUsuarioId, pUsuarioNomeExib,
    pEntEd, pEntDBI);
  // FNumerarioListFrame := TNumerarioListFrame.Create(NumerarioTabSheet,
  // pCxValorDBI, AppObj.AppInfo.PastaImg + 'App\Numerario\Indiv\');
  //
  // NumerarioTabSheet.TabVisible := False;
end;

end.
