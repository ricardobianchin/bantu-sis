unit App.Retag.Est.Prod.Tipo.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Tipo.Ent;

type
  TProdTipoDBI = class(TEntDBI)
  private
    function GetProdTipoEnt: IProdTipoEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGaranteRegRetId: string; override;
    procedure SetVarArrayToId(pNovaId: Variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Retag.Est.Factory;

  { TProdTipoDBI }

function TProdTipoDBI.GetPackageName: string;
begin
  Result := 'PROD_TIPO_PA';
end;

function TProdTipoDBI.GetProdTipoEnt: IProdTipoEnt;
begin
  Result := EntEdCastToProdTipoEnt(EntEd);
end;

function TProdTipoDBI.GetSqlGaranteRegRetId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO'
    + ' FROM PROD_TIPO_PA.GARANTIR(%d,''%s'');';

  Result := Format(sFormat, [GetProdTipoEnt.Id, GetProdTipoEnt.Descr]);
end;

function TProdTipoDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sDescr := VarToString(pValues);

  sFormat := 'SELECT PROD_TIPO_ID FROM PROD_TIPO_PA.BYDESCR_GET(''%s'');';
  Result := Format(sFormat, [sDescr]);
end;

function TProdTipoDBI.GetSqlPreencherDataSet(pValues: variant): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat := 'SELECT PROD_TIPO_ID, DESCR FROM PROD_TIPO_PA.LISTA_GET(''%s'');';
  sBusca := VarToString(pValues);
  Result := Format(sFormat, [sBusca]);
end;

procedure TProdTipoDBI.SetVarArrayToId(pNovaId: Variant);
begin
  inherited;
  GetProdTipoEnt.Id := VarToInteger(pNovaId[0]);
end;

end.
