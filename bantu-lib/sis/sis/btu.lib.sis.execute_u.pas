unit btu.lib.sis.execute_u;

interface

uses btu.lib.sis.execute, btu.sis.ui.io.output;

type
  TExecute = class(TInterfacedObject, IExecute)
  private
    FOutput: IOutput;
  protected
    property Output: IOutput read FOutput;
    function GetCaption: string; virtual;
    procedure Exib(pFrase: string);virtual;
  public
    constructor Create(pOutput: IOutput=nil);
    function Execute: boolean; virtual; abstract;
  end;

implementation

{ TExecute }

uses btu.sis.ui.io.factory;

constructor TExecute.Create(pOutput: IOutput);
begin
  if Assigned(pOutput) then
    FOutput := pOutput
  else
    FOutput := OutputMudoCreate;
end;

procedure TExecute.Exib(pFrase: string);
begin
  if Assigned(FOutput) then
    FOutput.Exibir(pFrase)
end;

function TExecute.GetCaption: string;
begin
  Result := '';
end;

end.
