unit App.DB.Utils;

interface

uses Sis.Config.SisConfig, App.AppInfo, Sis.DB.DBTypes;

type
  TLocalDoDB = (ldbNaoIndicado, ldbServidor, ldbTerminal);

const
  LocalDBDescr: array [TLocalDoDB] of string = ('NAOINDICADO', 'SERVIDOR',
    'TERMINAL');

function LocalDoDBToDBConnectionParams(pLocalDoDB: TLocalDoDB;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig): TDBConnectionParams;

implementation

function LocalDoDBToDBConnectionParams(pLocalDoDB: TLocalDoDB;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig): TDBConnectionParams;
begin
  if pLocalDoDB = ldbNaoIndicado then
  begin
    Result.Server := '';
    Result.Arq := '';
    Result.Database := '';
    exit;
  end;

  if pSisConfig.LocalMachineIsServer then
  begin
    if pLocalDoDB = ldbServidor then
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

  if pLocalDoDB = ldbServidor then// fantando fazer
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

end.
