unit Sis.DB.DBExecScript.FireDAC_u;

interface

uses
  FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.DB,
  Sis.DB.DBExecScript_u, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output,
  FireDAC.Comp.Script, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Async;

type
  TDBExecScriptFireDac = class(TDBExecScript)
  private
    FFDScript: TFDScript;

  const
    SQL_MAXLENGTH = 9000;
  protected
    function GetScriptTamanhoMaximo: integer; override;
    function GetScriptTamanho: integer; override;
  public
    procedure Execute; override;
    procedure PegueComando(pComando: string); override;
    constructor Create(pNomeComponente: string; pDBConnection: IDBConnection;
      pProcessLog: IProcessLog; pOutput: IOutput);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils;

{ TDBExecScriptFireDac }

constructor TDBExecScriptFireDac.Create(pNomeComponente: string;
  pDBConnection: IDBConnection; pProcessLog: IProcessLog; pOutput: IOutput);
var
  sLog: string;
begin
  pProcessLog.PegueLocal('TDBExecScriptFireDac.Create');
  try
    inherited Create(pNomeComponente, pDBConnection, pProcessLog, pOutput);
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

procedure TDBExecScriptFireDac.Execute;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBExecScriptFireDac.Execute');
  try
    // inherited;
    try
      sLog := SQL + ',' + GetParamsAsStr + ', vai FFDScript.ValidateAll';
      FFDScript.ValidateAll;
      sLog := SQL + ', vai FFDScript.ExecuteAll';
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

function TDBExecScriptFireDac.GetScriptTamanho: integer;
begin
  Result := FFDScript.SQLScripts[0].SQL.Text.Length
end;

function TDBExecScriptFireDac.GetScriptTamanhoMaximo: integer;
begin
  Result := SQL_MAXLENGTH;
end;

procedure TDBExecScriptFireDac.PegueComando(pComando: string);
begin
  inherited;
  // precisa manter este inherited. tem testes feitos na classe ancestral
  FFDScript.SQLScripts[0].SQL.Add(pComando);
END;

end.
