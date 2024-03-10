unit Sis.Types.Codigos.Testes_u;

interface

function IsValidCPF(const CPF: string): Boolean;
function IsValidCNPJ(const CNPJ: string): Boolean;
function IsValidEAN8(const EAN8: string): Boolean;
function IsValidEAN13(const EAN13: string): Boolean;
function IsValidEAN14(const EAN14: string): Boolean;
function IsValidUPCA(const UPCA: string): Boolean;

implementation

uses
  System.SysUtils, System.StrUtils;

function IsNumeric(const S: string): Boolean;
var
  P: PChar;
begin
  P := PChar(S);
  Result := False;

  while P^ <> #0 do
  begin
    if not (P^ in ['0'..'9']) then Exit;
    Inc(P);
  end;

  Result := True;
end;

function IsValidCPF(const CPF: string): Boolean;
//var
//  I, Total, Digit: Integer;
//  CPFNumbers: string;
begin
  Result := False;
//  CPFNumbers := StringReplace(CPF, '.', '', [rfReplaceAll]);
//  CPFNumbers := StringReplace(CPFNumbers, '-', '', [rfReplaceAll]);
//
//  if not IsNumeric(CPFNumbers) or (Length(CPFNumbers) <> 11) then Exit;
//
//  for I := 1 to 9 do
//  begin
//    Total := 0;
//
//    for I := 1 to 9 do
//      Total := Total + (StrToInt(CPFNumbers[I]) * (11 - I));
//
//    Digit := 11 - (Total mod 11);
//
//    if Digit > 9 then
//      Digit := 0;
//
//    if StrToInt(CPFNumbers[10]) <> Digit then Exit;
//  end;
//
//  Total := 0;
//
//  for I := 1 to 10 do
//    Total := Total + (StrToInt(CPFNumbers[I]) * (12 - I));
//
//  Digit := 11 - (Total mod 11);
//
//  if Digit > 9 then
//    Digit := 0;
//
//  if StrToInt(CPFNumbers[11]) <> Digit then Exit;
//
//  Result := True;
end;

function IsValidCNPJ(const CNPJ: string): Boolean;
//var
//  I, Total, Digit: Integer;
//  CNPJNumbers: string;
begin
//  Result := False;
//
//  CNPJNumbers := StringReplace(CNPJ, '.', '', [rfReplaceAll]);
//  CNPJNumbers := StringReplace(CNPJNumbers, '-', '', [rfReplaceAll]);
//  CNPJNumbers := StringReplace(CNPJNumbers, '/', '', [rfReplaceAll]);
//
//  if not IsNumeric(CNPJNumbers) or (Length(CNPJNumbers) <> 14) then Exit;
//
//  for I := 1 to 12 do
//  begin
//    Total := 0;
//
//    for I := 1 to 12 do
//      Total := Total + (StrToInt(CNPJNumbers[I]) * (13 - I));
//
//    Digit := 11 - (Total mod 11);
//
//    if Digit > 9 then
//      Digit := 0;
//
//    if StrToInt(CNPJNumbers[13]) <> Digit then Exit;
//  end;
//
//  Total := 0;
//
//  for I := 1 to 13 do
//    Total := Total + (StrToInt(CNPJNumbers[I]) * (14 - I));
//
//  Digit := 11 - (Total mod 11);
//
//  if Digit > 9 then
//    Digit := 0;
//
//  if StrToInt(CNPJNumbers[14]) <> Digit then Exit;
//
//  Result := True;
end;

function IsValidEAN8(const EAN8: string): Boolean;
var
  I, Total, CheckDigit: Integer;
begin
  Result := False;

  if not IsNumeric(EAN8) or (Length(EAN8) <> 8) then Exit;

  Total := 0;

  for I := 1 to 7 do
  begin
    if I mod 2 = 0 then
      Total := Total + StrToInt(EAN8[I]) * 3
    else
      Total := Total + StrToInt(EAN8[I]);
  end;

  CheckDigit := 10 - (Total mod 10);

  if CheckDigit = 10 then
    CheckDigit := 0;

  Result := StrToInt(EAN8[8]) = CheckDigit;
end;

function IsValidEAN13(const EAN13: string): Boolean;
var
  I, Total, CheckDigit: Integer;
begin
  Result := False;

  if not IsNumeric(EAN13) or (Length(EAN13) <> 13) then Exit;

  Total := 0;

  for I := 1 to 12 do
  begin
    if I mod 2 = 0 then
      Total := Total + StrToInt(EAN13[I]) * 3
    else
      Total := Total + StrToInt(EAN13[I]);
  end;

  CheckDigit := 10 - (Total mod 10);

  if CheckDigit = 10 then
    CheckDigit := 0;

  Result := StrToInt(EAN13[13]) = CheckDigit;
end;

function IsValidEAN14(const EAN14: string): Boolean;
var
  I, Total, CheckDigit: Integer;
begin
  Result := False;

  if not IsNumeric(EAN14) or (Length(EAN14) <> 14) then Exit;

  Total := 0;

  for I := 1 to 13 do
  begin
    if I mod 2 = 0 then
      Total := Total + StrToInt(EAN14[I]) * 3
    else
      Total := Total + StrToInt(EAN14[I]);
  end;

  CheckDigit := 10 - (Total mod 10);

  if CheckDigit = 10 then
    CheckDigit := 0;

  Result := StrToInt(EAN14[14]) = CheckDigit;
end;

function IsValidUPCA(const UPCA: string): Boolean;
var
  I, Total, CheckDigit: Integer;
begin
  Result := False;

  if not IsNumeric(UPCA) or (Length(UPCA) <> 12) then Exit;

  Total := 0;

  for I := 1 to 11 do
  begin
    if I mod 2 = 0 then
      Total := Total + StrToInt(UPCA[I]) * 3
    else
      Total := Total + StrToInt(UPCA[I]);
  end;

  CheckDigit := 10 - (Total mod 10);

  if CheckDigit = 10 then
    CheckDigit := 0;

  Result := StrToInt(UPCA[12]) = CheckDigit;
end;

end.
