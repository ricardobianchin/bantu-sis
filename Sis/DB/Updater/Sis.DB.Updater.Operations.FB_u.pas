unit Sis.DB.Updater.Operations.FB_u;

interface

uses System.Classes, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output, Sis.DB.Factory;

type
  TDBUpdaterOperationsFB = class(TInterfacedObject, IDBUpdaterOperations)
  private
    FDBConnection: IDBConnection;
    FProcessLog: IProcessLog;
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
    function GetUniqueKeyInfo(pUKName: string; out pCampos: string): boolean;

    constructor Create(pDBConnection: IDBConnection; pProcessLog: IProcessLog;
      pOutput: IOutput);
  end;

implementation

uses System.SysUtils, Sis.DB.Updater.Firebird.GetSql_u,
  Sis.DB.Updater.Constants_u, Sis.Types.strings_u, Sis.Types.TStrings_u;

{ TDBUpdateOperationsFB }

constructor TDBUpdaterOperationsFB.Create(pDBConnection: IDBConnection;
  pProcessLog: IProcessLog; pOutput: IOutput);
var
  s: string;
begin
  FDBConnection := pDBConnection;
  FProcessLog := pProcessLog;
  FOutput := pOutput;

  FProcessLog.PegueLocal('TDBUpdaterOperationsFB.Create');
  try
    s := GetSQLTabelaExisteParams;
    FDBQueryTabelaExiste := DBQueryCreate('DBUpdaterOperationsQTabelaExiste',
      pDBConnection, s, pProcessLog, pOutput);

    s := GetSQLIndexNamesParams;
    FDBQueryIndexNames := DBQueryCreate('DBUpdaterOperationsQIndexNames',
      pDBConnection, s, pProcessLog, pOutput);

    s := GetSQLProcedureExisteParams;
    FDBQueryProcedureExiste :=
      DBQueryCreate('DBUpdaterOperationsQProcedureExiste', pDBConnection, s,
      pProcessLog, pOutput);

    s := GetSQLPackagGetCodigoParams;
    FDBQueryPackageGetCodigo :=
      DBQueryCreate('DBUpdaterOperationsQPackageGetCodigo', pDBConnection, s,
      pProcessLog, pOutput);

    s := GetSQLVersaoGet;
    FDBQueryVersaoGet := DBQueryCreate('DBUpdaterOperationsQVersaoGet',
      pDBConnection, s, pProcessLog, pOutput);

    s := GetSQLHistInsParams;
    FDBExecHistIns := DBExecCreate('DBUpdaterOperationsQHistInsParams',
      pDBConnection, s, pProcessLog, pOutput);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdaterOperationsFB.PackagePegarCodigo(pPackageName: string;
  out pCabec, pBody: string);
begin
  FProcessLog.PegueLocal('TDBUpdaterOperationsFB.PackagePegarCodigo');
  try
    pCabec := '';
    pBody := '';

    FDBQueryPackageGetCodigo.Params[0].AsString := pPackageName;

    FDBQueryPackageGetCodigo.Open;

    pCabec := FDBQueryPackageGetCodigo.DataSet.Fields[0].AsString.Trim + #10;
    pBody := FDBQueryPackageGetCodigo.DataSet.Fields[1].AsString.Trim + #10;

    FDBQueryPackageGetCodigo.Close;
  finally
    FProcessLog.RetorneLocal;
  end;
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
  FProcessLog.PegueLocal('TDBUpdaterOperationsFB.GetForeignKeyInfo');
  try
    CamposFKSL := TStringList.Create;
    CamposPKSL := TStringList.Create;

    s := GetSQLForeignKeyInfoParams;
    FDBQueryForeignKeyInfo := DBQueryCreate('ForeignKeyInfoQ', FDBConnection, s,
      FProcessLog, FOutput);

    FDBQueryForeignKeyInfo.Params[0].AsString := pFKName;
    FDBQueryForeignKeyInfo.Open;

    pTabelaFK := Trim(FDBQueryForeignKeyInfo.DataSet.Fields[0].AsString);
    pTabelaPK := Trim(FDBQueryForeignKeyInfo.DataSet.Fields[2].AsString);

    while not FDBQueryForeignKeyInfo.DataSet.Eof do
    begin
      s := Trim(FDBQueryForeignKeyInfo.DataSet.Fields[1].AsString);
      SLAddUnique(CamposFKSL, s);

      s := Trim(FDBQueryForeignKeyInfo.DataSet.Fields[3].AsString);
      SLAddUnique(CamposPKSL, s);

      FDBQueryForeignKeyInfo.DataSet.Next;
    end;

    FDBQueryForeignKeyInfo.Close;

    pCamposFK := CamposFKSL.DelimitedText;
    pCamposPK := CamposPKSL.DelimitedText;

    CamposFKSL.Free;
    CamposPKSL.Free;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

function TDBUpdaterOperationsFB.GetIndexFieldNames(pIndexName: string): string;
begin
  Result := '';

  FProcessLog.PegueLocal('TDBUpdaterOperationsFB.GetIndexFieldNames');
  try
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
  finally
    FProcessLog.RegistreLog('Result=' + Result);
    FProcessLog.RetorneLocal;
  end;
end;

function TDBUpdaterOperationsFB.GetUniqueKeyInfo(pUKName: string;
  out pCampos: string): boolean;
var
  s: string;
  FDBQueryUniqueKeyInfo: IDBQuery;
  CamposSL: TStringList;
begin
  Result := True;
  FProcessLog.PegueLocal('TDBUpdaterOperationsFB.GetUniqueKeyInfo');
  try
    CamposSL := TStringList.Create;

    s := GetSQLUniqueKeyInfoParams;
    FDBQueryUniqueKeyInfo := DBQueryCreate('UniqueKeyInfoQ', FDBConnection, s,
      FProcessLog, FOutput);

    FDBQueryUniqueKeyInfo.Params[0].AsString := pUKName;
    FDBQueryUniqueKeyInfo.Open;

    while not FDBQueryUniqueKeyInfo.DataSet.Eof do
    begin
      s := Trim(FDBQueryUniqueKeyInfo.DataSet.Fields[0].AsString);
      SLAddUnique(CamposSL, s);

      FDBQueryUniqueKeyInfo.DataSet.Next;
    end;

    FDBQueryUniqueKeyInfo.Close;

    pCampos := CamposSL.DelimitedText;

    CamposSL.Free;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdaterOperationsFB.HistIns(pNum: integer;
  pAssunto, pObjetivo, pObs: string);
var
  sLog: string;
begin
  FProcessLog.PegueLocal('TDBUpdaterOperationsFB.HistIns');
  try
    FDBExecHistIns.Params[0].AsInteger := pNum;
    FDBExecHistIns.Params[1].AsString := pAssunto;
    FDBExecHistIns.Params[2].AsString := pObjetivo;
    FDBExecHistIns.Params[3].AsString := pObs;
    FDBExecHistIns.Execute;
  finally
    FProcessLog.RetorneLocal;
  end;

end;

function TDBUpdaterOperationsFB.NomeTabelaToPKName(pNomeTabela: string): string;
begin
  Result := TruncSnakeCase(pNomeTabela + PKINDEXNAME_SUFIXO,
    FB_MAX_IDENTIFIER_LENGHT);
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
  FDBQuerySequenceExiste := DBQueryCreate('SequenceExisteQ', FDBConnection, s,
    FProcessLog, FOutput);

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
