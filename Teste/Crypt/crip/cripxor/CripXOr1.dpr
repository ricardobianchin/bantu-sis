program CripXOr1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
  xkey=$FF;
  mkey=$FF;

// This method will receive a string and populate a private dynamic array of the type word.
// It must apply xor and multiply the char value to a 8bit key. The result will be a 16 bits value that must be added to the array.
// The method must set the pstr with hexadecimal values of the array
// The method must free resources at the end
procedure Encripte(var pStr: string);
var
  i: Integer;
  c, x: Word;
  arr: array of Word;
begin
  // Allocate the array with the same length as the string
  SetLength(arr, Length(pStr));

  // Loop through each character of the string
  for i := 1 to Length(pStr) do
  begin
    // Get the ordinal value of the character
    c := Ord(pStr[i]);

    // Apply xor and multiply by the key
    x := (c xor xkey) * mkey;

    // Add the result to the array
    arr[i-1] := x;
  end;

  // Convert the array to a hexadecimal string
  pStr := '';
  for i := Low(arr) to High(arr) do
  begin
    pStr := pStr + IntToHex(arr[i], 4);
  end;

  // Free the array
  Finalize(arr);
end;

// This method will do the opposite. It will receive the hexadecimal values.
// It will populate the array of words, revert the calculus did by the first method and populate the pstr with the original text
procedure Desencripte(var pStr: string);
var
  i: Integer;
  c, x: Word;
  arr: array of Word;
begin
  // Check if the string length is divisible by 4
  if Length(pStr) mod 4 <> 0 then
    raise Exception.Create('Invalid input');

  // Allocate the array with a quarter of the string length
  SetLength(arr, Length(pStr) div 4);

  // Loop through each group of four hexadecimal digits in the string
  for i := Low(arr) to High(arr) do
  begin
    // Convert the hexadecimal digits to a word value
    x := StrToInt('$' + Copy(pStr, i*4 + 1, 4));

    // Revert the calculus did by Encripte
    c := (x div mkey) xor xkey;

    // Add the result to the array
    arr[i] := c;
  end;

  // Convert the array to a string
  pStr := '';
  for i := Low(arr) to High(arr) do
  begin
    pStr := pStr + Chr(arr[i]);
  end;

  // Free the array
  Finalize(arr);
end;
var
  s: string;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    s := 'ABCDEF';
    WriteLn(s);
    Encripte(s);
    WriteLn(s);
    Desencripte(s);
    WriteLn(s);
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
