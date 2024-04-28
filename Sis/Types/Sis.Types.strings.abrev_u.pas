unit Sis.Types.strings.abrev_u;

interface

uses
  System.SysUtils,
  System.StrUtils;

type
  TStringAbrev = class
  public
    class function UltimoChar(const AString: string): string;
    class function ConcatenarStrings(const Strings: TArray<string>): string;
    class function ComprimentoConcatenacao(const Strings: TArray<string>): Integer;
    class function IndiceStringMaisLonga(const Strings: TArray<string>): Integer;
    class procedure ProcessarStrings(var Strings: TArray<string>; pMaxLength: Integer);
    class procedure Abrev(var pStr: string; pMaxLength: Integer);
  end;

implementation

{ TStringAbrev }

class procedure TStringAbrev.Abrev(var pStr: string; pMaxLength: Integer);
var
  Strings: TArray<string>;
begin
  Strings := pStr.Split([' ']);
  ProcessarStrings(Strings, pMaxLength);
  pStr := ConcatenarStrings(Strings);
end;

class function TStringAbrev.ComprimentoConcatenacao(
  const Strings: TArray<string>): Integer;
begin
  Result := Length(ConcatenarStrings(Strings));
end;

class function TStringAbrev.ConcatenarStrings(
  const Strings: TArray<string>): string;
var
  I: Integer;
  s: string;
begin
  Result := '';
  for I := 0 to High(Strings) do
  begin
    s := Trim(Strings[I]);
    if UltimoChar(Result) <> ' ' then
      Result := Result + ' '; // Adiciona um espaço em branco entre as strings
    Result := Result + Strings[I];
  end;
end;

class function TStringAbrev.IndiceStringMaisLonga(
  const Strings: TArray<string>): Integer;
var
  I, IndiceMaisLonga: Integer;
  TamanhoMaisLonga: Integer;
begin
  IndiceMaisLonga := -1;
  TamanhoMaisLonga := 0;

  for I := 0 to High(Strings) do
  begin
    if Length(Strings[I]) > TamanhoMaisLonga then
    begin
      TamanhoMaisLonga := Length(Strings[I]);
      IndiceMaisLonga := I;
    end;
  end;

  Result := IndiceMaisLonga;
end;

class procedure TStringAbrev.ProcessarStrings(var Strings: TArray<string>;
  pMaxLength: Integer);
var
  IndiceMaisLonga: Integer;
  S: string;
  L: integer;
begin
  while ComprimentoConcatenacao(Strings) > pMaxLength do
  begin
    IndiceMaisLonga := IndiceStringMaisLonga(Strings);
    if IndiceMaisLonga >= 0 then
    begin
      S := Strings[IndiceMaisLonga];
      L := Length(S);
      Delete(S, L, 1);
    end;
  end;
end;

class function TStringAbrev.UltimoChar(const AString: string): string;
var
  L: integer;
begin
  L := Length(AString);
  if L = 0 then
  begin
    Result := '';
    exit;
  end;

  Result := AString[L];
end;

end.
