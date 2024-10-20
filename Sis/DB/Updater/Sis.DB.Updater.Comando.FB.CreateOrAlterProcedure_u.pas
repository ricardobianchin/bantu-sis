unit Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, Sis.DB.Updater.Operations;

type
  TComandoFBCreateOrAlterProcedure = class(TComandoFB)
  private
    FProcedureName: string;
    FProcedureDefSL: TStringList;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string; override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pVersaoDB: integer; pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
      pOutput: IOutput);
    function Funcionou: boolean; override;
    destructor Destroy; override;

  end;

implementation

{ TComandoFBCreateOrAlterProcedure }

uses Sis.DB.Updater.Constants_u, Sis.Types.strings_u;

constructor TComandoFBCreateOrAlterProcedure.Create(pVersaoDB: integer;
  pDBConnection: IDBConnection; pUpdaterOperations: IDBUpdaterOperations;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create(pVersaoDB, pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
  FProcedureDefSL := TStringList.Create;
end;

destructor TComandoFBCreateOrAlterProcedure.Destroy;
begin
  FProcedureDefSL.Free;
  inherited;
end;

function TComandoFBCreateOrAlterProcedure.Funcionou: boolean;
begin
  Result := DBUpdaterOperations.ProcedureExiste(FProcedureName);
  if not Result then
  begin
    UltimoErro := 'TComandoFBCreateOrAlterProcedure, Erro ao criar a procedure '
      + FProcedureName;
    exit;
  end;
end;

function TComandoFBCreateOrAlterProcedure.GetAsSql: string;
var
  Resultado: boolean;
begin
  Result := '';

  Resultado := DBUpdaterOperations.ProcedureExiste(FProcedureName);
  if Resultado then
    exit;

  Result := FProcedureDefSL.Text;

  if Result = '' then
    exit;

  Result := #13#10 + '/*******'#13#10 + '*'#13#10 + '* ' + GetAsText + #13#10 +
    '*'#13#10 + '*******/'#13#10 + Result;
end;

function TComandoFBCreateOrAlterProcedure.GetAsText: string;
begin
  Result := 'PROCEDURE ' + FProcedureName;
end;

procedure TComandoFBCreateOrAlterProcedure.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  bPegandoProcedure: boolean;
  sObjetoNome: string;
begin
  bPegandoProcedure := false;
  FProcedureDefSL.Clear;
  while piLin < pSL.Count do
  begin
    inc(piLin);
    sLinha := pSL[piLin];

    if bPegandoProcedure then
    begin
      if sLinha = SYNTAX_FIM then
      begin
        // bPegandoProcedure := False;
        break;
      end;
      FProcedureDefSL.Add(sLinha);
    end
    else if sLinha = SYNTAX_FIREBIRD_INI then
    begin
      bPegandoProcedure := True;
    end
    else if Pos(DBATUALIZ_OBJETO_NOME_CHAVE + '=', sLinha) = 1 then
    begin
      sObjetoNome := StrApos(sLinha, '=');
      PegarObjeto(sObjetoNome);
    end;
  end;
end;

procedure TComandoFBCreateOrAlterProcedure.PegarObjeto(pNome: string);
begin
  FProcedureName := pNome;
end;

end.
