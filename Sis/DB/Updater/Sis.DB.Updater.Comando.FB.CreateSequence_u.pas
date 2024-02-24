unit Sis.DB.Updater.Comando.FB.CreateSequence_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.DBTypes,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

type
  TComandoFBCreateSequence = class(TComandoFB)
  private
    FNomeSequence: string;
    FValorInicial: integer;

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
  Sis.Types.strings_u;

{ TComandoFBCreateSequence }

constructor TComandoFBCreateSequence.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
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
    Result := Result + ' START WITH ' + FValorInicial.ToString;

  Result := #13#10 + '/*******'#13#10 + '*'#13#10 + '* ' + GetAsText + #13#10 +
    '*'#13#10 + '*******/'#13#10 + Result + ';';
end;

function TComandoFBCreateSequence.GetAsText: string;
begin
  Result := 'SEQUENCE ' + FNomeSequence + ' STARTS WITH ' +
    FValorInicial.ToString;
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
        raise Exception.Create('TComandoFBCreateSequence, Erro no updater ' +
          UltimoErro);
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
