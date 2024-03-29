unit App.Ent.DBI_u;

interface

uses App.Ent.DBI, Data.DB, Sis.DB.DBTypes, Sis.DBI_u,
  Sis.UI.Frame.Bas.FiltroParams_u;

type
  TEntDBI = class(TDBI, IEntDBI)
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; virtual;
      abstract;
    function GetSqlGetExistente(pValues: variant): string; virtual; abstract;
    function GetSqlGarantirRegId: string; virtual; abstract;
    procedure SetNovaId(pIds: variant); virtual; abstract;
  public
    procedure PreencherDataSet(pValues: variant;
      pProcLeReg: TProcDataSetOfObject);
    function GetExistente(pValues: variant; out pRetorno: string)
      : variant; virtual;
    function GarantirReg: boolean;
  end;

implementation

uses Sis.Types.Integers;

{ TEntDBI }

function TEntDBI.GarantirReg: boolean;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: variant;
  sResultado: string;
  iId: integer;
  sNome: string;
begin
  Result := False;
  sSql := GetSqlGarantirRegId;

  DBConnection.Abrir;
  try
    iId := DBConnection.GetValueInteger(sSql);
    SetNovaId(iId);
    Result := True;
  finally
    DBConnection.Fechar;
  end;
end;

function TEntDBI.GetExistente(pValues: variant; out pRetorno: string): variant;
var
  sFormat: string;
  sSql: string;
  Resultado: variant;
  sResultado: string;
begin
  Result := 0;
  sSql := GetSqlGetExistente(pValues);
  DBConnection.Abrir;
  try
    Result := DBConnection.GetValueInteger(sSql);
  finally
    DBConnection.Fechar;
  end;
end;

procedure TEntDBI.PreencherDataSet(pValues: variant;
  pProcLeReg: TProcDataSetOfObject);
var
  sSql: string;
  q: TDataSet;
begin
  DBConnection.Abrir;
  try
    sSql := GetSqlPreencherDataSet(pValues);
    DBConnection.QueryDataSet(sSql, q);
    try
      while not q.Eof do
      begin
        pProcLeReg(q);
        q.Next;
      end;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

end.
