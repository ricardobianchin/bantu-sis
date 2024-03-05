unit App.Ent.DBI_u;

interface

uses App.Ent.DBI, Data.DB, Sis.DB.DBTypes, Sis.DBI_u,
  Sis.UI.Frame.Bas.FiltroParams_u, System.Classes;

type
  TEntDBI = class(TDBI, IEntDBI)
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; virtual;
      abstract;
    function GetSqlGetExistente(pValues: variant): string; virtual; abstract;
    function GetSqlGarantirRegId: string; virtual; abstract;
    procedure SetNovaId(pIds: variant); virtual; abstract;
    function ById(pId: variant; out pValores: variant): boolean; virtual;
    function GetPackageName: string; virtual; abstract;
  public
    property PackageName: string read GetPackageName;
    procedure PreencherDataSet(pValues: variant;
      pProcLeReg: TProcDataSetOfObject);
    function GetExistente(pValues: variant; out pRetorno: string)
      : variant; virtual;
    function GarantirReg: boolean;
    procedure ListaSelectGet(pSL: TStrings; pDBConnection: IDBConnection = nil); virtual;
  end;

implementation

uses Sis.Types.Integers, System.SysUtils;

{ TEntDBI }

function TEntDBI.ById(pId: variant; out pValores: variant): boolean;
begin
  Result := False;
end;

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

procedure TEntDBI.ListaSelectGet(pSL: TStrings; pDBConnection: IDBConnection);
var
  sSql: string;
  q: TDataSet;
  sDescr: string;
  iId: integer;
  p: pointer;
  vDBConnection: IDBConnection;
  bUsouConLocal: boolean;
begin
  bUsouConLocal := pDBConnection = nil;
  if bUsouConLocal then
  begin
    vDBConnection := DBConnection;
  end
  else
  begin
    vDBConnection := pDBConnection;
  end;

  pSL.Clear;
  if not vDBConnection.Abrir then
    exit;

  try
    sSql := 'SELECT ID_RET, DESCR_RET FROM ' + PackageName +
      '.LISTA_SELECT_GET;';
    vDBConnection.QueryDataSet(sSql, q);
    try
      while not q.Eof do
      begin
        sDescr := q.Fields[1].AsString.Trim;
        iId := q.Fields[0].AsInteger;
        try
          if iId <1 then
          begin
            pSL.Add(sDescr);
            continue;
          end;
          p := Pointer(iId);
          pSL.AddObject(sDescr, P);
        finally
          q.Next;
        end;
      end;
    finally
      q.Free;
    end;
  finally
    vDBConnection.Fechar;
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
