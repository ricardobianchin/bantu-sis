unit App.Config.Ambi.Factory_u;

interface

uses App.UI.Form.TabSheet.Config.Ambi.Terminal_u, Data.DB, Sis.DB.DBTypes,
  Vcl.StdCtrls, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, System.Classes, App.UI.Form.Bas.Ed_u, Sis.Usuario,
  Sis.UI.Controls.ComboBoxManager, App.AppObj,
  App.UI.FormCreator.TabSheet_u, Sis.UI.FormCreator,
  App.Config.Ambi.Terminal.DBI, Sis.Terminal.DBI;

function TerminalFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;

function ConfigAmbiTerminalDBIMudoCreate: IConfigAmbiTerminalDBI;
function ConfigAmbiTerminalDBIGravaCreate(pDBConnection: IDBConnection;
  pUsuarioAdmin: IUsuario; pAppObj: IAppObj; pTerminalDBI: ITerminalDBI)
  : IConfigAmbiTerminalDBI;

implementation

uses App.Config.Ambi.Terminal.DBI.Mudo_u, App.Config.Ambi.Terminal.DBI.Grava_u;

function TerminalFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;
begin
  Result := TTabSheetFormCreator.Create(TConfigAmbiTermForm, 'Terminal',
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog,
    pOutputNotify, pAppObj);
end;

function ConfigAmbiTerminalDBIMudoCreate: IConfigAmbiTerminalDBI;
begin
  Result := TConfigAmbiTerminalDBIMudo.Create;
end;

function ConfigAmbiTerminalDBIGravaCreate(pDBConnection: IDBConnection;
  pUsuarioAdmin: IUsuario; pAppObj: IAppObj; pTerminalDBI: ITerminalDBI)
  : IConfigAmbiTerminalDBI;
begin
  Result := TConfigAmbiTerminalDBIGrava.Create(pDBConnection,
    pUsuarioAdmin, pAppObj, pTerminalDBI);
end;

end.
