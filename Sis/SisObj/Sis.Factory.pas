unit Sis.Factory;

interface

uses Sis.Types.Bool, Sis.SisObj;

function SisBoolCreate: ISisBool;
function SisObjCreate(pSisBool: ISisBool): ISisObj;

implementation

uses Sis.SisObj_u, Sis.Types.Bool_u;

function SisBoolCreate: ISisBool;
begin
  Result  := TSisBool.Create;
end;

function SisObjCreate(pSisBool: ISisBool): ISisObj;
begin
  Result := TSisObj.Create(pSisBool);
end;


end.
