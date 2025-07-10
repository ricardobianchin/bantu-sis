unit App.DB.Utils;

interface

uses App.AppObj, Sis.DB.DBTypes, Data.DB,
  Sis.Entities.Types, Sis.TerminalList, Sis.Terminal,
  Sis.Entities.Factory;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppObj: IAppObj): TDBConnectionParams;

function DataSetStateToTitulo(pDataSetState: TDataSetState): string;

implementation

uses Sis.Sis.Constants, Sis.DB.Factory, System.SysUtils, App.AppInfo.Types;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppObj: IAppObj): TDBConnectionParams;
begin
  if pTerminalId <= TERMINAL_ID_NAO_INDICADO then
  begin
    Result.Server := '';
    Result.Arq := '';
    Result.Database := '';
    exit;
  end;

  if pTerminalId = TERMINAL_ID_RETAGUARDA then
  begin
    Result.Server := pAppObj.SisConfig.ServerMachineId.Name;
    Result.Arq := pAppObj.AppInfo.PastaDadosServ + //
      'Dados_' + //
      AtividadeEconomicaSisDescr[pAppObj.AppInfo.AtividadeEconomicaSis] + //
      '_Retaguarda.FDB' //
      ;

    Result.Arq[1] := pAppObj.SisConfig.ServerLetraDoDrive;
    Result.Database := Result.Server + ':' + Result.Arq;
    exit;
  end;

  Result.Server := '';
  Result.Arq := '';
  Result.Database := '';
end;

function DataSetStateToTitulo(pDataSetState: TDataSetState): string;
begin
  case pDataSetState of
    dsInactive:
      Result := 'Inativo';
    dsBrowse:
      Result := 'Navegando';
    dsEdit:
      Result := 'Alterando';
    dsInsert:
      Result := 'Inserindo';
    dsSetKey:
      ;
    dsCalcFields:
      ;
    dsFilter:
      ;
    dsNewValue:
      ;
    dsOldValue:
      ;
    dsCurValue:
      ;
    dsBlockRead:
      ;
    dsInternalCalc:
      ;
    dsOpening:
      ;
  else
    Result := '';
  end;
end;

end.
