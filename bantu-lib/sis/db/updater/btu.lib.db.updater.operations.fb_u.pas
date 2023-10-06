unit btu.lib.db.updater.operations.fb_u;

interface

uses btu.lib.db.updater.operations, btu.lib.db.types, btu.sis.ui.io.log,
  btu.sis.ui.io.output, System.Classes;

type
  TDBUpdaterOperationsFB = class(TInterfacedObject, IDBUpdaterOperations)
  private
    FDBQueryTabelaExiste: IDBQuery;
    FDBQueryIndexNames: IDBQuery;
    FDBQueryProcedureExiste: IDBQuery;

    FDBQueryPackageGetCodigo: IDBQuery;

    FDBQueryVersaoGet: IDBQuery;
    FDBExecHistIns: IDBExec;

  public
    function TabelaExiste(pNomeTabela: string): boolean;
    function GetIndexFieldNames(pIndexName: string): string;
    function ProcedureExiste(pProcedureName: string): boolean;

    procedure PackagePegarCodigo(pPackageName: string; out pCabec: string; out pBody: string);

    function VersaoGet: integer;
    procedure HistIns(pNum: integer; pAssunto, pObjetivo, pObs: string);

    procedure PreparePrincipais;
    procedure PrepareVersoes;
    procedure Unprepare;

    constructor Create(pDBConnection: IDBConnection; pLog: ILog;
      pOutput: IOutput);
  end;

implementation

uses btu.lib.db.factory, btu.lib.db.updater.firebird.GetSql_u, System.SysUtils;

{ TDBUpdateOperationsFB }

constructor TDBUpdaterOperationsFB.Create(pDBConnection: IDBConnection; pLog: ILog;
  pOutput: IOutput);
var
  s: string;
begin
  s := GetSQLTabelaExisteParams;
  FDBQueryTabelaExiste := DBQueryCreate(pDBConnection, s, pLog, pOutput);

  s := GetSQLIndexNamesParams;
  FDBQueryIndexNames := DBQueryCreate(pDBConnection, s, pLog, pOutput);

  s := GetSQLProcedureExisteParams;
  FDBQueryProcedureExiste := DBQueryCreate(pDBConnection, s, pLog, pOutput);

  s := GetSQLPackagGetCodigoParams;
  FDBQueryPackageGetCodigo := DBQueryCreate(pDBConnection, s, pLog, pOutput);

  s := GetSQLVersaoGet;
  FDBQueryVersaoGet := DBQueryCreate(pDBConnection, s, pLog, pOutput);

  s := GetSQLHistInsParams;
  FDBExecHistIns := DBExecCreate(pDBConnection, s, pLog, pOutput);


end;

procedure TDBUpdaterOperationsFB.PackagePegarCodigo(pPackageName: string; out pCabec,
  pBody: string);
begin
  pCabec := '';
  pBody := '';

  FDBQueryPackageGetCodigo.Params[0].AsString := pPackageName;
  FDBQueryPackageGetCodigo.Open;
  pCabec := FDBQueryPackageGetCodigo.DataSet.Fields[0].AsString.Trim;
  pBody := FDBQueryPackageGetCodigo.DataSet.Fields[1].AsString.Trim;
  FDBQueryPackageGetCodigo.Close;
end;

function TDBUpdaterOperationsFB.GetIndexFieldNames(pIndexName: string): string;
begin
  Result := '';
  FDBQueryIndexNames.Params[0].AsString := pIndexName;
  FDBQueryIndexNames.Open;
  while not FDBQueryIndexNames.DataSet.Eof do
  begin
    if Result <> '' then
      Result := Result + ', ';

    Result := Result + Trim(FDBQueryIndexNames.DataSet.Fields[0].AsString);
    FDBQueryIndexNames.DataSet.Next;
  end;
  FDBQueryIndexNames.Close;
end;

procedure TDBUpdaterOperationsFB.HistIns(pNum: integer; pAssunto, pObjetivo,
  pObs: string);
begin
  FDBExecHistIns.Params[0].AsInteger := pNum;
  FDBExecHistIns.Params[1].AsString := pAssunto;
  FDBExecHistIns.Params[2].AsString := pObjetivo;
  FDBExecHistIns.Params[3].AsString := pObs;
  FDBExecHistIns.Execute;
end;

procedure TDBUpdaterOperationsFB.PreparePrincipais;
begin
  FDBQueryTabelaExiste.Prepare;
  FDBQueryIndexNames.Prepare;
  FDBQueryPackageGetCodigo.Prepare;
end;

procedure TDBUpdaterOperationsFB.PrepareVersoes;
begin
  FDBQueryVersaoGet.Prepare;
  FDBExecHistIns.Prepare;
end;

function TDBUpdaterOperationsFB.ProcedureExiste(pProcedureName: string): boolean;
begin
  FDBQueryProcedureExiste.Params[0].AsString := pProcedureName;
  FDBQueryProcedureExiste.Open;
  Result := FDBQueryProcedureExiste.DataSet.Fields[0].AsInteger = 1;
  FDBQueryProcedureExiste.Close;
end;

function TDBUpdaterOperationsFB.TabelaExiste(pNomeTabela: string): boolean;
begin
  Result := True;
  FDBQueryTabelaExiste.Params[0].AsString := pNomeTabela;
  FDBQueryTabelaExiste.Open;
  Result := FDBQueryTabelaExiste.DataSet.Fields[0].AsInteger = 1;
  FDBQueryTabelaExiste.Close;
end;

procedure TDBUpdaterOperationsFB.Unprepare;
begin
  FDBQueryTabelaExiste.Unprepare;
  FDBQueryIndexNames.Unprepare;
  FDBQueryPackageGetCodigo.Unprepare;
  FDBQueryVersaoGet.Unprepare;
  FDBExecHistIns.Unprepare;
end;

function TDBUpdaterOperationsFB.VersaoGet: integer;
begin
  Result := -1;
  FDBQueryVersaoGet.Open;
  Result := FDBQueryVersaoGet.DataSet.Fields[0].AsInteger;
  FDBQueryVersaoGet.Close;
end;

end.
