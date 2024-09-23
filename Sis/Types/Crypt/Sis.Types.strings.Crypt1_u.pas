unit Sis.Types.strings.Crypt1_u;

interface

procedure Encriptar1(pStrDesencriptada: string; out pStrEncriptada: string);
procedure Desencriptar1(pStrEncriptada: string; out pStrDesencriptada: string);

implementation

uses System.SysUtils;

const
  Primos: array[0..6] of Byte = (223, 227, 229, 233, 239, 241, 251);

function HexToWord(const Hex: string): Word; inline;
begin
  Result := StrToInt('$' + Hex);
end;

function WordToHex(Value: Word): string; inline;
begin
  Result := IntToHex(Value, 4);
end;

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

    pStrEncriptada := pStrEncriptada + WordToHex(w);
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

  iQtdCharsFinal := Length(pStrEncriptada) div 4;
  for i := 1 to iQtdCharsFinal do
  begin
    sHex := Copy(pStrEncriptada, (i - 1) * 4 + 1, 4);

    wOriginal := HexToWord(sHex);

    for j := Low(Primos) to High(Primos) do
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

end.
