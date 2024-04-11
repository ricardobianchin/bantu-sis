unit App.Retag.Fin.PagForma.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Retag.Fin.PagForma.Ent;

type
  TProdFabrDBI = class(TEntDBI)
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

{ TProdFabrDBI }

constructor TProdFabrDBI.Create(pDBConnection: IDBConnection;
  pPagFormaEnt: IPagFormaEnt);
begin
  inherited Create(pDBConnection);
  FPagFormaEnt := pPagFormaEnt;
end;

function TProdFabrDBI.GetPackageName: string;
begin
  Result := 'PAGAMENTO_FORMA_PA';
end;

function TProdFabrDBI.GetSqlGarantirRegId: string;
begin

end;

function TProdFabrDBI.GetSqlGetExistente(pValues: variant): string;
begin

end;

function TProdFabrDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin

end;

procedure TProdFabrDBI.SetNovaId(pIds: variant);
begin
  inherited;

end;

end.
