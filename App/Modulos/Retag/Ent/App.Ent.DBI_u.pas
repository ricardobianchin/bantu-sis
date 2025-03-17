unit App.Ent.DBI_u;

interface

uses App.Ent.DBI, Data.DB, Sis.DB.DBTypes, Sis.DBI_u, System.Variants,
  System.Classes, App.Ent.Ed;

type
  TEntDBI = class(TDBI, IEntDBI)
  private
    FEntEd: IEntEd;
    function GetEntEd: IEntEd;
    procedure SetEntEd(Value: IEntEd);
  protected
    function GetSqlGetRegsJaExistentes(pValuesArray: variant): string;
      virtual; abstract;

    procedure SetVarArrayToId(pNovaId: variant); virtual; abstract;
    function ById(pId: variant; out pValores: variant): boolean; virtual;
    function GetPackageName: string; virtual; abstract;

    function GetSqlGaranteRegERetornaId: string; virtual;
    function GetSqlInserirDoERetornaId: string; virtual;
    function GetSqlAlterarDo: string; virtual;

    function GetFieldNamesListaGet: string; virtual;
    function GetFieldValuesGravar: string; virtual;
  public
    property PackageName: string read GetPackageName;

    function GetRegsJaExistentes(pValuesArray: variant; out pRetorno: string;
      out pNenhumExistente: boolean): variant; virtual;

    function Ler: boolean; virtual;
    function Inserir(out pNovaId: variant): boolean; virtual;
    function Alterar: boolean; virtual;
    function Gravar: boolean; virtual;
    function Garantir: boolean;
    procedure ListaSelectGet(pSL: TStrings;
      pDBConnection: IDBConnection = nil); virtual;
    function AtivoSet(const pId: integer; Value: boolean): boolean; virtual;

    property EntEd: IEntEd read GetEntEd write SetEntEd;

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
  sFormat := 'EXECUTE PROCEDURE ' + PackageName + '.ATIVO_SET(%s, %s);';
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
  sSqlGaranteRegERetornaId: string;
  q: TDataSet;
  Resultado: variant;
  sResultado: string;
  sNome: string;
  aNovaId: variant;
  bDataSetWasEmpty: Boolean;
begin
  Result := False;
  sSqlGaranteRegERetornaId := GetSqlGaranteRegERetornaId;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSqlGaranteRegERetornaId);
  // {$ENDIF}

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    DBConnection.QueryDataSet(sSqlGaranteRegERetornaId, q);

    RecordToVarArray(aNovaId, q, bDataSetWasEmpty);

    Result := not bDataSetWasEmpty;

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

/// <summary>
/// Função para obter registros já existentes.
/// </summary>
/// <param name="pValuesArray">
/// Array de valores a serem verificados.
/// </param>
/// <param name="pRetorno">
/// Retorno da função, caso necessário.
/// </param>
/// <returns>
/// Array de variantes contendo os registros já existentes.
/// </returns>
function TEntDBI.GetRegsJaExistentes(pValuesArray: variant;
  out pRetorno: string; out pNenhumExistente: boolean): variant;
var
  sSql: string;
  q: TDataSet;
  bNenhumEncontrado: boolean;
  i: integer;
  iQtdExistentes: integer;
  iUltimoIndex: integer;

begin
  Result := VarArrayCreate([1, 0], varVariant);
  pRetorno := '';
  pNenhumExistente := True;

  sSql := GetSqlGetRegsJaExistentes(pValuesArray);
  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    try
      bNenhumEncontrado := not Assigned(q);
      if bNenhumEncontrado then
        exit;

      bNenhumEncontrado := q.IsEmpty;
      if bNenhumEncontrado then
        exit;

      bNenhumEncontrado := q.Fields[0].AsInteger = 0;
      if bNenhumEncontrado then
        exit;

      iQtdExistentes := q.RecordCount;
      iUltimoIndex := iQtdExistentes - 1;

      Result := VarArrayCreate([0, iUltimoIndex], varVariant);
      pNenhumExistente := False;

      i := 0;
      while not q.Eof do
      begin
        if pRetorno <> '' then
          pRetorno := pRetorno + '. ';
        pRetorno := pRetorno + q.Fields[0].AsString.Trim;

        Result[i] := q.Fields[0].Value;

        for var j := 1 to q.FieldCount - 1 do
        begin
          pRetorno := pRetorno + ', ' + q.Fields[j].AsString.Trim;
        end;

        Inc(i);
        q.Next;
      end;

      if pRetorno <> '' then
        pRetorno := Iif(iQtdExistentes = 1, 'Já existente: ', 'Já existentes: ')
          + pRetorno;
    finally
      q.Free;
    end;
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

function TEntDBI.GetSqlGaranteRegERetornaId: string;
begin
  Result := '';
end;

function TEntDBI.GetSqlInserirDoERetornaId: string;
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

function TEntDBI.Inserir(out pNovaId: variant): boolean;
var
  sSqlInserirDoERetornaId: string;
  sMens: string;
  q: TDataSet;
  bDataSetWasEmpty: Boolean;
begin
  Result := False;

  sSqlInserirDoERetornaId := GetSqlInserirDoERetornaId;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSqlInserirDoERetornaId, q);

    RecordToVarArray(pNovaId, q, bDataSetWasEmpty);

    Result := not bDataSetWasEmpty;

    if not Result then
      exit;

    SetVarArrayToId(pNovaId);
  finally
    FreeAndNil(q);
    DBConnection.Fechar;
    Result := True;
  end;
end;

function TEntDBI.Ler: boolean;
begin
  Result := False;
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
          if iId < 1 then
          begin
            pSL.Add(sDescr);
            continue;
          end;
          p := pointer(iId);
          pSL.AddObject(sDescr, p);
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
