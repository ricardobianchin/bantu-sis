unit App.Retag.Est.Prod.ICMS.Ent_u;

interface

uses App.Retag.Est.Prod.ICMS.Ent, App.Ent.Ed.Id_u, Data.DB, Sis.DB.DBTypes,
  Sis.Types.Utils_u;

type
  TProdICMSEnt = class(TEntEdId, IProdICMSEnt)
  private
    FSigla: string;
    FDescr: string;
    FPerc: currency;
    FAtivo: Boolean;

    function GetSigla: string;
    procedure SetSigla(Value: string);

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetPerc: currency;
    procedure SetPerc(Value: currency);

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    procedure LimparEnt; override;
  public
    property Sigla: string read GetSigla write SetSigla;
    property Descr: string read GetDescr write SetDescr;
    property Perc: currency read GetPerc write SetPerc;
    property Ativo: Boolean read GetAtivo write SetAtivo;

    constructor Create(pState: TDataSetState; pId: integer = 0;
      pSigla: string = ''; pDescr: string = ''; pPerc: currency = 0.0;
      pAtivo: Boolean = True);
  end;

implementation

{ TProdICMSEnt }

//uses Sis.ModuloSistema.Types;

constructor TProdICMSEnt.Create(pState: TDataSetState; pId: integer;
  pSigla, pDescr: string; pPerc: currency; pAtivo: Boolean);
begin
  inherited Create(State, pId);
  FSigla := pSigla;
  FDescr := pDescr;
  FPerc := pPerc;
  FAtivo := pAtivo;
end;

function TProdICMSEnt.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

function TProdICMSEnt.GetDescr: string;
begin
  Result := FDescr;
end;

function TProdICMSEnt.GetNomeEnt: string;
begin
  Result := 'Tributação de ICMS';
end;

function TProdICMSEnt.GetNomeEntAbrev: string;
begin
  Result := 'ProdIcms';
end;

function TProdICMSEnt.GetPerc: currency;
begin
  Result := FPerc;
end;

function TProdICMSEnt.GetSigla: string;
begin
  Result := FSigla;
end;

function TProdICMSEnt.GetTitulo: string;
begin
  Result := 'Tributações de ICMS';
end;

procedure TProdICMSEnt.LimparEnt;
begin
  inherited;
  FSigla := '';
  FDescr := '';
  FPerc := ZERO_CURRENCY;
  FAtivo := True;
end;

procedure TProdICMSEnt.SetAtivo(Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TProdICMSEnt.SetDescr(Value: string);
begin
  FDescr := Value;
end;

procedure TProdICMSEnt.SetPerc(Value: currency);
begin
  FPerc := Value;
end;

procedure TProdICMSEnt.SetSigla(Value: string);
begin
  FSigla := Value;
end;

end.
