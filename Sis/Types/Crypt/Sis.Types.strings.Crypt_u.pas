unit Sis.Types.strings.Crypt_u;

interface

procedure Encriptar(pCryVer: integer; pStr: string; out pEncriptado: string);
procedure Desencriptar(pCryVer: integer; pEncriptado: string; out pStr: string);

implementation

uses Sis.Types.strings.Crypt1_u;

// Encripta uma string usando os primos como fatores
procedure Encriptar(pCryVer: integer; pStr: string; out pEncriptado: string);
begin
  case pCryVer of
    1: Encriptar1(pStr, pEncriptado);
  end;
end;

procedure Desencriptar(pCryVer: integer; pEncriptado: string; out pStr: string);
begin
  case pCryVer of
    1: Desencriptar1(pEncriptado, pStr);
  end;
end;

end.
