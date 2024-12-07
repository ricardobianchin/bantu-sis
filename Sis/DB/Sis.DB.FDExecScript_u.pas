unit Sis.DB.FDExecScript_u;

interface

uses
  FireDAC.Comp.Client, System.Classes, Sis.Types,
  Sis.Threads.Crit.FixedCriticalSection_u;

type
  TFDExecScript = class(TObject)
  private
    FNome: string;
    FUltimoErro: string;
    FThreadSafe: Boolean;
    FCritcalSection: TFixedCriticalSection;
    FFDConnection: TFDConnection;
    FFDCommand: TFDCommand;
    FSql: TStringList;
    FProcExecute: TProcedureOfObject;
    function GetThreadSafe: Boolean;
    procedure SetThreadSafe(const Value: Boolean);

    function GetProcExecute: TProcedureOfObject;
    procedure SetProcExecute(const Value: TProcedureOfObject);

    property ProcExecute: TProcedureOfObject read GetProcExecute write SetProcExecute;

    procedure ExecuteSafe;
    procedure ExecuteNormal;
  public
    procedure Execute;
    procedure PegueComando(pComando: string);
    property ThreadSafe: Boolean read GetThreadSafe write SetThreadSafe;

    constructor Create(pNomeComponente: string; pFDConnection: TFDConnection;
      pCritcalSection: TFixedCriticalSection; pThreadSafe: Boolean = True);
    destructor Destroy; override;
    property UltimoErro: string read FUltimoErro;

  end;

implementation

uses
  System.SysUtils, Sis.Types.strings_u;

{ TFDExecScript }

constructor TFDExecScript.Create(pNomeComponente: string;
  pFDConnection: TFDConnection; pCritcalSection: TFixedCriticalSection;
  pThreadSafe: Boolean);
begin
  FNome := pNomeComponente;
  FCritcalSection := pCritcalSection;
  FThreadSafe := pThreadSafe;
  FFDConnection := pFDConnection;
  FFDCommand := TFDCommand.Create(nil);
  FFDCommand.Connection := pFDConnection;

  FSql := TStringList.Create;
end;

destructor TFDExecScript.Destroy;
begin
  FFDCommand.Free;
  FSql.Free;

  inherited;
end;

procedure TFDExecScript.Execute;
begin
  ProcExecute;
end;

procedure TFDExecScript.ExecuteNormal;
var
  iQtdCommands: integer;
  sComando: string;
  sLog: string;
begin
  try
    sLog := 'vai executar os comandos';
    FFDConnection.StartTransaction;
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
      FFDConnection.Commit;
      FSql.Clear;
    except
      on E: Exception do
      begin
        FUltimoErro := 'TDBExecScriptFireDac.Execute Erro'#13#10#13#10 +
          E.classname + #13#10 + E.message + #13#10 + #13#10 +
          'ao tentar executar:'#13#10'-------'#13#10 + sComando +
          #13#10'-------'#13#10 + UltimoErro + #13#10'Conexao=' +
          '' + #13#10'Componente=' + FNome;
        sLog := sLog + ',' + UltimoErro;
        FFDConnection.Rollback;
        raise Exception.Create(UltimoErro);
      end;
    end;
  finally
  end;
end;

procedure TFDExecScript.ExecuteSafe;
begin
  FCritcalSection.Acquire;
  try
    ExecuteNormal;
  finally
    FCritcalSection.Release;
  end;
end;

function TFDExecScript.GetProcExecute: TProcedureOfObject;
begin
  Result := FProcExecute;
end;

function TFDExecScript.GetThreadSafe: Boolean;
begin
  Result := FThreadSafe;
end;

procedure TFDExecScript.PegueComando(pComando: string);
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

procedure TFDExecScript.SetProcExecute(const Value: TProcedureOfObject);
begin
  FProcExecute := Value;
end;

procedure TFDExecScript.SetThreadSafe(const Value: Boolean);
begin
  FThreadSafe := Value;
  if Value then
    FProcExecute := ExecuteSafe
  else
    FProcExecute := ExecuteNormal;
end;

end.
