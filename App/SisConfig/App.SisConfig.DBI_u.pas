unit App.SisConfig.DBI_u;

interface

uses App.SisConfig.DBI, Sis.Config.SisConfig, App.AppObj, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TSisConfigDBI = class(TInterfacedObject, ISisConfigDBI)
  private
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
    FAppObj.SisConfig, oDBConnectionParams, FProcessLog, FOutput);

  oDBConnection.Abrir;
  try
    sSql := 'select MACHINE_ID_RET' +
      ' from machine_pa.BYIDENT_GET (:NOME_NA_REDE, :IP);';

    oDBQuery := DBQueryCreate('TSisConfigDBI.LerMachineIdent.Query',
      oDBConnection, sSql, FProcessLog, FOutput);

    FAppObj.CriticalSections.DB.Acquire;
    oDBQuery.Prepare;
    try
      oDBQuery.Params[0].AsString := FAppObj.SisConfig.ServerMachineId.Name;
      oDBQuery.Params[1].AsString := FAppObj.SisConfig.ServerMachineId.IP;
      oDBQuery.Abrir;
      try
        FAppObj.SisConfig.ServerMachineId.IdentId := oDBQuery.DataSet.Fields[0].AsInteger;
      finally
        oDBQuery.Fechar;
      end;

      oDBQuery.Params[0].AsString := FAppObj.SisConfig.LocalMachineId.Name;
      oDBQuery.Params[1].AsString := FAppObj.SisConfig.LocalMachineId.IP;
      oDBQuery.Abrir;
      try
        FAppObj.SisConfig.LocalMachineId.IdentId := oDBQuery.DataSet.Fields[0].AsInteger;
      finally
        oDBQuery.Fechar;
      end;
    finally
      oDBQuery.Unprepare;
      FAppObj.CriticalSections.DB.Release;
    end;
  finally
    oDBConnection.Fechar;
  end;
end;

end.
