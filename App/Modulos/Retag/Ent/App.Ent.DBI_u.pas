unit App.Ent.DBI_u;

interface

uses App.Ent.DBI, Data.DB, Sis.DB.DBTypes, Sis.DBI_u, Sis.UI.Frame.Bas.FiltroParams_u;

type
  TEntDBI = class(TDBI, IEntDBI)
  protected
    function GetSqlPreencherDataSet(pFiltroParamsFrame: TFiltroParamsFrame): string; virtual; abstract;
    function GetSqlIdByDescr(pDescr: string): string; virtual; abstract;
    function GetSqlGarantirRegId: string; virtual; abstract;
    procedure SetNovaId(pId: integer); virtual; abstract;
  public
    procedure PreencherDataSet(pFiltroParamsFrame: TFiltroParamsFrame; pProcLeReg: TProcDataSetOfObject);
    function IdByDescr(pDescr: string): integer;
    function GarantirRegId: boolean;
  end;

implementation

uses Sis.Types.Integers;

{ TEntDBI }

function TEntDBI.GarantirRegId: boolean;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: Variant;
  sResultado: string;
  iResultado: smallint;
  iId: integer;
  sNome: string;
begin
  Result := False;
  sSql := GetSqlGarantirRegId;

  DBConnection.Abrir;
  try
    Resultado := DBConnection.GetValue(sSql);
    Result := True;
  finally
    DBConnection.Fechar;
  end;

  iId := VarToInteger(Resultado);
  SetNovaId(iId);
end;

function TEntDBI.IdByDescr(pDescr: string): integer;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: Variant;
  sResultado: string;
begin
  Result := 0;
  sSql := GetSqlIdByDescr(pDescr);
  DBConnection.Abrir;
  try
    Result := DBConnection.GetValueInteger(sSql);
  finally
    DBConnection.Fechar;
  end;
end;

procedure TEntDBI.PreencherDataSet(pFiltroParamsFrame: TFiltroParamsFrame; pProcLeReg: TProcDataSetOfObject);
var
  sSql: string;
  q: TDataSet;
begin
  DBConnection.Abrir;
  try
    SSql := GetSqlPreencherDataSet(pFiltroParamsFrame);
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
