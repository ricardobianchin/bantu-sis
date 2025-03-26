unit Sis.Web.HTTP.Net.Utils_u;

interface

uses System.Net.URLClient;

function NETGetValueByName(pName: string; pNetHeaders: TNetHeaders): string;

implementation

function NETGetValueByName(pName: string; pNetHeaders: TNetHeaders): string;
var
  Header: TNameValuePair;
  LastModifiedValue: string;
begin
  for Header in pNetHeaders do
  begin
    if Header.Name = pName then
    begin
      LastModifiedValue := Header.Value;
      Result := LastModifiedValue;
      Break;
    end;
  end;
end;

end.
