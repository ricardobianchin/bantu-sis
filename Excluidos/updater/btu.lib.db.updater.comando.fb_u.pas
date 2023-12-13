unit btu.lib.db.updater.comando.fb_u;

interface

uses btu.lib.db.updater.comando, System.Classes,
  btu.lib.db.types, btu.lib.db.updater.operations, sis.ui.io.output,
  sis.ui.io.ProcessLog;

type
  TComandoFB = class(TInterfacedObject, IComando)
  private
    FDBConnection: IDBConnection;
    FUltimoErro: string;
    FDBUpdaterOperations: IDBUpdaterOperations;
    FProcessLog: IProcessLog;
    FOutput: IOutput;

    function GetUltimoErro: string;
    procedure SetUltimoErro(Value: string);

    function GetProcessLog: IProcessLog;
    function GetOutput: IOutput;

    function GetDBConnection: IDBConnection;

  protected
    procedure PegarObjeto(pNome: string); virtual; abstract;
    property DBConnection: IDBConnection read GetDBConnection;
    property DBUpdaterOperations: IDBUpdaterOperations read FDBUpdaterOperations;
    function GetAsText: string; virtual; abstract;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); virtual; abstract;
    function GetAsSql: string; virtual; abstract;
    function Funcionou: boolean; virtual; abstract;

    property UltimoErro: string read GetUltimoErro write SetUltimoErro;
    property ProcessLog: IProcessLog read GetProcessLog;
    property Output: IOutput read GetOutput;
    property AsText: string read GetAsText;

    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput);
  end;

implementation

{ TComandoFB }

constructor TComandoFB.Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FDBConnection := pDBConnection;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FUltimoErro := '';
  FDBUpdaterOperations := pUpdaterOperations;
end;

function TComandoFB.GetDBConnection: IDBConnection;
begin
  Result := FDBConnection;
end;

function TComandoFB.GetProcessLog: IProcessLog;
begin
  Result := FProcessLog;
end;

function TComandoFB.GetOutput: IOutput;
begin
  Result := FOutput;
end;

function TComandoFB.GetUltimoErro: string;
begin
  Result := FUltimoErro;
end;

procedure TComandoFB.SetUltimoErro(Value: string);
begin
  FUltimoErro := Value;
end;

end.
