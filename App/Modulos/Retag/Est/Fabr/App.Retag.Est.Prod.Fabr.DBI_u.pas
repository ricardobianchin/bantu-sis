unit App.Retag.Est.Prod.Fabr.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Retag.Est.Prod.Fabr.Ent;

type
  TProdFabrDBI = class(TEntDBI)
  private
    function GetFabrEnt: IProdFabrEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    function GetSqlGetRegsJaExistentes(pValuesArray: variant): string; override;
    function GetSqlGaranteRegERetornaId: string; override;
    procedure SetVarArrayToId(pNovaId: Variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Retag.Est.Factory;

{ TProdFabrDBI }

function TProdFabrDBI.GetFabrEnt: IProdFabrEnt;
begin
  Result := EntEdCastToProdFabrEnt(EntEd);
end;

function TProdFabrDBI.GetPackageName: string;
begin
  Result := 'FABR_PA';
end;

function TProdFabrDBI.GetSqlGaranteRegERetornaId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO FROM FABR_PA.GARANTIR(%d,''%s'');';
  Result := Format(sFormat, [GetFabrEnt.Id, GetFabrEnt.Descr]);
end;

function TProdFabrDBI.GetSqlGetRegsJaExistentes(pValuesArray: variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sFormat := 'SELECT FABR_ID FROM FABR_PA.BYNOME_GET(''%s'');';
  sDescr := VarToString(pValuesArray[0]);
  Result := Format(sFormat, [sDescr]);
end;

function TProdFabrDBI.GetSqlForEach(pValues: variant): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat := 'select FABR_ID, NOME from FABR_PA.LISTA_GET(''%s'');';
  sBusca := VarToString(pValues[0]);
  Result := Format(sFormat, [sBusca]);
end;

procedure TProdFabrDBI.SetVarArrayToId(pNovaId: Variant);
begin
  inherited;
  GetFabrEnt.Id := VarToInteger(pNovaId[0]);
end;

end.
