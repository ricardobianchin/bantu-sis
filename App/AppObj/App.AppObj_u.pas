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

uses App.AppObj.Inicialize.Sis_u;

{ TAppObj }

procedure TAppObj.Inicialize;
begin
  App.AppObj.Inicialize.Sis_u.InicializeSis;
end;

end.
