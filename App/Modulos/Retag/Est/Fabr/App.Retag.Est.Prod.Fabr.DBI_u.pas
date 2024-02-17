unit App.Retag.Est.Prod.Fabr.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Entidade.Ed.Id.Descr;

type
  TProdFabrDBI = class(TEntDBI)
  private
    FEntIdDescr: IEntIdDescr;
  protected
    function GetSqlPreencherDataSetIdDescr(pStrBusca: string): string; override;
    function GetSqlIdByDescr(pDescr: string): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pId: integer); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntIdDescr: IEntIdDescr);
  end;

implementation

uses System.SysUtils;

{ TProdFabrDBI }

constructor TProdFabrDBI.Create(pDBConnection: IDBConnection;
  pEntIdDescr: IEntIdDescr);
begin
  inherited Create(pDBConnection);
  FEntIdDescr := pEntIdDescr;
end;

function TProdFabrDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT FABRICANTE_ID_GRAVADO FROM FABRICANTE_PA.FABRICANTE_GARANTIR(%d,''%s'');';
  Result := Format(sFormat, [FEntIdDescr.Id, FEntIdDescr.Descr]);
end;

function TProdFabrDBI.GetSqlIdByDescr(pDescr: string): string;
var
  sFormat: string;
begin
  sFormat := 'SELECT FABRICANTE_ID FROM FABRICANTE_PA.BYNOME_GET(''%s'');';
  Result := Format(sFormat, [pDescr]);
end;

function TProdFabrDBI.GetSqlPreencherDataSetIdDescr(pStrBusca: string): string;
var
  sFormat: string;
begin
  sFormat := 'select FABRICANTE_ID, NOME from FABRICANTE_PA.LISTA_GET(''%s'');';
  Result := Format(sFormat, [pStrBusca]);
end;

procedure TProdFabrDBI.SetNovaId(pId: integer);
begin
  inherited;
  FEntIdDescr.Id := pId;
end;

end.
