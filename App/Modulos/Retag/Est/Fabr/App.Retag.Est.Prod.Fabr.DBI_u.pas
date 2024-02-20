unit App.Retag.Est.Prod.Fabr.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Fabr.Ent, Sis.UI.Frame.Bas.FiltroParams_u;

type
  TProdFabrDBI = class(TEntDBI)
  private
    FProdFabrEnt: IProdFabrEnt;
  protected
    function GetSqlPreencherDataSet(pFiltroParamsFrame: TFiltroParamsFrame): string; override;
    function GetSqlIdByDescr(pDescr: string): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pId: integer); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntEd: IProdFabrEnt);
  end;

implementation

uses System.SysUtils, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Retag.Est.Prod.Fabr.Ent_u;

{ TProdFabrDBI }

constructor TProdFabrDBI.Create(pDBConnection: IDBConnection;
  pEntEd: IProdFabrEnt);
begin
  inherited Create(pDBConnection);
  FProdFabrEnt := TProdFabrEnt(pEntEd);
end;

function TProdFabrDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT FABRICANTE_ID_GRAVADO FROM FABRICANTE_PA.FABRICANTE_GARANTIR(%d,''%s'');';
  Result := Format(sFormat, [FProdFabrEnt.Id, FProdFabrEnt.Descr]);
end;

function TProdFabrDBI.GetSqlIdByDescr(pDescr: string): string;
var
  sFormat: string;
begin
  sFormat := 'SELECT FABRICANTE_ID FROM FABRICANTE_PA.BYNOME_GET(''%s'');';
  Result := Format(sFormat, [pDescr]);
end;

function TProdFabrDBI.GetSqlPreencherDataSet(pFiltroParamsFrame: TFiltroParamsFrame): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat := 'select FABRICANTE_ID, NOME from FABRICANTE_PA.LISTA_GET(''%s'');';
  sBusca := TFiltroParamsStringFrame(pFiltroParamsFrame).BuscaString;
  Result := Format(sFormat, [sBusca]);
end;

procedure TProdFabrDBI.SetNovaId(pId: integer);
begin
  inherited;
  FProdFabrEnt.Id := pId;
end;

end.
