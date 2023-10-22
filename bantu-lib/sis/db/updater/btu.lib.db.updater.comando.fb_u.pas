unit btu.lib.db.updater.comando.fb_u;

interface

uses btu.lib.db.updater.comando, System.Classes,
  btu.lib.db.types, btu.lib.db.updater.operations, sis.ui.io.output,
  sis.ui.io.log;

type
  TComandoFB = class(TInterfacedObject, IComando)
  private
    FDBConnection: IDBConnection;
    FUltimoErro: string;
    FDBUpdaterOperations: IDBUpdaterOperations;
    FLog: ILog;
    FOutput: IOutput;

    function GetUltimoErro: string;
    procedure SetUltimoErro(Value: string);

    function GetLog: ILog;
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
    property Log: ILog read GetLog;
    property Output: IOutput read GetOutput;
    property AsText: string read GetAsText;

    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
  end;

implementation

{ TComandoFB }

constructor TComandoFB.Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
begin
  FDBConnection := pDBConnection;
  FLog := pLog;
  FOutput := pOutput;
  FUltimoErro := '';
  FDBUpdaterOperations := pUpdaterOperations;
end;

function TComandoFB.GetDBConnection: IDBConnection;
begin
  Result := FDBConnection;
end;

function TComandoFB.GetLog: ILog;
begin
  Result := FLog;
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
