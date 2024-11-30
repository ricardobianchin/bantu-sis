unit App.UI.Form.Ed.CxOperacao_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI;

type
  TCxOperacaoEdForm = class(TEdBasForm)
  private
    { Private declarations }
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure AjusteTabOrder; virtual;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  CxOperacaoEdForm: TCxOperacaoEdForm;

implementation

{$R *.dfm}
{ TCxOperacaoEdForm }

procedure TCxOperacaoEdForm.AjusteControles;
begin
  inherited;

end;

procedure TCxOperacaoEdForm.AjusteTabOrder;
begin

end;

function TCxOperacaoEdForm.ControlesOk: boolean;
begin

end;

procedure TCxOperacaoEdForm.ControlesToEnt;
begin
  inherited;

end;

constructor TCxOperacaoEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);

end;

function TCxOperacaoEdForm.DadosOk: boolean;
begin

end;

procedure TCxOperacaoEdForm.EntToControles;
begin
  inherited;

end;

function TCxOperacaoEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := EntEd.NomeEnt;
  sVal := '';

//  sFormat := '%s %s: %s';
//  Result := Format(sFormat, [sTit, sNom, sVal]);
  Result := sNom;
end;

function TCxOperacaoEdForm.GravouOk: boolean;
begin

end;

end.
