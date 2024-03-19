unit App.Retag.Est.Prod.Ent_u;

interface

uses App.Ent.Ed.Id_u, Data.DB, Sis.DB.DBTypes,
  Sis.Types.Utils_u, App.Retag.Est.Prod.Ent,
  App.Ent.DBI_u, App.Ent.Ed, App.Retag.Est.Factory,
  App.Retag.Est.Prod.Barras.Ent.List
  //
  , App.Retag.Est.Prod.Fabr.Ent//
  , App.Retag.Est.Prod.Tipo.Ent//
  , App.Retag.Est.Prod.Unid.Ent//
  , App.Retag.Est.Prod.ICMS.Ent//
  , App.Retag.Est.Prod.Balanca.Ent//

  //
  ;

type
  TProdEnt = class(TEntEdId, IProdEnt)
  private
    FDescr: string;
    FDescrRed: string;

    FProdFabrEnt: IProdFabrEnt;
    FProdTipoEnt: IProdTipoEnt;
    FProdUnidEnt: IProdUnidEnt;
    FProdICMSEnt: IProdICMSEnt;
    FProdBarrasList: IProdBarrasList;
    FProdBalancaEnt: IProdBalancaEnt;

    FAtivo: boolean;
    FCapacEmb: Currency;
    FLocaliz: string;

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetProdFabrEnt: IProdFabrEnt;
    function GetProdTipoEnt: IProdTipoEnt;
    function GetProdICMSEnt: IProdICMSEnt;
    function GetProdUnidEnt: IProdUnidEnt;
    function GetProdBarrasList: IProdBarrasList;
    function GetProdBalancaEnt: IProdBalancaEnt;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);

    function GetCapacEmb: Currency;
    procedure SetCapacEmb(Value: Currency);

    function GetLocaliz: string;
    procedure SetLocaliz(Value: string);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property Descr: string read GetDescr write SetDescr;
    property DescrRed: string read GetDescrRed write SetDescrRed;

    property ProdFabrEnt: IProdFabrEnt read GetProdFabrEnt;
    property ProdTipoEnt: IProdTipoEnt read GetProdTipoEnt;
    property ProdUnidEnt: IProdUnidEnt read GetProdUnidEnt;
    property ProdICMSEnt: IProdICMSEnt read GetProdICMSEnt;
    property ProdBarrasList: IProdBarrasList read GetProdBarrasList;
    property ProdBalancaEnt: IProdBalancaEnt read GetProdBalancaEnt;
    property Ativo: boolean read GetAtivo write SetAtivo;
    property CapacEmb: Currency read GetCapacEmb write SetCapacEmb;
    property Localiz: string read GetLocaliz write SetLocaliz;

    procedure LimparEnt; override;

    constructor Create(
      pProdFabrEnt: IProdFabrEnt; //fabr ent
      pProdTipoEnt: IProdTipoEnt; //
      pProdUnidEnt: IProdUnidEnt; //
      pProdICMSEnt: IProdICMSEnt; //
      pProdBarrasList: IProdBarrasList; // prod barras list
      pProdBalancaEnt: IProdBalancaEnt;//
      //
      pState: TDataSetState = dsBrowse;
      pId: integer = 0; pDescr: string = ''; pDescrRed: string = '');
  end;

implementation

// uses Sis.ModuloSistema.Types;

{ TProdEnt }

constructor TProdEnt.Create(
      pProdFabrEnt: IProdFabrEnt; //fabr ent
      pProdTipoEnt: IProdTipoEnt; //
      pProdUnidEnt: IProdUnidEnt; //
      pProdICMSEnt: IProdICMSEnt; //
      pProdBarrasList: IProdBarrasList; // prod barras list
      pProdBalancaEnt: IProdBalancaEnt;//
      //
      pState: TDataSetState;
      pId: integer; pDescr: string; pDescrRed: string);
begin
  inherited Create(State, pId);
  FDescr := pDescr;
  FDescrRed := pDescrRed;

  FProdFabrEnt := pProdFabrEnt;
  FProdTipoEnt := pProdTipoEnt;
  FProdUnidEnt := pProdUnidEnt;
  FProdICMSEnt := pProdICMSEnt;
  FProdBarrasList := pProdBarrasList;
  FProdBalancaEnt := pProdBalancaEnt;
end;

function TProdEnt.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

function TProdEnt.GetCapacEmb: Currency;
begin
  Result := FCapacEmb;
end;

function TProdEnt.GetDescr: string;
begin
  Result := FDescr;
end;

function TProdEnt.GetDescrRed: string;
begin
  Result := FDescrRed;
end;

function TProdEnt.GetLocaliz: string;
begin
  Result := FLocaliz;
end;

function TProdEnt.GetNomeEnt: string;
begin
  Result := 'Produto';
end;

function TProdEnt.GetNomeEntAbrev: string;
begin
  Result := 'Prod';
end;

function TProdEnt.GetProdBalancaEnt: IProdBalancaEnt;
begin
  Result := FProdBalancaEnt;
end;

function TProdEnt.GetProdBarrasList: IProdBarrasList;
begin
  Result := FProdBarrasList;
end;

function TProdEnt.GetProdFabrEnt: IProdFabrEnt;
begin
  Result := FProdFabrEnt;
end;

function TProdEnt.GetProdICMSEnt: IProdICMSEnt;
begin
  Result := FProdICMSEnt;
end;

function TProdEnt.GetProdTipoEnt: IProdTipoEnt;
begin
  Result := FProdTipoEnt;
end;

function TProdEnt.GetProdUnidEnt: IProdUnidEnt;
begin
  Result := FProdUnidEnt;
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
  FProdTipoEnt.LimparEnt;
  FProdUnidEnt.LimparEnt;
  FProdICMSEnt.LimparEnt;
  FProdBarrasList.Clear;
  FProdBalancaEnt.LimparEnt;
end;

procedure TProdEnt.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

procedure TProdEnt.SetCapacEmb(Value: Currency);
begin
  FCapacEmb := Value;
end;

procedure TProdEnt.SetDescr(Value: string);
begin
  FDescr := Value;
end;

procedure TProdEnt.SetDescrRed(Value: string);
begin
  FDescrRed := Value;
end;

procedure TProdEnt.SetLocaliz(Value: string);
begin
  FLocaliz := Value;
end;

end.
