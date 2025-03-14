unit App.Retag.Fin.DespTipo.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Retag.Fin.DespTipo.Ent;

type
  TDespTipoDBI = class(TEntDBI)
  private
    function GetDespTipo: IDespTipoEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    function GetSqlGetRegsJaExistentes(pValuesArray: variant): string; override;
    function GetSqlGaranteRegERetornaId: string; override;
    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Retag.Fin.Factory;

{ TDespTipoDBI }

function TDespTipoDBI.GetDespTipo: IDespTipoEnt;
begin
  Result := EntEdCastToDespTipoEnt(EntEd);
end;

function TDespTipoDBI.GetPackageName: string;
begin
  Result := 'DESPESA_TIPO_PA';
end;

function TDespTipoDBI.GetSqlForEach(pValues: variant): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat := 'select DESPESA_TIPO_ID, DESCR' +
    ' from DESPESA_TIPO_PA.LISTA_GET(''%s'');';
  sBusca := VarToString(pValues[0]);
  Result := Format(sFormat, [sBusca]);
end;

function TDespTipoDBI.GetSqlGaranteRegERetornaId: string;
var
  sFormat: string;
begin
  sFormat :=
    'SELECT ID_GRAVADO FROM DESPESA_TIPO_PA.GARANTIR(%d,''%s'', %d, %d, %d);';
  Result := Format(sFormat, [GetDespTipo.Id, GetDespTipo.Descr,
    GetDespTipo.LojaId, GetDespTipo.UsuarioId,
    GetDespTipo.MachineIdentId]);
end;

function TDespTipoDBI.GetSqlGetRegsJaExistentes(pValuesArray: variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sFormat := 'SELECT DESPESA_TIPO_ID FROM DESPESA_TIPO_PA.BYDESCR_GET(''%s'');';
  sDescr := VarToString(pValuesArray[0]);
  Result := Format(sFormat, [sDescr]);
end;

procedure TDespTipoDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;
  GetDespTipo.Id := VarToInteger(pNovaId[0]);
end;

end.
