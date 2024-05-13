unit App.Retag.Est.Prod.Ent_u;

interface

uses App.Ent.Ed.Id_u, Data.DB, Sis.DB.DBTypes, Sis.Types.Utils_u,
  App.Retag.Est.Prod.Ent, App.Ent.DBI_u, App.Ent.Ed, App.Retag.Est.Factory,
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

    FCustoAtual: double;
    FCustoNovo: double;
    FPrecoAtual: Currency;
    FPrecoNovo: Currency;

    FProdBalancaEnt: IProdBalancaEnt;

    FAtivo: boolean;
    FCapacEmb: Currency;
    FNCM: string;
    FMargem: Currency;
    FLocaliz: string;
    FLojaId: smallint;
    FUsuarioId: integer;
    FMachineIdentId: smallint;

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetProdFabrEnt: IProdFabrEnt;
    function GetProdTipoEnt: IProdTipoEnt;
    function GetProdICMSEnt: IProdICMSEnt;
    function GetProdUnidEnt: IProdUnidEnt;
    function GetProdBarrasList: IProdBarrasList;

    function GetCustoAtual: double;
    procedure SetCustoAtual(Value: double);

    function GetCustoNovo: double;
    procedure SetCustoNovo(Value: double);

    function GetPrecoAtual: Currency;
    procedure SetPrecoAtual(Value: Currency);

    function GetPrecoNovo: Currency;
    procedure SetPrecoNovo(Value: Currency);

    function GetProdBalancaEnt: IProdBalancaEnt;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);

    function GetCapacEmb: Currency;
    procedure SetCapacEmb(Value: Currency);

    function GetNCM:string;
    procedure SetNCM(Value: string);

    function GetLocaliz: string;
    procedure SetLocaliz(Value: string);

    function GetMargem: Currency;
    procedure SetMargem(Value: Currency);
    function GetLojaId: smallint;
    function GetUsuarioId: integer;
    function GetMachineIdentId: smallint;

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

    property CustoAtual: double read GetCustoAtual write SetCustoAtual;
    property CustoNovo: double read GetCustoNovo write SetCustoNovo;
    property PrecoAtual: Currency read GetPrecoAtual write SetPrecoAtual;
    property PrecoNovo: Currency read GetPrecoNovo write SetPrecoNovo;

    property ProdBalancaEnt: IProdBalancaEnt read GetProdBalancaEnt;
    property Ativo: boolean read GetAtivo write SetAtivo;
    property CapacEmb: Currency read GetCapacEmb write SetCapacEmb;
    property NCM: string read GetNCM write SetNCM;
    property Localiz: string read GetLocaliz write SetLocaliz;
    property Margem: Currency read GetMargem write SetMargem;

    property LojaId: smallint read GetLojaId;
    property UsuarioId: integer read GetUsuarioId;
    property MachineIdentId: smallint read GetMachineIdentId;

    procedure LimparEnt; override;

    constructor Create(
      pLojaId: smallint;//
      pUsuarioId: integer;//
      pMachineIdentId: smallint;//

      //
      pProdFabrEnt: IProdFabrEnt; //fabr ent
      pProdTipoEnt: IProdTipoEnt; //
      pProdUnidEnt: IProdUnidEnt; //
      pProdICMSEnt: IProdICMSEnt; //
      //
      pProdBarrasList: IProdBarrasList; // prod barras list
      pProdBalancaEnt: IProdBalancaEnt;//
      //
      pState: TDataSetState = dsBrowse;
      pId: integer = 0; pDescr: string = ''; pDescrRed: string = '');
  end;

implementation

uses System.SysUtils;

// uses Sis.ModuloSistema.Types;

{ TProdEnt }

constructor TProdEnt.Create(
      pLojaId: smallint;//
      pUsuarioId: integer;//
      pMachineIdentId: smallint;//
      //
      pProdFabrEnt: IProdFabrEnt; //fabr ent
      pProdTipoEnt: IProdTipoEnt; //
      pProdUnidEnt: IProdUnidEnt; //
      pProdICMSEnt: IProdICMSEnt; //
      //
      pProdBarrasList: IProdBarrasList; // prod barras list
      pProdBalancaEnt: IProdBalancaEnt;//
      //
      pState: TDataSetState;
      pId: integer; pDescr: string; pDescrRed: string);
begin
  inherited Create(State, pId);
  FLojaId := pLojaId;
  FUsuarioId := pUsuarioId;
  FMachineIdentId := pMachineIdentId;
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

function TProdEnt.GetCustoAtual: double;
begin
  Result := FCustoAtual;
end;

function TProdEnt.GetCustoNovo: double;
begin
  Result := FCustoNovo;
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

function TProdEnt.GetLojaId: smallint;
begin
  Result := FLojaId;
end;

function TProdEnt.GetMachineIdentId: smallint;
begin
  Result := FMachineIdentId;
end;

function TProdEnt.GetMargem: Currency;
begin
  Result := FMargem;
end;

function TProdEnt.GetNCM: string;
begin
  Result := FNCM;
end;

function TProdEnt.GetNomeEnt: string;
begin
  Result := 'Produto';
end;

function TProdEnt.GetNomeEntAbrev: string;
begin
  Result := 'Prod';
end;

function TProdEnt.GetPrecoAtual: Currency;
begin
  Result := FPrecoAtual;
end;

function TProdEnt.GetPrecoNovo: Currency;
begin
  Result := FPrecoNovo;
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

function TProdEnt.GetUsuarioId: integer;
begin
  Result := FUsuarioId;
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

  FCustoAtual := 0;
  FCustoNovo := 0;
  FPrecoAtual := 0;
  FPrecoNovo := 0;

  FProdBalancaEnt.LimparEnt;

  FAtivo := True;
  FCapacEmb := 1;
  FLocaliz := '';
  FMargem := 0;
end;

procedure TProdEnt.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

procedure TProdEnt.SetCapacEmb(Value: Currency);
begin
  FCapacEmb := Value;
end;

procedure TProdEnt.SetCustoAtual(Value: double);
begin
  FCustoAtual := Value;
end;

procedure TProdEnt.SetCustoNovo(Value: double);
begin
  FCustoNovo := Value;
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

procedure TProdEnt.SetMargem(Value: Currency);
begin
  FMargem := Value;
end;

procedure TProdEnt.SetNCM(Value: string);
begin
  FNCM := Trim(Value);
end;

procedure TProdEnt.SetPrecoAtual(Value: Currency);
begin
  FPrecoAtual := Value;
end;

procedure TProdEnt.SetPrecoNovo(Value: Currency);
begin
  FPrecoNovo := Value;
end;

end.
