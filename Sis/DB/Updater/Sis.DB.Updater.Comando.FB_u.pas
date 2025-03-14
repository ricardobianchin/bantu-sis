unit Sis.DB.Updater.Comando.FB_u;

interface

uses System.Classes, Sis.DB.Updater.Comando, Sis.DB.DBTypes,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

type
  TComandoFB = class(TInterfacedObject, IComando)
  private
    FVersaoDB: integer;
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
    property VersaoDB: integer read FVersaoDB;
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

    constructor Create(pVersaoDB: integer; pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput);
  end;

implementation

{ TComandoFB }

constructor TComandoFB.Create(pVersaoDB: integer; pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FVersaoDB := pVersaoDB;
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
