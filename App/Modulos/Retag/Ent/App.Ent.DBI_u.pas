unit App.Ent.DBI_u;

interface

uses App.Ent.DBI, Data.DB, Sis.DB.DBTypes, Sis.DBI_u;

type
  TEntDBI = class(TDBI, IEntDBI)
  protected
    function GetSqlPreencherDataSetIdDescr(pStrBusca: string): string; virtual; abstract;
    function GetSqlIdByDescr(pDescr: string): string; virtual; abstract;
    function GetSqlGarantirRegId: string; virtual; abstract;
    procedure SetNovaId(pId: integer); virtual; abstract;
  public
    procedure PreencherDataSetIdDescr(pStrBusca: string; pLeReg: TProcDataSetRef);
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

procedure TEntDBI.PreencherDataSetIdDescr(pStrBusca: string; pLeReg: TProcDataSetRef);
var
  sSql: string;
  q: TDataSet;
begin
  DBConnection.Abrir;
  try
    SSql := GetSqlPreencherDataSetIdDescr(pStrBusca);
    DBConnection.QueryDataSet(sSql, q);
    try
      while not q.Eof do
      begin
        pLeReg(q);
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
