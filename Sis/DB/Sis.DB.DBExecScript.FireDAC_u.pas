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
    FSql: TStringList;
  protected
    function GetParams: TFDParams; override;
    function GetSQL: TStrings; override;

    procedure ExecuteNormal; override;
  public
    procedure PegueComando(pComando: string); override;
    constructor Create(pNomeComponente: string; pDBConnection: IDBConnection;
      pProcessLog: IProcessLog; pOutput: IOutput;
      pCritcalSection: TFixedCriticalSection; pThreadSafe: Boolean = True);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.strings_u, Sis.UI.IO.Output.ProcessLog.Factory;

{ TDBExecScriptFireDac }

constructor TDBExecScriptFireDac.Create(pNomeComponente: string;
  pDBConnection: IDBConnection; pProcessLog: IProcessLog; pOutput: IOutput;
  pCritcalSection: TFixedCriticalSection; pThreadSafe: Boolean);
var
  sLog: string;
begin
  if not Assigned(pProcessLog) then
    pProcessLog := MudoProcessLogCreate;
  pProcessLog.PegueLocal('TDBExecScriptFireDac.Create');
  try
    inherited Create(pNomeComponente, pDBConnection, pProcessLog, pOutput,
      pCritcalSection, pThreadSafe);
    sLog := 'retornou de inherited Create,vai FFDScript := FFDCommand.Create(nil);';

    FFDCommand := TFDCommand.Create(nil);
    FFDCommand.Connection := TFDConnection(pDBConnection.ConnectionObject);
    FSql := TStringList.Create;
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

destructor TDBExecScriptFireDac.Destroy;
begin
  ProcessLog.PegueLocal('TDBExecScriptFireDac.Destroy');
  try
    FreeAndNil(FFDCommand);
    FreeAndNil(FSql);
    inherited;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBExecScriptFireDac.ExecuteNormal;
var
  sLog: string;
  iQtdCommands: integer;
  sComando: string;
begin
  ProcessLog.PegueLocal('TDBExecScriptFireDac.Execute');
  try
    sLog := 'vai executar os comandos';
    DBConnection.StartTransaction;
    try
      iQtdCommands := 0;
      for var i := 0 to FSql.Count - 1 do
      begin
        sComando := FSql[i];
        FFDCommand.CommandText.Text := sComando;
        FFDCommand.Execute;

        inc(iQtdCommands);
        if (iQtdCommands mod 333) = 0 then
          Sleep(5);
      end;
      DBConnection.Commit;
      FSql.Clear;
    except
      on E: Exception do
      begin
        UltimoErro := 'TDBExecScriptFireDac.Execute Erro'#13#10#13#10 +
          E.classname + #13#10 + E.message + #13#10 + #13#10 +
          'ao tentar executar:'#13#10'-------'#13#10 + sComando +
          #13#10'-------'#13#10 + UltimoErro + #13#10'Conexao=' +
          DBConnection.Nome + #13#10'Componente=' + Nome;
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

function TDBExecScriptFireDac.GetSQL: TStrings;
begin
  Result := FSql;
end;

procedure TDBExecScriptFireDac.PegueComando(pComando: string);
var
  UltimoChar: char;
begin
  inherited;
  pComando := Trim(pComando);
  if pComando = '' then
    exit;

  StrDeleteTrailingChars(pComando, [#9, #32, #10, #13]);
  StrGarantirTermino(pComando, ';');
  FSql.Add(pComando);
end;

end.
