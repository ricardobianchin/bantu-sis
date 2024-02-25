unit App.Retag.Est.Prod.Ent_u;

interface

uses App.Retag.Est.Prod.Ent, App.Ent.Ed.Id_u, Data.DB, Sis.DB.DBTypes,
  Sis.Types.Utils_u;

type
  TProdEnt = class(TEntEdId, IProdEnt)
  private
    FDescr: string;
    FDescrRed: string;
    FFabrId: integer;
    FFabrNome: string;

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    procedure LimparEnt; override;

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetFabrId: integer;
    procedure SetFabrId(Value: integer);

    function GetFabrNome: string;
    procedure SetFabrNome(Value: string);

  public
    property Descr: string read GetDescr write SetDescr;
    property DescrRed: string read GetDescrRed write SetDescrRed;
    property FabrId: integer read GetFabrId write SetFabrId;
    property FabrNome: string read GetFabrNome write SetFabrNome;


    constructor Create(pState: TDataSetState; pId: integer = 0;
    pDescr: string = ''; pDescrRed: string = ''; pFabrId: integer = 0;
    pFabrNome: string = '');
  end;

implementation

//uses Sis.ModuloSistema.Types;

{ TProdEnt }

constructor TProdEnt.Create(pState: TDataSetState; pId: integer = 0;
    pDescr: string = ''; pDescrRed: string = ''; pFabrId: integer = 0;
    pFabrNome: string = '');
begin
  inherited Create(State, pId);
  FDescr := pDescr;
  FDescrRed := pDescrRed;
  FFabrId := pFabrId;
  FFabrNome := pFabrNome;

end;

function TProdEnt.GetDescr: string;
begin
  Result := FDescr;
end;

function TProdEnt.GetDescrRed: string;
begin
  Result := FDescrRed;
end;

function TProdEnt.GetFabrId: integer;
begin
  Result := FFabrId;
end;

function TProdEnt.GetFabrNome: string;
begin
  Result := FFabrNome;
end;

function TProdEnt.GetNomeEnt: string;
begin
  Result := 'Produto';
end;

function TProdEnt.GetNomeEntAbrev: string;
begin
  Result := 'Prod';
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
  FFabrId := 0;
  FFabrNome := '';
end;

procedure TProdEnt.SetDescr(Value: string);
begin
  FDescr := Value;
end;

procedure TProdEnt.SetDescrRed(Value: string);
begin
  FDescrRed := Value;
end;

procedure TProdEnt.SetFabrId(Value: integer);
begin
  FFabrId := Value;
end;

procedure TProdEnt.SetFabrNome(Value: string);
begin
  FFabrNome := Value;
end;

end.
