unit Sis.Types.Floats;

interface

uses System.Math;

function StrToCurrency(S: string): Currency;
function StrToNum(S: string): double;
function StrToNumStr(S: string): string;
function FloatToStrPonto(pF: double): string;
function CurrencyToStrPonto(pF: currency): string;
function DinhToStr(pValor: currency): string;
function StrToNumStrPonto(S: string): string;
function TruncTo(const AValue: currency; const ADigit: TRoundToRange = -2)
  : currency;
function DinheiroStr(v: currency; pTrunc: boolean = false): string;

function VarToCurrency(pValue: variant): currency;
function CurrencyToVar(pValue: currency): variant;

function ValorPorExtenso(vlr: Currency): string;

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

function CurrencyToStrPonto(pF: currency): string;
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

function DinhToStr(pValor: currency): string;
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

function TruncTo(const AValue: currency; const ADigit: TRoundToRange = -2)
  : currency;
var
  LFactor: integer;
begin
  LFactor := Round(IntPower(10, -ADigit));

  result := Trunc(AValue * LFactor) / LFactor;
end;

function DinheiroStr(v: currency; pTrunc: boolean = false): string;
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

function VarToCurrency(pValue: variant): currency;
var
  sValue: string;
begin
  sValue := VarToStr(pValue);
  result := StrToCurrency(sValue);
end;

function CurrencyToVar(pValue: currency): variant;
var
  sValue: string;
begin
  sValue := CurrencyToStrPonto(pValue);
  result := sValue;
end;

function ValorPorExtenso(vlr: Currency): string;
const
  unidade: array[1..19] of string = ('um', 'dois', 'três', 'quatro', 'cinco',
             'seis', 'sete', 'oito', 'nove', 'dez', 'onze',
             'doze', 'treze', 'quatorze', 'quinze', 'dezesseis',
             'dezessete', 'dezoito', 'dezenove');
  centena: array[1..9] of string = ('cento', 'duzentos', 'trezentos',
             'quatrocentos', 'quinhentos', 'seiscentos',
             'setecentos', 'oitocentos', 'novecentos');
  dezena: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta',
             'sessenta', 'setenta', 'oitenta', 'noventa');
  qualificaS: array[0..4] of string = ('', 'mil', 'milhão', 'bilhão', 'trilhão');
  qualificaP: array[0..4] of string = ('', 'mil', 'milhões', 'bilhões', 'trilhões');
var
                        inteiro: Int64;
                          resto: Currency;
  vlrS, s, saux, vlrP, Centavos: string;
     n, unid, dez, cent, tam, i: integer;
                    umReal, tem: boolean;
begin
  if (vlr = 0)
     then begin
            ValorPorExtenso := 'zero';
            exit;
          end;

  inteiro := trunc(vlr); // parte inteira do Valor
  resto := vlr - inteiro; // parte fracionária do Valor
  vlrS := inttostr(inteiro);
  if (length(vlrS) > 15)
     then begin
            ValorPorExtenso := 'Erro: Valor superior a 999 trilhões.';
            exit;
          end;

  s := '';
  Centavos := inttostr(round(resto * 100));

// definindo o extenso da parte inteira do Valor
  i := 0;
  umReal := false; tem := false;
  while (vlrS <> '0') do
  begin
    tam := length(vlrS);
// retira do Valor a 1a. parte, 2a. parte, por exemplo, para 123456789:
// 1a. parte = 789 (centena)
// 2a. parte = 456 (mil)
// 3a. parte = 123 (milhões)
    if (tam > 3)
       then begin
              vlrP := copy(vlrS, tam-2, tam);
              vlrS := copy(vlrS, 1, tam-3);
            end
    else begin // última parte do Valor
           vlrP := vlrS;
           vlrS := '0';
         end;
    if (vlrP <> '000')
       then begin
              saux := '';
              if (vlrP = '100')
                 then saux := 'cem'
              else begin
                     n := strtoint(vlrP);        // para n = 371, tem-se:
                     cent := n div 100;          // cent = 3 (centena trezentos)
                     dez := (n mod 100) div 10;  // dez  = 7 (dezena setenta)
                     unid := (n mod 100) mod 10; // unid = 1 (unidade um)
                     if (cent <> 0)
                        then saux := centena[cent];
                     if ((dez <> 0) or (unid <> 0))
                        then begin
                               if ((n mod 100) <= 19)
                                  then begin
                                         if (length(saux) <> 0)
                                            then saux := saux + ' e ' + unidade[n mod 100]
                                         else saux := unidade[n mod 100];
                                       end
                               else begin
                                      if (length(saux) <> 0)
                                         then saux := saux + ' e ' + dezena[dez]
                                      else saux := dezena[dez];
                                      if (unid <> 0)
                                         then if (length(saux) <> 0)
                                                 then saux := saux + ' e ' + unidade[unid]
                                              else saux := unidade[unid];
                                    end;
                             end;
                   end;
              if ((vlrP = '1') or (vlrP = '001'))
                 then begin
                        if (i = 0) // 1a. parte do Valor (um Real)
                           then umReal := true
                        else saux := saux + ' ' + qualificaS[i];
                      end
              else if (i <> 0)
                      then saux := saux + ' ' + qualificaP[i];
              if (length(s) <> 0)
                 then s := saux + ', ' + s
              else s := saux;
            end;
    if (((i = 0) or (i = 1)) and (length(s) <> 0))
       then tem := true; // tem centena ou mil no Valor
    i := i + 1; // próximo qualificador: 1- mil, 2- milhão, 3- bilhão, ...
  end;

  if (length(s) <> 0)
     then begin
            if (umReal)
               then s := s + ' Real'
            else if (tem)
                    then s := s + ' Reais'
                 else s := s + ' de Reais';
          end;
// definindo o extenso dos Centavos do Valor
  if (Centavos <> '0') // Valor com Centavos
     then begin
            if (length(s) <> 0) // se não é Valor somente com Centavos
               then s := s + ' e ';
            if (Centavos = '1')
               then s := s + 'um Centavo'
            else begin
                   n := strtoint(Centavos);
                   if (n <= 19)
                      then s := s + unidade[n]
                   else begin                 // para n = 37, tem-se:
                          unid := n mod 10;   // unid = 37 % 10 = 7 (unidade sete)
                          dez := n div 10;    // dez  = 37 / 10 = 3 (dezena trinta)
                          s := s + dezena[dez];
                          if (unid <> 0)
                             then s := s + ' e ' + unidade[unid];
                       end;
                   s := s + ' Centavos';
                 end;
          end;
  ValorPorExtenso := s;
end;


end.
