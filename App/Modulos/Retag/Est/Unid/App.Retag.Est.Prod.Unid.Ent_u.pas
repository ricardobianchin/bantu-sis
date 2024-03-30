unit App.Retag.Est.Prod.Unid.Ent_u;

interface

uses App.Retag.Est.Prod.Unid.Ent, App.Ent.Ed.Id.Descr_u, Data.DB,
  Sis.DB.DBTypes;

type
  TProdUnidEnt = class(TEntIdDescr, IProdUnidEnt)
  private
    FSigla: string;

    function GetSigla: string;
    procedure SetSigla(Value: string);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    procedure LimparEnt; override;
  public
    property Sigla: string read GetSigla write SetSigla;

    constructor Create(pState: TDataSetState; pId: integer = 0;
      pDescr: string = ''; pSigla: string = '');
  end;

implementation

{ TProdUnidEnt }

constructor TProdUnidEnt.Create(pState: TDataSetState; pId: integer;
  pDescr, pSigla: string);
begin
  inherited Create(State, pId, pDescr);
  FSigla := pSigla;
end;

function TProdUnidEnt.GetNomeEnt: string;
begin
  Result := 'Unidade de Medida';
end;

function TProdUnidEnt.GetNomeEntAbrev: string;
begin
  Result := 'ProdUnid';
end;

function TProdUnidEnt.GetSigla: string;
begin
  Result := FSigla;
end;

function TProdUnidEnt.GetTitulo: string;
begin
  Result := 'Unidades de Medida';
end;

procedure TProdUnidEnt.LimparEnt;
begin
  inherited;
  FSigla := '';
end;

procedure TProdUnidEnt.SetSigla(Value: string);
begin
  FSigla := Value;
end;

end.
