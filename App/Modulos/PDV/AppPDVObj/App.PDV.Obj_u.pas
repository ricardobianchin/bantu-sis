unit App.PDV.Obj_u;

interface

uses App.PDV.Obj;

type
  TPDVObj = class(TInterfacedObject, IAppPDVObj)
  private
  protected
    function GetFiscal: Boolean; virtual;
  public
    property Fiscal: Boolean read GetFiscal;
  end;

implementation

{ TAppPDVObj }

function TAppPDVObj.GetFiscal: Boolean;
begin
  Result := True;
end;

end.

end.
