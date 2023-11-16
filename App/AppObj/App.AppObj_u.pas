unit App.AppObj_u;

interface

uses App.AppObj;

type
  TAppObj = class(TInterfacedObject, IAppObj)
  private
  public
    procedure Inicialize;
  end;

implementation

{ TAppObj }

procedure TAppObj.Inicialize;
begin
end;

end.
