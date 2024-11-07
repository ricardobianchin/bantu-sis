unit Sis.DB.DBExecScript.FireDAC_u;

interface

uses
  FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.DB,
  Sis.DB.DBExecScript_u, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, FireDAC.Comp.Script, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Async, Sis.Types,
  Sis.UI.IO.Output.ProcessLog.Registrador,
  Sis.Threads.Crit.FixedCriticalSection_u;

type
  TDBExecScriptFireDac = class(TDBExecScript)
  private
    FFDScript: TFDScript;

  const
    SQL_MAXLENGTH = 9000;
  protected
    function GetParams: TFDParams; override;
    function GetSQL: string; override;
    procedure SetSQL(Value: string); override;

    function GetScriptTamanhoMaximo: integer; override;
    function GetScriptTamanho: integer; override;
    procedure ExecuteNormal; override;
  public
    procedure PegueComando(pComando: string); override;
    constructor Create(pNomeComponente: string; pDBConnection: IDBConnection;
      pProcessLog: IProcessLog; pOutput: IOutput;
      pCritcalSection: TFixedCriticalSection; pThreadSafe: Boolean = True);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.strings_u;

{ TDBExecScriptFireDac }

constructor TDBExecScriptFireDac.Create(pNomeComponente: string;
  pDBConnection: IDBConnection; pProcessLog: IProcessLog; pOutput: IOutput;
  pCritcalSection: TFixedCriticalSection; pThreadSafe: Boolean);
var
  sLog: string;
begin
  pProcessLog.PegueLocal('TDBExecScriptFireDac.Create');
  try
    inherited Create(pNomeComponente, pDBConnection, pProcessLog, pOutput,
      pCritcalSection, pThreadSafe);
    sLog := 'retornou de inherited Create,vai FFDScript := TFDScript.Create(nil);';
    FFDScript := TFDScript.Create(nil);
    FFDScript.Connection := TFDConnection(pDBConnection.ConnectionObject);
    FFDScript.SQLScripts.Add;
    FFDScript.SQLScripts[0].SQL.Clear;
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

destructor TDBExecScriptFireDac.Destroy;
begin
  ProcessLog.PegueLocal('TDBExecScriptFireDac.Destroy');
  try
    FFDScript.Free;
    inherited;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBExecScriptFireDac.ExecuteNormal;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBExecScriptFireDac.Execute');
  try
    if ScriptTamanho = 0 then
      exit;

    // inherited;
    try
      sLog := SQL + ', vai FFDScript.ValidateAll';
      FFDScript.ValidateAll;
      sLog := sLog + ', vai FFDScript.ExecuteAll';
      FFDScript.ExecuteAll;
    except
      on E: Exception do
      begin
        UltimoErro := 'TDBExecScriptFireDac.Execute Erro'#13#10#13#10 +
          E.classname + #13#10 + E.message + #13#10 + #13#10 +
          'ao tentar executar:'#13#10#13#10 + SQL;
        sLog := sLog + ',' + UltimoErro;
        Output.Exibir(UltimoErro);
        raise Exception.Create(UltimoErro);
      end;
    end;
    FFDScript.SQLScripts[0].SQL.Clear;
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

function TDBExecScriptFireDac.GetParams: TFDParams;
begin
  Result := FFDScript.Params;
end;

function TDBExecScriptFireDac.GetScriptTamanho: integer;
begin
  Result := FFDScript.SQLScripts[0].SQL.Text.Length
end;

function TDBExecScriptFireDac.GetScriptTamanhoMaximo: integer;
begin
  Result := SQL_MAXLENGTH;
end;

function TDBExecScriptFireDac.GetSQL: string;
begin
  Result := FFDScript.SQLScripts[0].SQL.Text
end;

procedure TDBExecScriptFireDac.PegueComando(pComando: string);
var
  UltimoChar: char;
begin
  inherited;
  pComando := Trim(pComando);
  if pComando = '' then
    exit;
  repeat
    UltimoChar := pComando[Length(pComando)];
    if not CharInSet(UltimoChar, [#32, #13, #13]) then
      break;
    pComando := StrDeleteNoFim(pComando, 1);
  until False;

  if UltimoChar <> ';' then
    pComando := pComando + ';';

  pComando := pComando + #13#10;

  // precisa manter este inherited. tem testes feitos na classe ancestral
  FFDScript.SQLScripts[0].SQL.Add(pComando+#13#10);
end;

procedure TDBExecScriptFireDac.SetSQL(Value: string);
begin
  inherited;
  FFDScript.SQLScripts[0].SQL.Text := Value;
end;

end.
