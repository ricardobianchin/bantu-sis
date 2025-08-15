unit Sis.Sis.Executavel_u;

interface

uses Sis.Sis.Executavel, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TExecutavel = class(TInterfacedObject, IExecutavel)
  private
    FOutput: IOutput;
    FProcessLog: IProcessLog;
  protected
    property Output: IOutput read FOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    function GetCaption: string; virtual;
    procedure Exib(pFrase: string);virtual;
  public
    constructor Create(pOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
    function Execute: boolean; virtual; abstract;
  end;

implementation

{ TExecutavel }

uses Sis.UI.IO.Factory, Sis.UI.IO.Output.ProcessLog.Factory;

constructor TExecutavel.Create(pOutput: IOutput; pProcessLog: IProcessLog);
begin
  if Assigned(pOutput) then
    FOutput := pOutput
  else
    FOutput := MudoOutputCreate;

  if Assigned(pProcessLog) then
    FProcessLog := pProcessLog
  else
    FProcessLog := MudoProcessLogCreate;
end;

procedure TExecutavel.Exib(pFrase: string);
begin
  FOutput.Exibir(pFrase)
end;

function TExecutavel.GetCaption: string;
begin
  Result := '';
end;

end.
