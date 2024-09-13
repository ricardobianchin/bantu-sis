unit Sis.DBI_u;

interface

uses Sis.DBI, Sis.DB.DBTypes;

type
  TDBI = class(TInterfacedObject, IDBI)
  private
    FDBConnection: IDBConnection;
    function GetDBConnection: IDBConnection;
  public
    constructor Create(pDBConnection: IDBConnection);
    property DBConnection: IDBConnection read GetDBConnection;

    function ExecuteSQL(pComandoSQL: string; out pMens: string): boolean;
    function GetValue(pConsultaSQL: string; out pMens: string): variant;
    function GetValueInteger(pConsultaSQL: string; out pMens: string): integer;
  end;

implementation

uses Sis.Types.Integers;

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

end.
