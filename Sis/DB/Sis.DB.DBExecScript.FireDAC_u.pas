unit Sis.DB.DBExecScript.FireDAC_u;

interface

uses
  FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.DB,
  Sis.DB.DBExecScript_u, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, FireDAC.Comp.Script, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Async, Sis.Types, System.Generics.Collections,
  Sis.UI.IO.Output.ProcessLog.Registrador,
  Sis.Threads.Crit.FixedCriticalSection_u;

type
  TDBExecScriptFireDac = class(TDBExecScript)
  private
    FFDCommand: TFDCommand;
    FCommands: TArray<string>;
  protected
    function GetParams: TFDParams; override;

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
    sLog := 'retornou de inherited Create,vai FFDScript := FFDCommand.Create(nil);';

    FFDCommand := TFDCommand.Create(nil);
    FFDCommand.Connection := TFDConnection(pDBConnection.ConnectionObject);

    SetLength(FCommands, 0);
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

destructor TDBExecScriptFireDac.Destroy;
begin
  ProcessLog.PegueLocal('TDBExecScriptFireDac.Destroy');
  try
    SetLength(FCommands, 0);
    FreeAndNil(FFDCommand);
    inherited;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBExecScriptFireDac.ExecuteNormal;
var
  sLog: string;
  iQtdCommands: integer;
begin
  ProcessLog.PegueLocal('TDBExecScriptFireDac.Execute');
  try

    sLog := 'vai executar os comandos';
    DBConnection.StartTransaction;
    try
      iQtdCommands := 0;
      for var comando in FCommands do
      begin
        FFDCommand.CommandText.Text := comando;
        FFDCommand.Execute;
        // inc(iQtdCommands);
        // if (iQtdCommands mod 1000) = 0 then
        // Sleep(5);
      end;
      DBConnection.Commit;
    except
      on E: Exception do
      begin
        UltimoErro := 'TDBExecScriptFireDac.Execute Erro'#13#10#13#10 +
          E.classname + #13#10 + E.message + #13#10 + #13#10 +
          'ao tentar executar:'#13#10'-------'#13#10 +
          FFDCommand.CommandText.Text + #13#10'-------'#13#10;
        sLog := sLog + ',' + UltimoErro;
        Output.Exibir(UltimoErro);
        DBConnection.Rollback;
        raise Exception.Create(UltimoErro);
      end;
    end;
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

function TDBExecScriptFireDac.GetParams: TFDParams;
begin
  Result := FFDCommand.Params;
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
    if not CharInSet(UltimoChar, [#9, #32, #10, #13]) then
      break;
    pComando := StrDeleteNoFim(pComando, 1);
  until False;

  if UltimoChar <> ';' then
    pComando := pComando + ';';

  SetLength(FCommands, Length(FCommands) + 1);
  FCommands[High(FCommands)] := pComando;
end;

end.
