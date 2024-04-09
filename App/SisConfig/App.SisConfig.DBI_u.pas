unit App.SisConfig.DBI_u;

interface

uses App.SisConfig.DBI, Sis.Config.SisConfig, App.AppInfo, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TSisConfigDBI = class(TInterfacedObject, ISisConfigDBI)
  private
    FSisConfig: ISisConfig;
    FAppInfo: IAppInfo;
    FDBMS: IDBMS;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
  public
    procedure LerMachineIdent;
    constructor Create(pSisConfig: ISisConfig; pAppInfo: IAppInfo; pDBMS: IDBMS;
      pProcessLog: IProcessLog; pOutput: IOutput);
  end;

implementation

{ TSisConfigDBI }

uses App.DB.Utils, Sis.DB.Factory;

constructor TSisConfigDBI.Create(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create;
  FSisConfig := pSisConfig;
  FAppInfo := pAppInfo;
  FDBMS := pDBMS;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
end;

procedure TSisConfigDBI.LerMachineIdent;
var
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  sSql: string;
  ODBQuery: IDBQuery;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    FAppInfo, FSisConfig);

  oDBConnection := DBConnectionCreate('TSisConfigDBI.LerMachineIdent.Conn',
    FSisConfig, FDBMS, oDBConnectionParams, FProcessLog, FOutput);

  oDBConnection.Abrir;
  try
    sSql := 'select MACHINE_ID_SERVER_RET, MACHINE_ID_TERMINAL_RET' +
      ' from machine_pa.BYIDENTS_GET (:IDENT_SERVER, :IDENT_TERMINAL);';

    ODBQuery := DBQueryCreate('TSisConfigDBI.LerMachineIdent.Query',
      oDBConnection, sSql, FProcessLog, FOutput);
    ODBQuery.Prepare;
    try
      ODBQuery.Params[0].AsString := FSisConfig.ServerMachineId.GetIdent;
      ODBQuery.Params[1].AsString := FSisConfig.LocalMachineId.GetIdent;
      ODBQuery.Abrir;
      try
        FSisConfig.ServerMachineId.IdentId := ODBQuery.DataSet.Fields[0].AsInteger;
        FSisConfig.LocalMachineId.IdentId := ODBQuery.DataSet.Fields[1].AsInteger;

      finally
        ODBQuery.Fechar;
      end;
    finally
      ODBQuery.Unprepare;
    end;
    // FSisConfig
  finally
    oDBConnection.Fechar;
  end;
end;

end.
