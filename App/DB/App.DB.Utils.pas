unit App.DB.Utils;

interface

uses Sis.Config.SisConfig, App.AppInfo, Sis.DB.DBTypes, Data.DB, Sis.Entities.Types;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig): TDBConnectionParams;

function DataSetStateToTitulo(pDataSetState: TDataSetState): string;

implementation

uses Sis.Sis.Constants;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig): TDBConnectionParams;
begin
  if pTerminalId = TERMINAL_ID_NAO_INDICADO then
  begin
    Result.Server := '';
    Result.Arq := '';
    Result.Database := '';
    exit;
  end;

  if pSisConfig.LocalMachineIsServer then
  begin
    if pTerminalId = TERMINAL_ID_RETAGUARDA then
    begin
      Result.Server := pSisConfig.ServerMachineId.Name;
      Result.Arq := pAppInfo.PastaDados + 'RETAG.FDB';
      Result.Database := Result.Server + ':' + Result.Arq;
      exit;
    end;

    Result.Server := ''; // fantando fazer
    Result.Arq := '';
    Result.Database := '';

    exit;
  end;

  if pTerminalId = TERMINAL_ID_RETAGUARDA then// fantando fazer
  begin
    Result.Server := '';
    Result.Arq := '';
    Result.Database := '';
    exit;
  end;

  Result.Server := ''; // fantando fazer
  Result.Arq := '';
  Result.Database := '';
end;

function DataSetStateToTitulo(pDataSetState: TDataSetState): string;
begin
  case pDataSetState of
    dsInactive: Result := 'Inativo';
    dsBrowse: Result := 'Navegando';
    dsEdit: Result := 'Alterando';
    dsInsert: Result := 'Inserindo';
    dsSetKey: ;
    dsCalcFields: ;
    dsFilter: ;
    dsNewValue: ;
    dsOldValue: ;
    dsCurValue: ;
    dsBlockRead: ;
    dsInternalCalc: ;
    dsOpening: ;
    else Result := '';
  end;
end;

end.
