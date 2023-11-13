unit Sis.SisObj_u;

interface

uses Sis.SisObj, Sis.Types.Bool;

type
  TSisObj = class(TInterfacedObject, ISisObj)
  private
    FBool: ISisBool;

    function GetBool: ISisBool;
  public
    property Bool: ISisBool read GetBool;
    constructor Create(pBool: ISisBool);
  end;

implementation

{ TSisObj }

constructor TSisObj.Create(pBool: ISisBool);
begin
  FBool := pBool;
end;

function TSisObj.GetBool: ISisBool;
begin
  Result := FBool;
end;

end.
