unit App.Retag.Fin.PagForma.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Retag.Fin.PagForma.Ent;

type
  TPagFormaDBI = class(TEntDBI)
  private
    FPagFormaEnt: IPagFormaEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pIds: variant); override;
    function GetPackageName: string; override;
  public
    constructor Create(pDBConnection: IDBConnection; pPagFormaEnt: IPagFormaEnt);
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Retag.Fin.Factory;

{ TPagFormaDBI }

constructor TPagFormaDBI.Create(pDBConnection: IDBConnection;
  pPagFormaEnt: IPagFormaEnt);
begin
  inherited Create(pDBConnection);
  FPagFormaEnt := pPagFormaEnt;
end;

function TPagFormaDBI.GetPackageName: string;
begin
  Result := 'PAGAMENTO_FORMA_PA';
end;

function TPagFormaDBI.GetSqlGarantirRegId: string;
begin

end;

function TPagFormaDBI.GetSqlGetExistente(pValues: variant): string;
begin

end;

function TPagFormaDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin

end;

procedure TPagFormaDBI.SetNovaId(pIds: variant);
begin
  inherited;

end;

end.
