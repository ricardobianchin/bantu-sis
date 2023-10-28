unit btu.lib.db.updater.comando.fb.createsequence_u;

interface

uses btu.lib.db.updater.comando, System.Classes, btu.lib.db.updater.campo.list,
  btu.lib.db.types, btu.lib.db.updater.comando.fb_u,
  btu.lib.db.updater.operations,
  sis.ui.io.log, sis.ui.io.output;

type
  TComandoFBCreateSequence = class(TComandoFB)
  private
    FNomeSequence: string;
    FValorInicial: integer;

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

uses btu.lib.db.updater.constants_u, btu.lib.db.updater.factory,
  sis.types.strings, btu.sis.db.updater.utils, System.StrUtils,
  System.SysUtils;

{ TComandoFBCreateSequence }

constructor TComandoFBCreateSequence.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pLog, pOutput);
  FValorInicial := 0;
end;

function TComandoFBCreateSequence.Funcionou: boolean;
var
  Resultado: boolean;
begin
  Resultado := DBUpdaterOperations.SequenceExiste(FNomeSequence);

  Result := Resultado;
end;

function TComandoFBCreateSequence.GetAsSql: string;
begin
  Result := '';
  if DBUpdaterOperations.SequenceExiste(FNomeSequence) then
    exit;

  Result := 'CREATE SEQUENCE ' + FNomeSequence;

  if FValorInicial <> 0 then
    Result := Result + 'RESTART WITH ' + FValorInicial.ToString;

  Result :=
    #13#10
    +'/*******'#13#10
    +'*'#13#10
    +'* ' + GetAsText + #13#10
    +'*'#13#10
    +'*******/'#13#10
    + Result
    + ';'
    ;
end;

function TComandoFBCreateSequence.GetAsText: string;
begin
  Result := 'SEQUENCE ' + FNomeSequence + ' STARTS WITH ' + FValorInicial.ToString;
end;

procedure TComandoFBCreateSequence.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  sObjetoNome: string;
  sValorInicial: string;
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
    else if Pos(DBATUALIZ_VALOR_INICIAL_CHAVE + '=', sLinha) = 1 then
    begin
      sValorInicial := StrApos(sLinha, '=');
      if not TryStrToInt(sValorInicial, FValorInicial) then
      begin
        UltimoErro := 'TComandoFBCreateSequence, Erro ao criar a sequence ' +
          FNomeSequence + '. Verifique a sintaxe do valor inicial';
        raise Exception.Create('TComandoFBCreateSequence, Erro no updater '+ UltimoErro);
      end;
    end
    else if Pos(DBATUALIZ_OBJETO_NOME_CHAVE + '=', sLinha) = 1 then
    begin
      sObjetoNome := StrApos(sLinha, '=');
      PegarObjeto(sObjetoNome);
    end;
  end;
end;

procedure TComandoFBCreateSequence.PegarObjeto(pNome: string);
begin
  inherited;
  FNomeSequence := pNome;
end;

end.
