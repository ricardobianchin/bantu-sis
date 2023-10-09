unit btu.lib.db.updater.comando.fb.createtable_u;

interface

uses btu.lib.db.updater.comando, System.Classes, btu.lib.db.updater.campo.list,
  btu.lib.db.types, btu.lib.db.updater.comando.fb_u,
  btu.lib.db.updater.operations,
  btu.sis.ui.io.log, btu.sis.ui.io.output;

type
  TComandoFBCreateTable = class(TComandoFB)
  private
    FNomeTabela: string;
    FCampoList: ICampoList;

    sCodigoRetornado: string;

    function GetSqlCreateTable: string;
    function GetSqlCreatePK: string;
    function GetPKName: string;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string;  override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
    function Funcionou: boolean; override;
  end;

implementation

{ TSqlGenComandoFBCreateTable }

uses btu.lib.db.updater.constants_u, btu.lib.db.updater.campo,
  btu.lib.db.updater.factory, btn.lib.types.strings, btu.sis.db.updater.utils;

constructor TComandoFBCreateTable.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pLog, pOutput);
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
  sCodigoRetornado := GetSqlCreateTable + GetSqlCreatePK;
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
        bPegandoColunas := False;
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
      PegarObjeto(sObjetoNome);
    end;
  end;
end;

procedure TComandoFBCreateTable.PegarObjeto(pNome: string);
begin
  FNomeTabela := pNome;
end;

end.
