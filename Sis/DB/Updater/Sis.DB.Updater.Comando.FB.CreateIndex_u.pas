unit Sis.DB.Updater.Comando.FB.CreateIndex_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.DBTypes,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

type
  TComandoFBCreateIndex = class(TComandoFB)
  private
    FsKeyName: string;
    FsTabelaNome: string;
    FsCampos: string;

  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string; override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
      pOutput: IOutput);
    function Funcionou: boolean; override;
  end;

implementation

uses System.StrUtils, System.SysUtils, Sis.DB.Updater.Constants_u,
  Sis.Types.strings_u, Sis.DB.Firebird.GetSQL_u;

{ TComandoFBCreateIndex }

constructor TComandoFBCreateIndex.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
  FsKeyName := '';
  FsTabelaNome := '';
  FsCampos := '';
end;

function TComandoFBCreateIndex.Funcionou: boolean;
var
  sCampos: string;

  bCamposOk: boolean;
  s1, s2: string;
begin
  Sleep(200);
  Result := DBUpdaterOperations.GetIndexInfo(FsKeyName,  sCampos);

  if not Result then
  begin
    UltimoErro := 'TComandoFBCreateIndex, Erro ao testar ' + AsText;
    exit;
  end;
  s1 := StrSemStr(sCampos);
  s2 := StrSemStr(FsCampos);
  bCamposOk := s1 = s2;

  Result := bCamposOk;

  if not Result then
  begin
    UltimoErro :=
      'TComandoFBCreateIndex, Erro. Definida incorretamente ' + AsText;
    exit;
  end;
end;

function TComandoFBCreateIndex.GetAsSql: string;
var
  sTabela, sCampos: string;
  Resultado: boolean;
  sDrop, sCreate, sCabec: string;
  s1, s2: string;
begin
  Result := '';
  DBUpdaterOperations.GetIndexInfo(FsKeyName, sCampos);

  s1 := StrSemStr(sCampos);
  s2 := StrSemStr(FsCampos);

  Resultado := s1 = s2;
  if Resultado then
    exit;

  sDrop := GetSQLDropIndex(FsKeyName)+#13#10;
  sCreate := GetSQLIndex(FsTabelaNome, FsCampos)+#13#10;
  sCabec := #13#10 +
    '/*******'#13#10 +
    '*'#13#10 +
    '* ' + GetAsText + #13#10 +
    '*'#13#10 +
    '*******/'#13#10 +
    Result;

  Result := sCabec + sDrop + sCreate;
end;

function TComandoFBCreateIndex.GetAsText: string;
begin
  Result := 'INDEX ' + FsKeyName + ' ' + FsTabelaNome + ' (' + FsCampos +
    ')';
end;

procedure TComandoFBCreateIndex.PegarLinhas(var piLin: integer; pSL: TStrings);
var
  sLinha: string;
  sObjetoNome: string;
  s: string;
begin
  while piLin < pSL.Count do
  begin
    inc(piLin);
    sLinha := pSL[piLin];
    if Trim(sLinha) = '' then
      continue;

    if sLinha = DBATUALIZ_COMANDO_FIM_CHAVE then
    begin
      dec(piLin);
      break;
    end
    else if Pos(DBATUALIZ_TABELA_CHAVE + '=', sLinha) = 1 then
    begin
      s := StrApos(sLinha, '=');
      FsTabelaNome := s;
    end
    else if Pos(DBATUALIZ_CAMPOS_CHAVE + '=', sLinha) = 1 then
    begin
      s := StrApos(sLinha, '=');
      FsCampos := s;
    end

    else if Pos(DBATUALIZ_OBJETO_NOME_CHAVE + '=', sLinha) = 1 then
    begin
      sObjetoNome := StrApos(sLinha, '=');
      PegarObjeto(sObjetoNome);
    end;
  end;

  if FsKeyName = '' then
  begin
    sObjetoNome := CamposToKeyName(FsTabelaNome, FsCampos, INDEXNAME_SUFIXO);
    PegarObjeto(sObjetoNome);
  end;
end;

procedure TComandoFBCreateIndex.PegarObjeto(pNome: string);
begin
  inherited;
  FsKeyName := pNome;
end;

end.
