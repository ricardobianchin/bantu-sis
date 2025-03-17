unit Sis.DBI_u;

interface

uses Sis.DBI, Sis.DB.DBTypes;

type
  TDBI = class(TInterfacedObject, IDBI)
  private
    FDBConnection: IDBConnection;
    function GetDBConnection: IDBConnection;
  protected
    function GetSqlForEach(pValues: variant): string; virtual; abstract;
  public
    property DBConnection: IDBConnection read GetDBConnection;

    function ExecuteSQL(pComandoSQL: string; out pMens: string): boolean;
    function GetValue(pConsultaSQL: string; out pMens: string): variant;

    procedure GetFirstRecordValues(pConsultaSQL: string; out pVarArray: variant;
      out pMens: string; out pDataSetWasEmpty: boolean);

    function GetValueInteger(pConsultaSQL: string; out pMens: string): integer;

    procedure ForEach(pValues: variant;
      pProcLeReg: TProcDataSetOfObject); virtual;
    function GetNomeArqTabView(pValues: variant): string; virtual;

    constructor Create(pDBConnection: IDBConnection);
  end;

implementation

uses Sis.Types.Integers, Data.DB, Sis.Win.Utils_u, System.Variants,
  Sis.DB.DataSet.Utils;

{ TDBI }

function TDBI.GetValue(pConsultaSQL: string; out pMens: string): variant;
var
  Resultado: boolean;
begin
  Resultado := False;

  Resultado := DBConnection.Abrir;
  if not Resultado then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    Result := DBConnection.GetValue(pConsultaSQL);
  finally
    DBConnection.Fechar;
    Resultado := True;
  end;
end;

function TDBI.GetValueInteger(pConsultaSQL: string; out pMens: string): integer;
var
  Resultado: variant;
begin
  Resultado := GetValue(pConsultaSQL, pMens);
  Result := VarToInteger(Resultado);
end;

procedure TDBI.ForEach(pValues: variant; pProcLeReg: TProcDataSetOfObject);
var
  sSqlRetRegs: string;
  q: TDataSet;
  iRecNo: integer;
begin
  DBConnection.Abrir;
  try
    sSqlRetRegs := GetSqlForEach(pValues);
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSqlRetRegs);
    // {$ENDIF}

    DBConnection.QueryDataSet(sSqlRetRegs, q);
    try
      iRecNo := 0;
      while not q.Eof do
      begin
        inc(iRecNo);
        pProcLeReg(q, iRecNo);
        q.Next;
      end;
      pProcLeReg(q, -1);
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

constructor TDBI.Create(pDBConnection: IDBConnection);
begin
  FDBConnection := pDBConnection;
end;

function TDBI.ExecuteSQL(pComandoSQL: string; out pMens: string): boolean;
begin
  Result := False;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.ExecuteSQL(pComandoSQL);
  finally
    DBConnection.Fechar;
    Result := True;
  end;
end;

function TDBI.GetDBConnection: IDBConnection;
begin
  Result := FDBConnection;
end;

procedure TDBI.GetFirstRecordValues(pConsultaSQL: string;
  out pVarArray: variant; out pMens: string; out pDataSetWasEmpty: boolean);
var
  q: TDataSet;
  I: integer;
  Resultado: boolean;
begin
  try
    pDataSetWasEmpty := True;

    Resultado := DBConnection.Abrir;
    if not Resultado then
    begin
      pMens := DBConnection.UltimoErro;
      exit;
    end;

    try
      DBConnection.QueryDataSet(pConsultaSQL, q);
      try
        RecordToVarArray( pVarArray, q, pDataSetWasEmpty);
      finally
        q.Free;
      end;
    finally
      DBConnection.Fechar;
    end;
  finally
    if not Resultado then
    begin
      pVarArray := VarArrayCreate([1, 0], varVariant);
{
 pode testar o retorn com
 if VarIsArray(vRetorno) and (VarArrayHighBound(vRetorno, 1) >= 1) then
 mas nao será necessario pois agora criei pDataSetWasEmpty
 }
    end;
  end;
end;

function TDBI.GetNomeArqTabView(pValues: variant): string;
begin
  Result := '';
end;

end.
