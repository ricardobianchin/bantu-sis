unit App.Retag.Est.Prod.Tipo.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Ent.Ed.Id.Descr;

type
  TProdTipoDBI = class(TEntDBI)
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


{ TProdTipoDBI }

constructor TProdTipoDBI.Create(pDBConnection: IDBConnection;
  pEntIdDescr: IEntIdDescr);
begin
  inherited Create(pDBConnection);
  FEntIdDescr := pEntIdDescr;
end;

function TProdTipoDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT PROD_TIPO_ID_GRAVADO FROM PROD_TIPO_PA.PROD_TIPO_GARANTIR(%d,''%s'');';
  Result := Format(sFormat, [FEntIdDescr.Id, FEntIdDescr.Descr]);
end;

function TProdTipoDBI.GetSqlIdByDescr(pDescr: string): string;
var
  sFormat: string;
begin
  sFormat := 'SELECT PROD_TIPO_ID FROM PROD_TIPO_PA.BYDESCR_GET(''%s'');';
  Result := Format(sFormat, [pDescr]);
end;

function TProdTipoDBI.GetSqlPreencherDataSetIdDescr(pStrBusca: string): string;
var
  sFormat: string;
begin
  sFormat := 'select PROD_TIPO_ID, DESCR from PROD_TIPO_PA.LISTA_GET(''%s'');';
  Result := Format(sFormat, [pStrBusca]);
end;

procedure TProdTipoDBI.SetNovaId(pId: integer);
begin
  inherited;
  FEntIdDescr.Id := pId;
end;

end.
