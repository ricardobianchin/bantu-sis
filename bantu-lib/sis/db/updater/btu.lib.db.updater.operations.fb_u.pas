unit btu.lib.db.updater.operations.fb_u;

interface

uses btu.lib.db.updater.operations, btu.lib.db.types, sis.ui.io.LogProcess,
  sis.ui.io.output, System.Classes;

type
  TDBUpdaterOperationsFB = class(TInterfacedObject, IDBUpdaterOperations)
  private
    FDBConnection: IDBConnection;
    FLogProcess: ILogProcess;
    FOutput: IOutput;

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

    procedure PackagePegarCodigo(pPackageName: string; out pCabec: string;
      out pBody: string);

    function VersaoGet: integer;
    procedure HistIns(pNum: integer; pAssunto, pObjetivo, pObs: string);

    procedure PreparePrincipais;
    procedure PrepareVersoes;
    procedure Unprepare;

    function NomeTabelaToPKName(pNomeTabela: string): string;

    function SequenceExiste(pNomeSequence: string): boolean;
    function GetForeignKeyInfo(pFKName: string; out pTabelaFK: string;
      out pCamposFK: string; out pTabelaPK: string;
      out pCamposPK: string): boolean;

    constructor Create(pDBConnection: IDBConnection; pLogProcess: ILogProcess;
      pOutput: IOutput);
  end;

implementation

uses btu.lib.db.factory, btu.lib.db.updater.firebird.GetSql_u, System.SysUtils,
  btu.lib.db.updater.constants_u, Sis.sis.clipb_u,
  sis.types.str.TStrings_u, sis.types.strings;

{ TDBUpdateOperationsFB }

constructor TDBUpdaterOperationsFB.Create(pDBConnection: IDBConnection;
  pLogProcess: ILogProcess; pOutput: IOutput);
var
  s: string;
begin
  FDBConnection := pDBConnection;
  FLogProcess := pLogProcess;
  FOutput := pOutput;

  s := GetSQLTabelaExisteParams;
  FDBQueryTabelaExiste := DBQueryCreate(pDBConnection, s, pLogProcess, pOutput);

  s := GetSQLIndexNamesParams;
  FDBQueryIndexNames := DBQueryCreate(pDBConnection, s, pLogProcess, pOutput);

  s := GetSQLProcedureExisteParams;
  FDBQueryProcedureExiste := DBQueryCreate(pDBConnection, s, pLogProcess, pOutput);

  s := GetSQLPackagGetCodigoParams;
  FDBQueryPackageGetCodigo := DBQueryCreate(pDBConnection, s, pLogProcess, pOutput);

  s := GetSQLVersaoGet;
  FDBQueryVersaoGet := DBQueryCreate(pDBConnection, s, pLogProcess, pOutput);

  s := GetSQLHistInsParams;
  FDBExecHistIns := DBExecCreate(pDBConnection, s, pLogProcess, pOutput);
end;

procedure TDBUpdaterOperationsFB.PackagePegarCodigo(pPackageName: string;
  out pCabec, pBody: string);
begin
  pCabec := '';
  pBody := '';

  FDBQueryPackageGetCodigo.Params[0].AsString := pPackageName;
  FDBQueryPackageGetCodigo.Open;
  pCabec := FDBQueryPackageGetCodigo.DataSet.Fields[0].AsString.Trim + #10;
  pBody := FDBQueryPackageGetCodigo.DataSet.Fields[1].AsString.Trim + #10;
  FDBQueryPackageGetCodigo.Close;
end;

function TDBUpdaterOperationsFB.GetForeignKeyInfo(pFKName: string;
  out pTabelaFK, pCamposFK, pTabelaPK, pCamposPK: string): boolean;
var
  s: string;
  FDBQueryForeignKeyInfo: IDBQuery;
  CamposFKSL: TStringList;
  CamposPKSL: TStringList;
begin
  Result := True;

  CamposFKSL := TStringList.Create;
  CamposPKSL := TStringList.Create;

  s := GetSQLForeignKeyInfoParams;
  FDBQueryForeignKeyInfo := DBQueryCreate(FDBConnection, s, FLogProcess, FOutput);

  FDBQueryForeignKeyInfo.Params[0].AsString := pFKName;
  FDBQueryForeignKeyInfo.Open;

  pTabelaFK := Trim(FDBQueryForeignKeyInfo.DataSet.Fields[0].AsString);
  pTabelaPK := Trim(FDBQueryForeignKeyInfo.DataSet.Fields[2].AsString);

  while not FDBQueryForeignKeyInfo.DataSet.Eof do
  begin
    SLAddUnique(CamposFKSL, Trim(FDBQueryForeignKeyInfo.DataSet.Fields[1]
      .AsString));
    SLAddUnique(CamposPKSL, Trim(FDBQueryForeignKeyInfo.DataSet.Fields[3]
      .AsString));
    FDBQueryForeignKeyInfo.DataSet.Next;
  end;

  FDBQueryForeignKeyInfo.Close;

  pCamposFK := CamposFKSL.DelimitedText;
  pCamposPK := CamposPKSL.DelimitedText;

  CamposFKSL.Free;
  CamposPKSL.Free;
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

procedure TDBUpdaterOperationsFB.HistIns(pNum: integer;
  pAssunto, pObjetivo, pObs: string);
begin
  FDBExecHistIns.Params[0].AsInteger := pNum;
  FDBExecHistIns.Params[1].AsString := pAssunto;
  FDBExecHistIns.Params[2].AsString := pObjetivo;
  FDBExecHistIns.Params[3].AsString := pObs;
  FDBExecHistIns.Execute;
end;

function TDBUpdaterOperationsFB.NomeTabelaToPKName(pNomeTabela: string): string;
begin
  Result := TruncSnakeCase(pNomeTabela + PKINDEXNAME_SUFIXO);
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

function TDBUpdaterOperationsFB.ProcedureExiste(pProcedureName: string)
  : boolean;
begin
  FDBQueryProcedureExiste.Params[0].AsString := pProcedureName;
  FDBQueryProcedureExiste.Open;
  Result := FDBQueryProcedureExiste.DataSet.Fields[0].AsInteger = 1;
  FDBQueryProcedureExiste.Close;
end;

function TDBUpdaterOperationsFB.SequenceExiste(pNomeSequence: string): boolean;
var
  s: string;
  FDBQuerySequenceExiste: IDBQuery;
begin
  s := GetSQLSequenceExisteParams;
  FDBQuerySequenceExiste := DBQueryCreate(FDBConnection, s, FLogProcess, FOutput);

  FDBQuerySequenceExiste.Params[0].AsString := pNomeSequence;
  FDBQuerySequenceExiste.Open;
  Result := FDBQuerySequenceExiste.DataSet.Fields[0].AsInteger = 1;
  FDBQuerySequenceExiste.Close;
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
