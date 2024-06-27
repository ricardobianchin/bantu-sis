unit Sis.Types.Dates;

interface

function GetValidDate(pDate: TDateTIme): TDateTIme;

implementation

uses Sis.Types.Bool_u, System.SysUtils;

function GetValidDate(pDate: TDateTIme): TDateTIme;
begin
  Result := Iif(pDate = 0, Date, pDate);
end;

end.
