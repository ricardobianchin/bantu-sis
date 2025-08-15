unit Sis.DB.Updater.Comando.FB.CreateTableTemporary_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.Updater.Campo.List,
  Sis.DB.DBTypes, Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output;

type
  TComandoFBCreateTableTemporary = class(TComandoFB)
  private
    FNomeTabela: string;
    FCampoList: ICampoList;
    function GetSqlCreateTable: string;
    function GetPKName: string;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string; override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pVersaoDB: integer; pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
      pOutput: IOutput); override;
    function Funcionou: boolean; override;
  end;

implementation

uses Sis.DB.Updater.Factory, Sis.DB.Updater.Campo, Sis.DB.Updater.Constants_u,
  Sis.Types.strings_u, Sis.DB.Firebird.GetSQL_u, System.SysUtils;

{ TComandoFBCreateTableTemporary }

constructor TComandoFBCreateTableTemporary.Create(pVersaoDB: integer;
  pDBConnection: IDBConnection; pUpdaterOperations: IDBUpdaterOperations;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited;
  inherited Create(pVersaoDB, pDBConnection, pUpdaterOperations,
    pProcessLog, pOutput);
  FCampoList := CampoListCreate;
end;

function TComandoFBCreateTableTemporary.Funcionou: boolean;
begin
  Result := True;
end;

function TComandoFBCreateTableTemporary.GetAsSql: string;
begin
  Result := '';
end;

function TComandoFBCreateTableTemporary.GetAsText: string;
begin
  Result := '';
end;

function TComandoFBCreateTableTemporary.GetPKName: string;
begin
  Result := '';
end;

function TComandoFBCreateTableTemporary.GetSqlCreateTable: string;
begin
  Result := '';
end;

procedure TComandoFBCreateTableTemporary.PegarLinhas(var piLin: integer;
  pSL: TStrings);
begin
  inherited;

end;

procedure TComandoFBCreateTableTemporary.PegarObjeto(pNome: string);
begin
  inherited;

end;

end.
