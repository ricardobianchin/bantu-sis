unit App.SisConfig.DBI_u;

interface

uses App.SisConfig.DBI, Sis.Config.SisConfig, App.AppObj, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TSisConfigDBI = class(TInterfacedObject, ISisConfigDBI)
  private
    FSisConfig: ISisConfig;
    FAppObj: IAppObj;
    FDBMS: IDBMS;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
  public
    procedure LerMachineIdent;
    constructor Create(pAppObj: IAppObj; pDBMS: IDBMS;
      pProcessLog: IProcessLog; pOutput: IOutput);
  end;

implementation

{ TSisConfigDBI }

uses App.DB.Utils, Sis.DB.Factory, Sis.Sis.Constants;

constructor TSisConfigDBI.Create(pAppObj: IAppObj;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create;
  FAppObj := pAppObj;
  FDBMS := pDBMS;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
end;

procedure TSisConfigDBI.LerMachineIdent;
var
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  sSql: string;
  oDBQuery: IDBQuery;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    FAppObj);

  oDBConnection := DBConnectionCreate('TSisConfigDBI.LerMachineIdent.Conn',
    FSisConfig, oDBConnectionParams, FProcessLog, FOutput);

  oDBConnection.Abrir;
  try
    sSql := 'select MACHINE_ID_RET' +
      ' from machine_pa.BYIDENT_GET (:NOME_NA_REDE, :IP);';

    oDBQuery := DBQueryCreate('TSisConfigDBI.LerMachineIdent.Query',
      oDBConnection, sSql, FProcessLog, FOutput);
    oDBQuery.Prepare;
    try
      oDBQuery.Params[0].AsString := FSisConfig.ServerMachineId.Name;
      oDBQuery.Params[1].AsString := FSisConfig.ServerMachineId.IP;
      oDBQuery.Abrir;
      try
        FSisConfig.ServerMachineId.IdentId := oDBQuery.DataSet.Fields[0].AsInteger;
      finally
        oDBQuery.Fechar;
      end;

      oDBQuery.Params[0].AsString := FSisConfig.LocalMachineId.Name;
      oDBQuery.Params[1].AsString := FSisConfig.LocalMachineId.IP;
      oDBQuery.Abrir;
      try
        FSisConfig.LocalMachineId.IdentId := oDBQuery.DataSet.Fields[1].AsInteger;
      finally
        oDBQuery.Fechar;
      end;
    finally
      oDBQuery.Unprepare;
    end;
  finally
    oDBConnection.Fechar;
  end;
end;

end.
