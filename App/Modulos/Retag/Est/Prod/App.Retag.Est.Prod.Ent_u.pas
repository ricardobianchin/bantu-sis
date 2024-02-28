unit App.Retag.Est.Prod.Ent_u;

interface

uses App.Ent.Ed.Id_u, Data.DB, Sis.DB.DBTypes,
  Sis.Types.Utils_u, App.Retag.Est.Prod.Ent, App.Retag.Est.Prod.Fabr.Ent;

type
  TProdEnt = class(TEntEdId, IProdEnt)
  private
    FDescr: string;
    FDescrRed: string;
    FProdFabrEnt: IProdFabrEnt;

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    procedure LimparEnt; override;

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetProdFabrEnt: IProdFabrEnt;
  public
    property Descr: string read GetDescr write SetDescr;
    property DescrRed: string read GetDescrRed write SetDescrRed;

    property ProdFabrEnt: IProdFabrEnt read GetProdFabrEnt;

    constructor Create(pState: TDataSetState; pProdFabrEnt: IProdFabrEnt;
      pId: integer = 0; pDescr: string = ''; pDescrRed: string = '');
  end;

implementation

// uses Sis.ModuloSistema.Types;

{ TProdEnt }

constructor TProdEnt.Create(pState: TDataSetState; pProdFabrEnt: IProdFabrEnt;
  pId: integer = 0; pDescr: string = ''; pDescrRed: string = '');
begin
  inherited Create(State, pId);
  FDescr := pDescr;
  FDescrRed := pDescrRed;

  FProdFabrEnt := pProdFabrEnt;
end;

function TProdEnt.GetDescr: string;
begin
  Result := FDescr;
end;

function TProdEnt.GetDescrRed: string;
begin
  Result := FDescrRed;
end;

function TProdEnt.GetNomeEnt: string;
begin
  Result := 'Produto';
end;

function TProdEnt.GetNomeEntAbrev: string;
begin
  Result := 'Prod';
end;

function TProdEnt.GetProdFabrEnt: IProdFabrEnt;
begin
  Result := FProdFabrEnt;
end;

function TProdEnt.GetTitulo: string;
begin
  Result := 'Produtos';
end;

procedure TProdEnt.LimparEnt;
begin
  inherited;
  FDescr := '';
  FDescrRed := '';
  FProdFabrEnt.LimparEnt;
end;

procedure TProdEnt.SetDescr(Value: string);
begin
  FDescr := Value;
end;

procedure TProdEnt.SetDescrRed(Value: string);
begin
  FDescrRed := Value;
end;

end.
