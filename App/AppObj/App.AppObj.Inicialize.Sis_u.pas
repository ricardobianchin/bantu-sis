unit App.AppObj.Inicialize.Sis_u;

interface

procedure InicializeSis;

implementation

uses Sis.SisObject_u, Sis.Factory;

procedure InicializeSis;
begin
  Sis.SisObject_u.Sis := Sis.Factory.SisObjCreate(SisBoolCreate);
end;

end.
