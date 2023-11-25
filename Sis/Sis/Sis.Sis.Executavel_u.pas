unit Sis.Sis.Executavel_u;

interface

uses Sis.Sis.Executavel, Sis.UI.IO.Output;

type
  TExecutavel = class(TInterfacedObject, IExecutavel)
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

{ TExecutavel }

uses Sis.UI.IO.Factory;

constructor TExecutavel.Create(pOutput: IOutput);
begin
  if Assigned(pOutput) then
    FOutput := pOutput
  else
    FOutput := MudoOutputCreate;
end;

procedure TExecutavel.Exib(pFrase: string);
begin
  if Assigned(FOutput) then
    FOutput.Exibir(pFrase)
end;

function TExecutavel.GetCaption: string;
begin
  Result := '';
end;

end.
