unit App.PDV.AppPDVObj_u;

interface

uses App.PDV.AppPDVObj;

type
  TAppPDVObj = class(TInterfacedObject, IAppPDVObj)
  private

    function GetFiscal: Boolean;
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
