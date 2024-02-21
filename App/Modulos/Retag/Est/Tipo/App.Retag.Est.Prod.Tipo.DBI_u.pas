unit App.Retag.Est.Prod.Tipo.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Tipo.Ent, Sis.UI.Frame.Bas.FiltroParams_u;

type
  TProdTipoDBI = class(TEntDBI)
  private
    FProdTipoEnt: IProdTipoEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirReg: string; override;
    procedure SetNovaId(pIds: variant); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntEd: IProdTipoEnt);
  end;

implementation

uses System.SysUtils, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Retag.Est.Prod.Tipo.Ent_u, Sis.Types.strings_u;

  { TProdTipoDBI }

constructor TProdTipoDBI.Create(pDBConnection: IDBConnection;
  pEntEd: IProdTipoEnt);
begin
  inherited Create(pDBConnection);
  FProdTipoEnt := TProdTipoEnt(pEntEd);
end;

function TProdTipoDBI.GetSqlGarantirReg: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT PROD_TIPO_ID_GRAVADO'
    + ' FROM PROD_TIPO_PA.PROD_TIPO_GARANTIR(%d,''%s'');';
  Result := Format(sFormat, [FProdTipoEnt.Id, FProdTipoEnt.Descr]);
end;

function TProdTipoDBI.GetSqlGetExistente(pValues: Variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sFormat := 'SELECT PROD_TIPO_ID FROM PROD_TIPO_PA.BYDESCR_GET(''%s'');';
  sDescr := VarToString(pValues[0]);
  Result := Format(sFormat, [sDescr]);
end;

function TProdTipoDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT PROD_TIPO_ID, DESCR FROM PROD_TIPO_PA.LISTA_GET;';
end;

procedure TProdTipoDBI.SetNovaId(pIds: Variant);
begin
  inherited;
  FProdTipoEnt.Id := VarToInteger(pIds);
end;

end.
