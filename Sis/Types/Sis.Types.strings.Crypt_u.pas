unit Sis.Types.strings.Crypt_u;

interface

procedure Encriptar(pCryVer: integer; pStr: string; out pEncriptado: string);
procedure Desencriptar(pCryVer: integer; pEncriptado: string; out pStr: string);

implementation

uses System.SysUtils;

const
  Primos: array[0..6] of Byte = (223, 227, 229, 233, 239, 241, 251);

// Encripta uma string usando os primos como fatores
procedure Encriptar1(pStrDesencriptada: string; out pStrEncriptada: string);
var
  i, j: Integer;
  c: Char;
  w: Word;
begin
  // Se pStr for nula, finaliza retornando pEncriptado como uma string nula
  if pStrDesencriptada = '' then
  begin
    pStrEncriptada := '';
    Exit;
  end;

  pStrEncriptada := '';

  for i := 1 to Length(pStrDesencriptada) do
  begin
    c := pStrDesencriptada[i];

    j := Random(Length(Primos));

    w := Ord(c) * Primos[j];

    pStrEncriptada := pStrEncriptada + IntToHex(w, 4);
  end;
end;

procedure Encriptar(pCryVer: integer; pStr: string; out pEncriptado: string);
begin
  case pCryVer of
    1: Encriptar1(pStr, pEncriptado);
  end;
end;

// Desencripta uma string encriptada usando os primos como divisores
procedure Desencriptar1(pStrEncriptada: string; out pStrDesencriptada: string);
var
  i, j: Integer;
  sHex: string;
  wOriginal: Word;
  iResto: byte;
  iAscii: byte;
  c: Char;
  iQtdPrimos: integer;
  iQtdCharsFinal: integer;
  iPrimoUsado: byte;
begin
  if pStrEncriptada = '' then
  begin
    pStrDesencriptada := '';
    Exit;
  end;

  if Length(pStrEncriptada) mod 4 <> 0 then
    raise Exception.Create('String encriptada inválida');

  pStrDesencriptada := '';
  iQtdPrimos := Length(Primos);

  iQtdCharsFinal := Length(pStrEncriptada) div 4;
  for i := 1 to iQtdCharsFinal do
  begin
    sHex := Copy(pStrEncriptada, (i - 1) * 4 + 1, 4);

    // Converte a substring para um número inteiro (word)
    wOriginal := StrToInt('$' + sHex);

    for j := 0 to iQtdPrimos - 1 do
    begin
      iPrimoUsado := Primos[j];
      iResto := wOriginal mod iPrimoUsado;
      if iResto = 0 then
        break;
    end;

    iAscii := wOriginal div iPrimoUsado;

    c := Chr(iAscii);
    pStrDesencriptada := pStrDesencriptada + c;
  end;
end;

procedure Desencriptar(pCryVer: integer; pEncriptado: string; out pStr: string);
begin
  case pCryVer of
    1: Desencriptar1(pEncriptado, pStr);
  end;
end;

end.
