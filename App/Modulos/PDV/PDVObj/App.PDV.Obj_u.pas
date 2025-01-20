unit App.PDV.Obj_u;

interface

uses App.PDV.Obj, Sis.Entities.Terminal, App.PDV.UI.Gaveta;

type
  TPDVObj = class(TInterfacedObject, IPDVObj)
  private
    FTerminal: ITerminal;
    FGaveta: IGaveta;

    function GetGaveta: IGaveta;
  protected
    function GetFiscal: Boolean; virtual;
  public
    property Fiscal: Boolean read GetFiscal;
    property Gaveta: IGaveta read GetGaveta;

    constructor Create(pTerminal: ITerminal);
  end;

implementation

{ TPDVObj }

uses App.PDV.Factory_u;

constructor TPDVObj.Create(pTerminal: ITerminal);
begin
  FTerminal := pTerminal;
  FGaveta := GavetaCreate(FTerminal);
end;

function TPDVObj.GetFiscal: Boolean;
begin
  Result := True;
end;

function TPDVObj.GetGaveta: IGaveta;
begin
  Result := FGaveta;
end;

end.

end.
