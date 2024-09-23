unit Sis.Types.strings.Crypt_u;

interface

procedure Encriptar(pCryVer: integer; pStrDesencriptada: string; out pStrEncriptada: string);
procedure Desencriptar(pCryVer: integer; pStrEncriptada: string; out pStrDesencriptada: string);

implementation

uses Sis.Types.strings.Crypt1_u;

// Encripta uma string usando os primos como fatores
procedure Encriptar(pCryVer: integer; pStrDesencriptada: string; out pStrEncriptada: string);
begin
  case pCryVer of
    1: Encriptar1(pStrDesencriptada, pStrEncriptada);
  end;
end;

procedure Desencriptar(pCryVer: integer; pStrEncriptada: string; out pStrDesencriptada: string);
begin
  case pCryVer of
    1: Desencriptar1(pStrEncriptada, pStrDesencriptada);
  end;
end;

end.
