unit Sis.DB.Updater.Comando.FB.CreateForeignKey_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.DBTypes,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

type
  TComandoFBCreateForeignKey = class(TComandoFB)
  private
    FsKeyName: string;
    FsTabelaFK: string;
    FsCamposFK: string;
    FsTabelaPK: string;
    FsCamposPK: string;

  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string; override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pVersaoDB: integer; pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
      pOutput: IOutput); override;
    function Funcionou: boolean; override;
  end;

implementation

uses System.StrUtils, System.SysUtils, Sis.DB.Updater.Constants_u,
  Sis.Types.strings_u;

{ TComandoFBCreateForeignKey }

constructor TComandoFBCreateForeignKey.Create(pVersaoDB: integer; pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput);
begin
  inherited Create(pVersaoDB, pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
  FsKeyName := '';
  FsTabelaFK := '';
  FsCamposFK := '';
  FsTabelaPK := '';
  FsCamposPK := '';

end;

function TComandoFBCreateForeignKey.Funcionou: boolean;
var
  sTabelaFK, sCamposFK, sTabelaPK, sCamposPK: string;

  bTabFkOk: boolean;
  bCamposFkOk: boolean;
  bTabPkOk: boolean;
  bCamposPkOk: boolean;
begin
  Result := DBUpdaterOperations.GetForeignKeyInfo(FsKeyName, sTabelaFK,
    sCamposFK, sTabelaPK, sCamposPK);

  if not Result then
  begin
    UltimoErro := 'TComandoFBCreateForeignKey, Erro ao testar ' + AsText;
    exit;
  end;

  Result := sTabelaFK <> '';
  if not Result then
  begin
    UltimoErro := 'TComandoFBCreateForeignKey, Erro. N�o existe ' + AsText;
    exit;
  end;

  bTabFkOk := sTabelaFK = FsTabelaFK;
  bCamposFkOk := sCamposFK = FsCamposFK;
  bTabPkOk := sTabelaPK = FsTabelaPK;
  bCamposPkOk := sCamposPK = FsCamposPK;

  Result := bTabFkOk and bCamposFkOk and bTabPkOk and bCamposPkOk;

  if not Result then
  begin
    UltimoErro :=
      'TComandoFBCreateForeignKey, Erro. Definida incorretamente ' + AsText;
    exit;
  end;
end;

function TComandoFBCreateForeignKey.GetAsSql: string;
var
  sTabelaFK, sCamposFK, sTabelaPK, sCamposPK: string;
  Resultado: boolean;
begin
  Result := '';
  DBUpdaterOperations.GetForeignKeyInfo(FsKeyName, sTabelaFK, sCamposFK,
    sTabelaPK, sCamposPK);

  if sTabelaFK <> '' then
  begin
    Resultado := (sTabelaFK = FsTabelaFK) and (sCamposFK = FsCamposFK) and
      (sTabelaPK = FsTabelaPK) and (sCamposPK = FsCamposPK);
    if Resultado then
      exit;

    Result := Result //
      + 'ALTER TABLE ' + FsTabelaFK //
      + ' DROP CONSTRAINT ' //
      +  FsKeyName + ';'#13#10 //
      ;
  end;

  Result := Result //
    + 'ALTER TABLE ' + FsTabelaFK + #13#10 //
    + 'ADD CONSTRAINT ' //
    + FsKeyName + #13#10 //
    + 'FOREIGN KEY (' + FsCamposFK + ')'#13#10 //
    + 'REFERENCES ' //
    + FsTabelaPK + ' (' + FsCamposPK + ');'#13#10 //
    ;

  Result := //
    #13#10 //
    + '/*******'#13#10 //
    + '*'#13#10 //
    + '* ' + GetAsText //
    + #13#10 //
    + '*'#13#10 //
    + '*******/'#13#10 //
    + Result //
    ;
end;

function TComandoFBCreateForeignKey.GetAsText: string;
begin
  Result := 'FOREIGN KEY ' + FsKeyName + ' ' + FsTabelaFK + ' (' + FsCamposFK +
    ') REFERENCES ' + FsTabelaPK + ' (' + FsCamposPK + ')';
end;

procedure TComandoFBCreateForeignKey.PegarLinhas(var piLin: integer;
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
    else if Pos(DBATUALIZ_TABELA_FK_CHAVE + '=', sLinha) = 1 then
    begin
      s := StrApos(sLinha, '=');
      FsTabelaFK := s;
    end
    else if Pos(DBATUALIZ_CAMPOS_FK_CHAVE + '=', sLinha) = 1 then
    begin
      s := StrApos(sLinha, '=');
      FsCamposFK := StrSemStr(s);
    end

    else if Pos(DBATUALIZ_TABELA_PK_CHAVE + '=', sLinha) = 1 then
    begin
      s := StrApos(sLinha, '=');
      FsTabelaPK := s;
    end
    else if Pos(DBATUALIZ_CAMPOS_PK_CHAVE + '=', sLinha) = 1 then
    begin
      s := StrApos(sLinha, '=');
      FsCamposPK := StrSemStr(s);
    end

    else if Pos(DBATUALIZ_OBJETO_NOME_CHAVE + '=', sLinha) = 1 then
    begin
      sObjetoNome := StrApos(sLinha, '=');
      PegarObjeto(sObjetoNome);
    end;
  end;

  if FsKeyName = '' then
  begin
    sObjetoNome := FsTabelaFK + '_REF_' + FsTabelaPK + '_FK';
    sObjetoNome := TruncSnakeCase(sObjetoNome, FB_MAX_IDENTIFIER_LENGHT);
    PegarObjeto(sObjetoNome);
  end;

  if FsCamposPK = '' then
  begin
    FsCamposPK := FsCamposFK;
  end;
end;

procedure TComandoFBCreateForeignKey.PegarObjeto(pNome: string);
begin
  inherited;
  FsKeyName := pNome;
end;

end.
