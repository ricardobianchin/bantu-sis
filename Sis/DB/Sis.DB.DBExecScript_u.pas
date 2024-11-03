unit Sis.DB.DBExecScript_u;

interface

uses
  FireDAC.Stan.Param, System.Classes, Data.DB, Sis.DB.DBSQLOperation_u,
  Sis.DB.DBTypes;

type
  TDBExecScript = class(TDBSqlOperation, IDBExecScript)
  private
  protected

    function GetScriptTamanhoMaximo: integer; virtual; abstract;
    function GetScriptTamanho:       integer; virtual; abstract;

    property ScriptTamanhoMaximo: integer read GetScriptTamanhoMaximo;
    property ScriptTamanho:       integer read GetScriptTamanho;
  public
    procedure Execute; virtual; abstract;
    procedure PegueComando(pComando: string); virtual;
  end;

implementation

{ TDBExecScript }

procedure TDBExecScript.PegueComando(pComando: string);
var
  iTamanhoFuturo: integer;
begin
  iTamanhoFuturo := ScriptTamanho + 4{enteres} + Length(pComando);
  if iTamanhoFuturo > iTamanhoFuturo then
    Execute;
end;

end.
