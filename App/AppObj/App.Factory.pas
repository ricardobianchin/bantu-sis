unit App.Factory;

interface

uses App.AppObj;

function AppObjCreate: IAppObj;

implementation

uses App.AppObj_u;

function AppObjCreate: IAppObj;
begin
  Result := TAppObj.Create;
end;

end.
