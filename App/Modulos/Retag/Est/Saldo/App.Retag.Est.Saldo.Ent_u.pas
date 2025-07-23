unit App.Retag.Est.Saldo.Ent_u;

interface

uses App.Ent.Ed.Id_u, App.Retag.Est.Saldo.Ent, App.Retag.Est.Prod.Fabr.Ent,
  Data.DB, Sis.Types, Sis.Entities.Types //

    , App.Retag.Est.Prod.Tipo.Ent //
    , App.Retag.Est.Prod.Unid.Ent //
    , App.Retag.Est.Prod.Icms.Ent //
    , App.Retag.Est.Prod.Barras.Ent.List //
    , App.Retag.Est.Prod.Balanca.Ent, Sis.Usuario //
    ;

type
  TRetagSaldoEnt = class(TEntEdId, IRetagSaldoEnt)
  private
    FLojaId: TLojaId;
    FDescr: string;
    FDescrRed: string;
    FProdFabrEnt: IProdFabrEnt;
    FProdTipoEnt: IProdTipoEnt;
    FProdUnidEnt: IProdUnidEnt;
    FProdICMSEnt: IProdICMSEnt;
    FProdBarrasList: IProdBarrasList;
    FCustoUnit: Double;
    FCustoTot: Double;
    FPrecoUnit: Currency;
    FPrecoTotal: Currency;
    FProdBalancaEnt: IProdBalancaEnt;
    FAtivo: Boolean;
    FLocaliz: string;
    FCapacEmb: Currency;

    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetProdFabrEnt: IProdFabrEnt;
    function GetProdTipoEnt: IProdTipoEnt;
    function GetProdUnidEnt: IProdUnidEnt;
    function GetProdICMSEnt: IProdICMSEnt;
    function GetProdBarrasList: IProdBarrasList;

    function GetCustoUnit: Double;
    procedure SetCustoUnit(Value: Double);

    function GetCustoTot: Double;
    procedure SetCustoTot(Value: Double);

    function GetPrecoUnit: Currency;
    procedure SetPrecoUnit(Value: Currency);

    function GetPrecoTotal: Currency;
    procedure SetPrecoTotal(Value: Currency);

    function GetProdBalancaEnt: IProdBalancaEnt;

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);

    function GetLocaliz: string;
    procedure SetLocaliz(Value: string);

    function GetCapacEmb: Currency;
    procedure SetCapacEmb(Value: Currency);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property LojaId: TLojaId read GetLojaId write SetLojaId;
    property Descr: string read GetDescr write SetDescr;
    property DescrRed: string read GetDescrRed write SetDescrRed;
    property ProdFabrEnt: IProdFabrEnt read GetProdFabrEnt;
    property ProdTipoEnt: IProdTipoEnt read GetProdTipoEnt;
    property ProdUnidEnt: IProdUnidEnt read GetProdUnidEnt;
    property ProdICMSEnt: IProdICMSEnt read GetProdICMSEnt;
    property ProdBarrasList: IProdBarrasList read GetProdBarrasList;
    property CustoUnit: Double read GetCustoUnit write SetCustoUnit;
    property CustoTot: Double read GetCustoTot write SetCustoTot;
    property PrecoUnit: Currency read GetPrecoUnit write SetPrecoUnit;
    property PrecoTotal: Currency read GetPrecoTotal write SetPrecoTotal;
    property ProdBalancaEnt: IProdBalancaEnt read GetProdBalancaEnt;
    property Ativo: Boolean read GetAtivo write SetAtivo;
    property Localiz: string read GetLocaliz write SetLocaliz;
    property CapacEmb: Currency read GetCapacEmb write SetCapacEmb;

    procedure LimparEnt; override;

    constructor Create( //
      pLojaId: TLojaId;
      pProdFabrEnt: IProdFabrEnt; // fabr
      pProdTipoEnt: IProdTipoEnt; // fabr
      pProdUnidEnt: IProdUnidEnt; // fabr
      pProdBarrasList: IProdBarrasList; // prod barras list
      pProdBalancaEnt: IProdBalancaEnt; //
      //
      pState: TDataSetState = dsBrowse;
      // campos
      pId: integer = 0; pDescr: string = ''; pDescrRed: string = '');
  end;

implementation

{ TRetagSaldoEnt }

function TRetagSaldoEnt.GetDescr: string;
begin
  Result := FDescr;
end;

procedure TRetagSaldoEnt.SetDescr(Value: string);
begin
  FDescr := Value;
end;

function TRetagSaldoEnt.GetDescrRed: string;
begin
  Result := FDescrRed;
end;

procedure TRetagSaldoEnt.SetDescrRed(Value: string);
begin
  FDescrRed := Value;
end;

function TRetagSaldoEnt.GetProdFabrEnt: IProdFabrEnt;
begin
  Result := FProdFabrEnt;
end;

function TRetagSaldoEnt.GetProdTipoEnt: IProdTipoEnt;
begin
  Result := FProdTipoEnt;
end;

function TRetagSaldoEnt.GetProdUnidEnt: IProdUnidEnt;
begin
  Result := FProdUnidEnt;
end;

function TRetagSaldoEnt.GetTitulo: string;
begin
  Result := 'Saldo';
end;

procedure TRetagSaldoEnt.LimparEnt;
begin
  inherited;
  FDescr := '';
  FDescrRed := '';

  FProdFabrEnt.LimparEnt;
  FProdTipoEnt.LimparEnt;
  FProdUnidEnt.LimparEnt;
  FProdICMSEnt.LimparEnt;
  FProdBarrasList.Clear;

  FCustoUnit := 0;
  FCustoTot := 0;
  FPrecoUnit := 0;
  FPrecoTotal := 0;

  FProdBalancaEnt.LimparEnt;

  FAtivo := True;
  FCapacEmb := 1;
  FLocaliz := '';
end;

function TRetagSaldoEnt.GetProdICMSEnt: IProdICMSEnt;
begin
  Result := FProdICMSEnt;
end;

function TRetagSaldoEnt.GetProdBarrasList: IProdBarrasList;
begin
  Result := FProdBarrasList;
end;

function TRetagSaldoEnt.GetCustoUnit: Double;
begin
  Result := FCustoUnit;
end;

procedure TRetagSaldoEnt.SetCustoUnit(Value: Double);
begin
  FCustoUnit := Value;
end;

function TRetagSaldoEnt.GetCustoTot: Double;
begin
  Result := FCustoTot;
end;

procedure TRetagSaldoEnt.SetCustoTot(Value: Double);
begin
  FCustoTot := Value;
end;

function TRetagSaldoEnt.GetPrecoUnit: Currency;
begin
  Result := FPrecoUnit;
end;

procedure TRetagSaldoEnt.SetPrecoUnit(Value: Currency);
begin
  FPrecoUnit := Value;
end;

function TRetagSaldoEnt.GetPrecoTotal: Currency;
begin
  Result := FPrecoTotal;
end;

procedure TRetagSaldoEnt.SetPrecoTotal(Value: Currency);
begin
  FPrecoTotal := Value;
end;

function TRetagSaldoEnt.GetProdBalancaEnt: IProdBalancaEnt;
begin
  Result := FProdBalancaEnt;
end;

constructor TRetagSaldoEnt.Create(
  pLojaId: TLojaId;
  pProdFabrEnt: IProdFabrEnt;
  pProdTipoEnt: IProdTipoEnt; pProdUnidEnt: IProdUnidEnt;
  pProdBarrasList: IProdBarrasList; pProdBalancaEnt: IProdBalancaEnt;
  pState: TDataSetState; pId: integer; pDescr, pDescrRed: string);
begin
  inherited Create(State, pId);
  FLojaId := pLojaId;
  FDescr := pDescr;
  FDescrRed := pDescrRed;

  FProdFabrEnt := pProdFabrEnt;
  FProdTipoEnt := pProdTipoEnt;
  FProdUnidEnt := pProdUnidEnt;
  FProdBarrasList := pProdBarrasList;
  FProdBalancaEnt := pProdBalancaEnt;
end;

function TRetagSaldoEnt.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

procedure TRetagSaldoEnt.SetAtivo(Value: Boolean);
begin
  FAtivo := Value;
end;

function TRetagSaldoEnt.GetLocaliz: string;
begin
  Result := FLocaliz;
end;

function TRetagSaldoEnt.GetLojaId: TLojaId;
begin
  Result := FLojaId;
end;

function TRetagSaldoEnt.GetNomeEnt: string;
begin
  Result := 'RetagSaldo';
end;

function TRetagSaldoEnt.GetNomeEntAbrev: string;
begin
  Result := 'SAL';
end;

procedure TRetagSaldoEnt.SetLocaliz(Value: string);
begin
  FLocaliz := Value;
end;

procedure TRetagSaldoEnt.SetLojaId(Value: TLojaId);
begin
  FLojaId := Value;
end;

function TRetagSaldoEnt.GetCapacEmb: Currency;
begin
  Result := FCapacEmb;
end;

procedure TRetagSaldoEnt.SetCapacEmb(Value: Currency);
begin
  FCapacEmb := Value;
end;

end.
