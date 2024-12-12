unit DB_u;

interface

function IdentStr(pNome: string; pIP: string): string;

implementation

uses Sis.Types.Bool_u;

function IdentStr(pNome: string; pIP: string): string;
begin
  Result := Iif(pNome = '', pIP, pNome);
end;

end.
