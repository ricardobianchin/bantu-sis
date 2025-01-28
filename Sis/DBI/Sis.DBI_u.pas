unit Sis.DBI_u;

interface

uses Sis.DBI, Sis.DB.DBTypes;

type
  TDBI = class(TInterfacedObject, IDBI)
  private
    FDBConnection: IDBConnection;
    function GetDBConnection: IDBConnection;
  protected
    function GetSqlForEach(pValues: variant): string; virtual;
      abstract;
  public
    property DBConnection: IDBConnection read GetDBConnection;

    function ExecuteSQL(pComandoSQL: string; out pMens: string): boolean;
    function GetValue(pConsultaSQL: string; out pMens: string): variant;
    function GetValueInteger(pConsultaSQL: string; out pMens: string): integer;

    procedure ForEach(pValues: variant;
      pProcLeReg: TProcDataSetOfObject); virtual;
    function GetNomeArqTabView(pValues: variant): string; virtual;

    constructor Create(pDBConnection: IDBConnection);
  end;

implementation

uses Sis.Types.Integers, Data.DB, Sis.Win.Utils_u;

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
  Resultado: Variant;
begin
  Resultado := GetValue(pConsultaSQL, pMens);
  result := VarToInteger(Resultado);
end;

procedure TDBI.ForEach(pValues: variant;
  pProcLeReg: TProcDataSetOfObject);
var
  sSqlRetRegs: string;
  q: TDataSet;
  iRecNo: integer;
begin
  DBConnection.Abrir;
  try
    sSqlRetRegs := GetSqlForEach(pValues);
//    {$IFDEF DEBUG}
//    CopyTextToClipboard(sSqlRetRegs);
//    {$ENDIF}

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

function TDBI.GetNomeArqTabView(pValues: variant): string;
begin
  Result := '';
end;

end.
