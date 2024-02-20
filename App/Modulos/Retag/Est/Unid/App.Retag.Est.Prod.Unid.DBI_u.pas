unit App.Retag.Est.Prod.Unid.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Entidade.Ed.Unid;

type
  TProdFabrDBI = class(TEntDBI)
  private
    FEntUnid: IEntUnid;
  protected
    function GetSqlPreencherDataSetIdDescr(pStrBusca: string): string; override;
    function GetSqlIdByDescr(pDescr: string): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pId: integer); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntUnid: IEntUnid);
  end;

implementation

uses System.SysUtils;

{ TProdFabrDBI }

constructor TProdFabrDBI.Create(pDBConnection: IDBConnection;
  pEntUnid: IEntUnid);
begin
  inherited Create(pDBConnection);
  FEntUnid := pEntUnid;
end;

function TProdFabrDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT UNID_ID_GRAVADA FROM UNID_PA.UNID_GARANTIR('+
    '%d,''%s'',''%s'');';
  Result := Format(sFormat, [FEntUnid.Id, FEntUnid.Descr, FEntUnid.Sigla]);
end;

function TProdFabrDBI.GetSqlIdByDescr(pDescr: string): string;
var
  sFormat: string;
begin
  sFormat := 'SELECT UNID_ID, DESCR, SIGLA'
    + ' FROM UNID_PA.BYDESCR_GET(''%s'',''%s'');';
  Result := Format(sFormat, [pDescr]);
end;

function TProdFabrDBI.GetSqlPreencherDataSetIdDescr(pStrBusca: string): string;
begin

end;

procedure TProdFabrDBI.SetNovaId(pId: integer);
begin
  inherited;

end;

end.
