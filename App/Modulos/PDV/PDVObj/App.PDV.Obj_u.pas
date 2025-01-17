unit App.PDV.Obj_u;

interface

uses App.PDV.Obj, Sis.Entities.Terminal;

type
  TPDVObj = class(TInterfacedObject, IPDVObj)
  private
    FTerminal: ITerminal;
  protected
    function GetFiscal: Boolean; virtual;
  public
    property Fiscal: Boolean read GetFiscal;
    constructor Create(pTerminal: ITerminal);
  end;

implementation

{ TPDVObj }

constructor TPDVObj.Create(pTerminal: ITerminal);
begin
  FTerminal := pTerminal;
end;

function TPDVObj.GetFiscal: Boolean;
begin
  Result := True;
end;

end.

end.
