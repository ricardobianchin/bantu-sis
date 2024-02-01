unit Sis.DB.Updater.Comando.FB.CreateTable_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.Updater.Campo.List,
  Sis.DB.DBTypes, Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output;

type
  TComandoFBCreateTable = class(TComandoFB)
  private
    FNomeTabela: string;
    FCampoList: ICampoList;

    sCodigoRetornado: string;

    function GetSqlCreateTable: string;
    function GetSqlCreatePK: string;
    function GetSqlCreateUnique: string;
    function GetPKName: string;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string;  override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput);
    function Funcionou: boolean; override;
  end;

implementation

{ TSqlGenComandoFBCreateTable }

uses Sis.DB.Updater.Factory, Sis.DB.Updater.Campo, Sis.DB.Updater.Constants_u,
  Sis.Types.strings_u, Sis.DB.Firebird.GetSQL_u;

constructor TComandoFBCreateTable.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
  FCampoList := CampoListCreate;
end;

function TComandoFBCreateTable.Funcionou: boolean;
var
  sPKName: string;
  sCamposPKDeve, sCamposPKAtual: string;
begin
  Result := sCodigoRetornado = '';
  if Result then
    exit;

  Result := DBUpdaterOperations.TabelaExiste(FNomeTabela);
  if not Result then
  begin
    UltimoErro := 'TComandoFBCreateTable, Erro ao criar a tabela ' + FNomeTabela;
    exit;
  end;

  sPKName := GetPKName;

  sCamposPKAtual := DBUpdaterOperations.GetIndexFieldNames(sPKName);

  sCamposPKDeve := FCampoList.PKFieldNames;

  Result := sCamposPKDeve = sCamposPKAtual;
  if not Result then
  begin
    UltimoErro := 'TComandoFBCreateTable, Erro ao criar o índice ' + sPKName;
//    exit;
  end;
end;

function TComandoFBCreateTable.GetAsSql: string;
begin
  sCodigoRetornado := GetSqlCreateTable + GetSqlCreatePK + GetSqlCreateUnique;
  Result := sCodigoRetornado;

  if Result = '' then
    Exit;

  Result :=
    #13#10
    +'/*******'#13#10
    +'*'#13#10
    +'* ' + GetAsText + #13#10
    +'*'#13#10
    +'*******/'#13#10
    + Result
    ;
end;

function TComandoFBCreateTable.GetAsText: string;
begin
  Result := 'TABLE ' + FNomeTabela;
end;

function TComandoFBCreateTable.GetPKName: string;
begin

  Result := DBUpdaterOperations.NomeTabelaToPKName(FNomeTabela);

//  FNomeTabela + PKINDEXNAME_SUFIXO;
end;

function TComandoFBCreateTable.GetSqlCreatePK: string;
var
  sPKName: string;
  sCamposPKDeve, sCamposPKAtual: string;
begin
  Result := '';

  sCamposPKDeve := FCampoList.PKFieldNames;
  if sCamposPKDeve = '' then
    exit;

  sPKName := GetPKName;

  sCamposPKAtual := DBUpdaterOperations.GetIndexFieldNames(sPKName);

  if sCamposPKDeve = sCamposPKAtual then
    exit;

  if sCamposPKAtual <> '' then
    Result := Result
      + '-- ja existia indice com (' + sCamposPKAtual + ')'#13#10
      + 'ALTER TABLE ' + FNomeTabela + #13#10
      + 'DROP CONSTRAINT ' + sPKName + ';'#13#10
      + #13#10
      ;

  Result := Result
    + 'ALTER TABLE ' + FNomeTabela + #13#10
    +'ADD CONSTRAINT ' + sPKName + #13#10
    +'PRIMARY KEY (' + sCamposPKDeve +');'#13#10
    +#13#10
    ;
end;

function TComandoFBCreateTable.GetSqlCreateTable: string;
var
  Resultado: boolean;
begin
  Result := '';

//  Resultado := TabelaExiste(DBConnection, FNomeTabela);
  Resultado := DBUpdaterOperations.TabelaExiste(FNomeTabela);

  if Resultado then
    exit;

  Result :=
    'CREATE TABLE ' + FNomeTabela + #13#10
    +'('#13#10
    + FCampoList.AsCreateTableFields
    +');'#13#10
    ;
end;

function TComandoFBCreateTable.GetSqlCreateUnique: string;
var
  sComando: string;
  i: integer;
  oCampo: ICampo;
  bUnique: boolean;
  sCampoNome: string;
begin
  Result := '';

  for I := 0 to FCampoList.Count - 1 do
  begin
    oCampo := FCampoList[i];
    bUnique := oCampo.Unique;
    if bUnique then
    begin
      sCampoNome := oCampo.Nome;
      sComando := GetSQLUniqueKey(FNomeTabela, sCampoNome);
      Result := Result + sComando + #13#10;
    end;
  end;

  if Result <> '' then
    Result := #13#10 + Result + #13#10;
end;

procedure TComandoFBCreateTable.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  bPegandoColunas: boolean;
  oCampo: ICampo;
  sObjetoNome: string;
begin
  bPegandoColunas := false;
  while piLin < pSL.Count do
  begin
    inc(piLin);
    sLinha := pSL[piLin];

    if bPegandoColunas then
    begin
      if sLinha = DBATUALIZ_COLUNAS_FIM_CHAVE then
      begin
        //bPegandoColunas := False;
        break;
      end;
      oCampo := sLinToCampoCreate(sLinha);
      if Assigned(oCampo) then
        FCampoList.Add(oCampo);
    end
    else if sLinha = DBATUALIZ_COLUNAS_INI_CHAVE then
    begin
      bPegandoColunas := True;
    end
    else if Pos(DBATUALIZ_OBJETO_NOME_CHAVE + '=', sLinha) = 1 then
    begin
      sObjetoNome := StrApos(sLinha, '=');
      sObjetoNome := TruncSnakeCase(sObjetoNome, FB_MAX_IDENTIFIER_LENGHT);
      PegarObjeto(sObjetoNome);
    end;
  end;
end;

procedure TComandoFBCreateTable.PegarObjeto(pNome: string);
begin
  FNomeTabela := pNome;
end;

end.
