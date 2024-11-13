unit App.Ent.DBI_u;

interface

uses App.Ent.DBI, Data.DB, Sis.DB.DBTypes, Sis.DBI_u, System.Variants,
  Sis.UI.Frame.Bas.FiltroParams_u, System.Classes, App.Ent.Ed;

type
  TEntDBI = class(TDBI, IEntDBI)
  private
    FEntEd : IEntEd ;
    function GetEntEd: IEntEd ;
    procedure SetEntEd(Value: IEntEd );
  protected
    function GetSqlGetExistente(pValues: variant): string; virtual; abstract;

    procedure SetVarArrayToId(pNovaId: Variant); virtual; abstract;
    function ById(pId: variant; out pValores: variant): boolean; virtual;
    function GetPackageName: string; virtual; abstract;

    function GetSqlGaranteRegRetId: string; virtual;
    function GetSqlInserirDoRetId: string; virtual;
    function GetSqlAlterarDo: string; virtual;

    function GetFieldNamesListaGet: string; virtual;
    function GetFieldValuesGravar: string; virtual;
  public
    property PackageName: string read GetPackageName;
    function GetExistente(pValues: variant; out pRetorno: string)
      : variant; virtual;
    function Ler: boolean; virtual;
    function Inserir(out pNovaId: Variant): boolean; virtual;
    function Alterar: boolean; virtual;
    function Gravar: boolean; virtual;
    function Garantir: boolean;
    procedure ListaSelectGet(pSL: TStrings; pDBConnection: IDBConnection = nil); virtual;
    function AtivoSet(const pId: integer; Value: boolean): boolean; virtual;

    property EntEd: IEntEd  read GetEntEd write SetEntEd;

    constructor Create(pDBConnection: IDBConnection; pEntEd: IEntEd);
  end;

implementation

uses Sis.Types.Integers, System.SysUtils, Sis.Types.Bool_u,
  Sis.DB.DataSet.Utils, Sis.Win.Utils_u;

{ TEntDBI }

function TEntDBI.Alterar: boolean;
var
  sSqlAlterarDo: string;
  sMens: string;
begin
  Result := False;

  sSqlAlterarDo := GetSqlAlterarDo;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.ExecuteSQL(sSqlAlterarDo);
  finally
    DBConnection.Fechar;
    Result := True;
  end;
end;

function TEntDBI.AtivoSet(const pId: integer; Value: boolean): boolean;
var
  sFormat: string;
  sSql: string;
  sId, sVal: string;
begin
  sId := pId.ToString;
  sVal := BooleanToStrSQL(Value);
  sFormat := 'EXECUTE PROCEDURE '+PackageName+'.ATIVO_SET(%s, %s);';
  sSql := Format(sFormat, [sId, sVal]);

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    DBConnection.ExecuteSQL(sSql);
  finally
    DBConnection.Fechar;
  end;
end;

function TEntDBI.ById(pId: variant; out pValores: variant): boolean;
begin
  Result := False;
end;

constructor TEntDBI.Create(pDBConnection: IDBConnection; pEntEd: IEntEd);
begin
  inherited Create(pDBConnection);
  FEntEd := pEntEd;
end;

function TEntDBI.Garantir: boolean;
var
  sFormat: string;
  sSqlGaranteRegRetId: string;
  q: TDataSet;
  Resultado: variant;
  sResultado: string;
  sNome: string;
  aNovaId: Variant;
begin
  Result := False;
  sSqlGaranteRegRetId := GetSqlGaranteRegRetId;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(sSqlGaranteRegRetId);
//  {$ENDIF}

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    DBConnection.QueryDataSet(sSqlGaranteRegRetId, q);

    Result := RecordToVarArray(aNovaId, Q);
    if not Result then
      exit;

    SetVarArrayToId(aNovaId);
  finally
    if Assigned(q) then
      q.Free;
    DBConnection.Fechar;
  end;
end;

function TEntDBI.GetEntEd: IEntEd;
begin
  Result := FEntEd;
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

function TEntDBI.GetFieldNamesListaGet: string;
begin
  Result := '';
end;

function TEntDBI.GetFieldValuesGravar: string;
begin
  Result := '';
end;

function TEntDBI.GetSqlAlterarDo: string;
begin
  Result := '';
end;

function TEntDBI.GetSqlGaranteRegRetId: string;
begin
  Result := '';
end;

function TEntDBI.GetSqlInserirDoRetId: string;
begin
  Result := '';
end;

function TEntDBI.Gravar: boolean;
var
  i: variant;
begin
  if EntEd.State = dsInsert then
  begin
    Result := Inserir(i);
    if Result then
      SetVarArrayToId(i);
  end
  else
    Result := Alterar;
end;

function TEntDBI.Inserir(out pNovaId: Variant): boolean;
var
  sSqlInserirDoRetId: string;
  sMens: string;
  q: TDataSet;
begin
  Result := False;

  sSqlInserirDoRetId := GetSqlInserirDoRetId;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSqlInserirDoRetId, Q);

    Result := RecordToVarArray(pNovaId, Q);
    if not Result then
      exit;

    SetVarArrayToId(pNovaId);
  finally
    FreeAndNil(Q);
    DBConnection.Fechar;
    Result := True;
  end;
end;

function TEntDBI.Ler: boolean;
begin
//
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

procedure TEntDBI.SetEntEd(Value: IEntEd);
begin
  FEntEd := Value;
end;

end.
