unit App.Retag.Fin.PagForma.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Retag.Fin.PagForma.Ent;

type
  TPagFormaDBI = class(TEntDBI)
  private
    function GetPagFormaEnt: IPagFormaEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pId: variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Retag.Fin.Factory;

{ TPagFormaDBI }

function TPagFormaDBI.GetPackageName: string;
begin
  Result := 'PAGAMENTO_FORMA_PA';
end;

function TPagFormaDBI.GetPagFormaEnt: IPagFormaEnt;
begin
  Result := EntEdCastToPagFormaEnt(EntEd);
end;

function TPagFormaDBI.GetSqlGarantirRegId: string;
begin

end;

function TPagFormaDBI.GetSqlGetExistente(pValues: variant): string;
begin

end;

function TPagFormaDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT'
    +' FORMA_ID' //ID_SHORT_DOM
    +', FORMA_TIPO_DESCR' //NOME_INTERM_DOM
    +', DESCR' //NOME_INTERM_DOM
    +', DESCR_RED' //CHAR(8)
    +', PARA_VENDA' //BOOLEAN
    +', ATIVO' //BOOLEAN
    +' FROM PAGAMENTO_FORMA_PA.LISTA_GET;'
    ;
end;

procedure TPagFormaDBI.SetNovaId(pId: variant);
begin
  inherited;

end;

end.
