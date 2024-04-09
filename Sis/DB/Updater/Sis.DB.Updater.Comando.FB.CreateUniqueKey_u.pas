unit Sis.DB.Updater.Comando.FB.CreateUniqueKey_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.DBTypes,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

type
  TComandoFBCreateUniqueKey = class(TComandoFB)
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

{ TComandoFBCreateUniqueKey }

constructor TComandoFBCreateUniqueKey.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
  FsKeyName := '';
  FsTabelaNome := '';
  FsCampos := '';
end;

function TComandoFBCreateUniqueKey.Funcionou: boolean;
var
  sCampos: string;

  bCamposOk: boolean;
  s1, s2: string;
begin
  Sleep(200);
  Result := DBUpdaterOperations.GetUniqueKeyInfo(FsKeyName,  sCampos);

  if not Result then
  begin
    UltimoErro := 'TComandoFBCreateUniqueKey, Erro ao testar ' + AsText;
    exit;
  end;
  s1 := StrSemStr(sCampos);
  s2 := StrSemStr(FsCampos);
  bCamposOk := s1 = s2;

  Result := bCamposOk;

  if not Result then
  begin
    UltimoErro :=
      'TComandoFBCreateUniqueKey, Erro. Definida incorretamente ' + AsText;
    exit;
  end;
end;

function TComandoFBCreateUniqueKey.GetAsSql: string;
var
  sTabela, sCampos: string;
  Resultado: boolean;
  sDrop, sCreate, sCabec: string;
  s1, s2: string;
begin
  Result := '';
  DBUpdaterOperations.GetUniqueKeyInfo(FsKeyName, sCampos);

  s1 := StrSemStr(sCampos);
  s2 := StrSemStr(FsCampos);

  Resultado := s1 = s2;
  if Resultado then
    exit;

  sDrop := GetSQLDropUniqueKey(FsTabelaNome, FsKeyName)+#13#10;
  sCreate := GetSQLUniqueKey(FsTabelaNome, FsCampos)+#13#10;
  sCabec := #13#10 +
    '/*******'#13#10 +
    '*'#13#10 +
    '* ' + GetAsText + #13#10 +
    '*'#13#10 +
    '*******/'#13#10 +
    Result;

  Result := sCabec + sDrop + sCreate;
end;

function TComandoFBCreateUniqueKey.GetAsText: string;
begin
  Result := 'UNIQUE KEY ' + FsKeyName + ' ' + FsTabelaNome + ' (' + FsCampos +
    ')';
end;

procedure TComandoFBCreateUniqueKey.PegarLinhas(var piLin: integer;
  pSL: TStrings);
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
    sObjetoNome := CamposToKeyName(FsTabelaNome, FsCampos, UKINDEXNAME_SUFIXO);
    PegarObjeto(sObjetoNome);
  end;
end;

procedure TComandoFBCreateUniqueKey.PegarObjeto(pNome: string);
begin
  inherited;
  FsKeyName := pNome;
end;

end.
