unit btu.lib.db.updater.comando.fb.createoralterprocedure_u;

interface

uses btu.lib.db.updater.comando, System.Classes, btu.lib.db.updater.campo.list,
  btu.lib.db.types, btu.lib.db.updater.comando.fb_u, btu.lib.db.updater.operations,
  btu.sis.ui.io.log, btu.sis.ui.io.output;

type
  TComandoFBCreateOrAlterProcedure = class(TComandoFB)
  private
    FProcedureName: string;
    FProcedureDefSL: TStringList;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string;  override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection; pUpdaterOperations: IDBUpdaterOperations;
      pLog: ILog; pOutput: IOutput);
    function Funcionou: boolean; override;
    destructor Destroy; override;

  end;

implementation

uses btu.lib.db.updater.constants_u, btu.lib.db.updater.campo,
  btu.lib.db.updater.factory, btn.lib.types.strings, btu.sis.db.updater.utils;

{ TComandoFBCreateOrAlterProcedure }

constructor TComandoFBCreateOrAlterProcedure.Create(pDBConnection
  : IDBConnection; pUpdaterOperations: IDBUpdaterOperations; pLog: ILog;
  pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pLog, pOutput);
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
    UltimoErro :=
      'TComandoFBCreateOrAlterProcedure, Erro ao criar a procedure ' +
      FProcedureName;
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

function TComandoFBCreateOrAlterProcedure.GetAsText: string;
begin
  Result := 'PROCEDURE ' + FProcedureName;
end;

procedure TComandoFBCreateOrAlterProcedure.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  bPegandoProcedure: boolean;
  oCampo: ICampo;
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
        bPegandoProcedure := False;
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
