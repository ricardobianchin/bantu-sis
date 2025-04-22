unit Sis.Types.Floats;

interface

uses System.Math;

function StrToCurrency(S: string): Currency;
function StrToNum(S: string): double;
function StrToNumStr(S: string): string;
function FloatToStrPonto(pF: double): string;
function CurrencyToStrPonto(pF: Currency): string;
function DinhToStr(pValor: Currency): string;
function StrToNumStrPonto(S: string): string;
function IsValidFloatString(const pNumStr: string): Boolean;
function TruncTo(const AValue: Currency; const ADigit: TRoundToRange = -2)
  : Currency;
function DinheiroStr(v: Currency; pTrunc: boolean = false): string;

function VarToCurrency(pValue: variant): Currency;
function CurrencyToVar(pValue: Currency): variant;

function ValorPorExtenso(vlr: Currency): string;

function CurrencyEhInteiro(pCurr: Currency): boolean;

implementation

uses
  System.SysUtils, Sis.Types.strings_u, System.StrUtils, System.Variants;

function StrToCurrency(S: string): Currency;
var
  ss: string;
  v: Currency;
begin
  if S = '' then
    S := '0';
  ss := StrToNumStr(S);
  v := strtoCurr(ss);
  result := v;
end;

function StrToNum(S: string): double;
begin
  if S = '' then
    S := '0';
  result := strtofloat(StrToNumStr(S));
end;

function StrToNumStr(S: string): string;
var
  npontos, t: integer;
  c: string;

begin
  if TemChar(S, ',') then
    DeleteChar(S, '.');

  npontos := 0;
  result := '';
  for t := 1 to Length(S) do
  begin
    c := S[t];
    if c = '.' then
      c := ',';
    if c = ',' then
    begin
      if npontos = 0 then
        result := result + c;
      inc(npontos);
    end
    else
    begin
      if pos(c, '0123456789-') <> 0 then
        result := result + c;
    end;
  end;

  SemCharAEsquerda(result, '0');

  if result = '' then
    result := '0';

  if result[1] = ',' then
    result := '0' + result;

  if result[Length(result)] = ',' then
    result := result + '0';
end;

function CurrencyToStrPonto(pF: Currency): string;
var
  sResultado, r: string;
begin
  r := CurrToStr(pF);
  sResultado := StringReplace(r, ',', '.', [rfReplaceAll]);
  result := sResultado;
end;

function FloatToStrPonto(pF: double): string;
var
  sResultado, r: string;
begin
  r := FloatToStr(pF);
  sResultado := StringReplace(r, ',', '.', [rfReplaceAll]);
  result := sResultado;
end;

function DinhToStr(pValor: Currency): string;
begin
  result := FormatFloat('###,###,##0.00', pValor);
end;

function StrToNumStrPonto(S: string): string;
var
  npontos, t: integer;
  c: string;
begin
  npontos := 0;
  result := '';
  for t := 1 to Length(S) do
  begin
    c := S[t];
    if c = ',' then
      c := '.';
    if c = '.' then
    begin
      if npontos = 0 then
        result := result + c;
      inc(npontos);
    end
    else
    begin
      if pos(c, '0123456789-') <> 0 then
        result := result + c;
    end;
  end;

  if result = '' then
    result := '0';

  if result[1] = '.' then
    result := '0' + result;

  if result[Length(result)] = '.' then
    result := result + '0';
end;

function TruncTo(const AValue: Currency; const ADigit: TRoundToRange = -2)
  : Currency;
var
  Factor: integer;
begin
  Factor := Round(IntPower(10, -ADigit));

  result := Trunc(AValue * Factor) / Factor;
end;

function DinheiroStr(v: Currency; pTrunc: boolean = false): string;
begin
  if pTrunc then
  begin
    result := FormatFloat('###,###,##0.00000000000', v);
    StrDeleteNoFim(result, 9);
  end
  else
  begin
    result := FormatFloat('###,###,##0.00', v);
  end;
end;

function VarToCurrency(pValue: variant): Currency;
var
  sValue: string;
begin
  sValue := VarToStr(pValue);
  result := StrToCurrency(sValue);
end;

function CurrencyToVar(pValue: Currency): variant;
var
  sValue: string;
begin
  sValue := CurrencyToStrPonto(pValue);
  result := sValue;
end;

function ValorPorExtenso(vlr: Currency): string;
const
  unidade: array [1 .. 19] of string = ('Um', 'Dois', 'Três', 'Quatro', 'Cinco',
    'Seis', 'Sete', 'Oito', 'Nove', 'Dez', 'Onze', 'Doze', 'Treze', 'Quatorze',
    'Quinze', 'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');
  centena: array [1 .. 9] of string = ('Cento', 'Duzentos', 'Trezentos',
    'Quatrocentos', 'Quinhentos', 'Seiscentos', 'Setecentos', 'Oitocentos',
    'Novecentos');
  dezena: array [2 .. 9] of string = ('Vinte', 'Trinta', 'Quarenta',
    'Cinquenta', 'Sessenta', 'Setenta', 'Oitenta', 'Noventa');
  qualificaS: array [0 .. 4] of string = ('', 'Mil', 'Milhão', 'Bilhão',
    'Trilhão');
  qualificaP: array [0 .. 4] of string = ('', 'Mil', 'Milhões', 'Bilhões',
    'Trilhões');
var
  inteiro: Int64;
  resto: Currency;
  vlrS, S, saux, vlrP, Centavos: string;
  n, unid, dez, cent, tam, i: integer;
  umReal, tem: boolean;
begin
  if (vlr = 0) then
  begin
    ValorPorExtenso := 'zero';
    exit;
  end;

  inteiro := Trunc(vlr); // parte inteira do Valor
  resto := vlr - inteiro; // parte fracionária do Valor
  vlrS := inttostr(inteiro);
  if (Length(vlrS) > 15) then
  begin
    ValorPorExtenso := 'Erro: Valor superior a 999 trilhões.';
    exit;
  end;

  S := '';
  Centavos := inttostr(Round(resto * 100));

  // definindo o extenso da parte inteira do Valor
  i := 0;
  umReal := false;
  tem := false;
  while (vlrS <> '0') do
  begin
    tam := Length(vlrS);
    // retira do Valor a 1a. parte, 2a. parte, por exemplo, para 123456789:
    // 1a. parte = 789 (centena)
    // 2a. parte = 456 (mil)
    // 3a. parte = 123 (milhões)
    if (tam > 3) then
    begin
      vlrP := copy(vlrS, tam - 2, tam);
      vlrS := copy(vlrS, 1, tam - 3);
    end
    else
    begin // última parte do Valor
      vlrP := vlrS;
      vlrS := '0';
    end;
    if (vlrP <> '000') then
    begin
      saux := '';
      if (vlrP = '100') then
        saux := 'Cem'
      else
      begin
        n := strtoint(vlrP); // para n = 371, tem-se:
        cent := n div 100; // cent = 3 (centena trezentos)
        dez := (n mod 100) div 10; // dez  = 7 (dezena setenta)
        unid := (n mod 100) mod 10; // unid = 1 (unidade um)
        if (cent <> 0) then
          saux := centena[cent];
        if ((dez <> 0) or (unid <> 0)) then
        begin
          if ((n mod 100) <= 19) then
          begin
            if (Length(saux) <> 0) then
              saux := saux + ' e ' + unidade[n mod 100]
            else
              saux := unidade[n mod 100];
          end
          else
          begin
            if (Length(saux) <> 0) then
              saux := saux + ' e ' + dezena[dez]
            else
              saux := dezena[dez];
            if (unid <> 0) then
              if (Length(saux) <> 0) then
                saux := saux + ' e ' + unidade[unid]
              else
                saux := unidade[unid];
          end;
        end;
      end;
      if ((vlrP = '1') or (vlrP = '001')) then
      begin
        if (i = 0) // 1a. parte do Valor (um Real)
        then
          umReal := true
        else
          saux := saux + ' ' + qualificaS[i];
      end
      else if (i <> 0) then
        saux := saux + ' ' + qualificaP[i];
      if (Length(S) <> 0) then
        S := saux + ', ' + S
      else
        S := saux;
    end;
    if (((i = 0) or (i = 1)) and (Length(S) <> 0)) then
      tem := true; // tem centena ou mil no Valor
    i := i + 1; // próximo qualificador: 1- mil, 2- milhão, 3- bilhão, ...
  end;

  if (Length(S) <> 0) then
  begin
    if (umReal) then
      S := S + ' Real'
    else if (tem) then
      S := S + ' Reais'
    else
      S := S + ' de Reais';
  end;
  // definindo o extenso dos Centavos do Valor
  if (Centavos <> '0') // Valor com Centavos
  then
  begin
    if (Length(S) <> 0) // se não é Valor somente com Centavos
    then
      S := S + ' e ';
    if (Centavos = '1') then
      S := S + 'Um Centavo'
    else
    begin
      n := strtoint(Centavos);
      if (n <= 19) then
        S := S + unidade[n]
      else
      begin // para n = 37, tem-se:
        unid := n mod 10; // unid = 37 % 10 = 7 (unidade sete)
        dez := n div 10; // dez  = 37 / 10 = 3 (dezena trinta)
        S := S + dezena[dez];
        if (unid <> 0) then
          S := S + ' e ' + unidade[unid];
      end;
      S := S + ' Centavos';
    end;
  end;
  ValorPorExtenso := S;
end;

function CurrencyEhInteiro(pCurr: Currency): boolean;
begin
  Result := Frac(pCurr) = 0;
end;

function IsValidFloatString(const pNumStr: string): Boolean;
var
  NormalizedStr: string;
  I, DotCount: Integer;
begin
  // Substituir ',' por '.'
  NormalizedStr := StringReplace(pNumStr, ',', '.', [rfReplaceAll]);

  // Verificar se só contém dígitos e no máximo um ponto decimal
  DotCount := 0;
  for I := 1 to Length(NormalizedStr) do
  begin
    if not (NormalizedStr[I] in ['0'..'9', '.']) then
      Exit(False);

    if NormalizedStr[I] = '.' then
      Inc(DotCount);

    if DotCount > 1 then
      Exit(False);
  end;

  Result := True;
end;

end.
