unit App.Retag.Est.Prod.Unid.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Unid.Ent, Sis.UI.Frame.Bas.Filtro_u;

type
  TProdUnidDBI = class(TEntDBI)
  private
    function GetProdUnidEnt: IProdUnidEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    function GetSqlGetRegsJaExistentes(pValuesArray: variant): string; override;
    function GetSqlGaranteRegERetornaId: string; override;
    procedure SetVarArrayToId(pNovaId: Variant); override;
    function GetPackageName: string; override;
  public
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u,
  Sis.Win.Utils_u, Vcl.Dialogs, App.Retag.Est.Factory;

{ TProdUnidDBI }

function TProdUnidDBI.GetPackageName: string;
begin
  Result := 'UNID_PA';
end;

function TProdUnidDBI.GetProdUnidEnt: IProdUnidEnt;
begin
  Result := EntEdCastToProdUnidEnt(EntEd);

end;

function TProdUnidDBI.GetSqlGaranteRegERetornaId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO' +
    ' FROM UNID_PA.GARANTIR(%d,''%s'',''%s'');';
  Result := Format(sFormat, [GetProdUnidEnt.Id, GetProdUnidEnt.Descr,
    GetProdUnidEnt.Sigla]);
end;

function TProdUnidDBI.GetSqlGetRegsJaExistentes(pValuesArray: variant): string;
var
  sFormat: string;
  sDescr: string;
  sSigla: string;
begin
  sDescr := VarToString(pValuesArray[0]);
  sSigla := VarToString(pValuesArray[1]);

  sFormat := 'SELECT UNID_ID_RET, DESCR_RET, SIGLA_RET'
    + ' FROM UNID_PA.EXISTENTES_GET(%d,''%s'',''%s'');';
  Result := Format(sFormat, [GetProdUnidEnt.Id, sDescr, sSigla]);
end;

function TProdUnidDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := 'SELECT UNID_ID, DESCR, SIGLA FROM UNID_PA.LISTA_GET;';
end;

procedure TProdUnidDBI.SetVarArrayToId(pNovaId: Variant);
begin
  inherited;
  GetProdUnidEnt.Id := VarToInteger(pNovaId[0]);
end;

end.
