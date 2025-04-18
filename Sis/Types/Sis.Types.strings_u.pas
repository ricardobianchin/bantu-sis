unit Sis.Types.strings_u;

interface

uses System.UITypes, System.Hash, System.SysUtils;

procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean = True);
function StrSemAcento(const pStr: string;
  pTudoMaiusculas: boolean = True): string;

function AddSpacesBetweenChars(pStr: string): string;

function CharIsUpper(pC: Char): boolean;
function CharIsLower(pC: Char): boolean;

function StrSemStr(pStr: string; pStrARemover: string = #32): string;
function StrSemCharRepetido(pStr: string; pChar: Char = #32): string;

function CharIsOnlyDigit(Key: Char): boolean;
function StrToOnlyDigit(const pStr: string): string;
function StrIsOnlyDigit(const pStr: string): boolean;

procedure CharToLow(var Key: Char);

procedure CharToName(var Key: Char);
function StrToName(const pStr: string): string;

procedure StrDeleteNoFim(var pStr: string; pQtdChars: integer);
procedure StrDeleteNoInicio(var pStr: string; pQtdChars: integer);
procedure StrDeleteTrailingChars(var pStr: string; const CharSet: TSysCharSet);

procedure StrSepareInicio(pStrOrigem: string; pQtdChars: integer;
  out pStrIni: string; out pStrFim: string);

function IsWindowsFilenameChar(c: Char): boolean;
procedure ReplaceInvalidFilenameChar(var c: Char);
function StrToNomeArq(const filename: string): string;
function IsWindowsFilenameValid(filename: string): boolean;

function RightPos(pCar: Char; pStr: string): integer;

function StrAntes(pStr, pBusca: string): string;
function StrApos(pStr, pBusca: string): string;
function StrValue(pStr: string): string;

procedure StrGarantirTermino(var pStr: string; const pTermino: string);

function IsDigit(c: Char): boolean;
procedure AjusteAsciiCodeToChar(var pStr: string);

function CapitalizeWords(pStr: string): string;

function TruncSnakeCase(pIdentifier: string;
  pMaxIdentifierLenght: integer): string;
// function ArrayToSnakeCase(pPalavras: TArray<string>): string;
function ArrayLargestIndex(pPalavras: TArray<string>): integer;
function SnakeCaseFutureLenght(pPalavras: TArray<string>): integer;
function StrCountCharLeft(pStr: string; pCharInicial: Char = '0'): integer;
procedure SemCharAEsquerda(var pStr: string; pCharInicial: Char = '0');
function TemChar(pStr: string; pChar: Char): boolean;
function TemChars(const Str: string; const Chars: TArray<Char>): boolean;
procedure DeleteChar(pStr: string; pCharToDel: Char);

procedure StrSemEnterNoFim(var pStr: string);

function StrCheckSum(const pStr: string;
  pSHA2Version: THashSHA2.TSHA2Version = SHA256): string;

procedure StrCheckSum32(pStr: string; out pCheckStr: string); overload;
function StrCheckSum32(pStr: string): string; overload;

function VarToString(pValue: variant): string;

function ConvertHTMLChars(pStr: string): string;

function ClassNameToNome(pClassName: string;
  pDeleteLastWord: boolean = True): string;

procedure EnsureStringFixedLength(var aStr: string; aLength: integer);
procedure EnsureStringMinimalLength(var aStr: string; aLength: integer);
procedure OverwriteString(var aTargetStr: string; const aSourceStr: string;
  pStartPos: integer);
procedure OverwriteStringRight(var aTargetStr: string; const aSourceStr: string;
  aEndPos: integer);
// procedure CenterStr(var aTarget: string; aWidth: integer; aFillChar: char = #32; aAddAtEnd: Boolean = False); overload;
function CenterStr(aTarget: string; aWidth: integer; aFillChar: Char = #32;
  aAddAtEnd: boolean = False): string; overload;

// function WrapTexto(pStr: string; pMaxCol: integer = 45): boolean;

function KeyToStr(Key: Word): String;
function PosIndicada(const pStr, pSubStr: string;
  pOrdemOcorrenciaDesejada: integer): integer;

implementation

uses System.StrUtils, System.Variants, System.Classes;

const
  Imprimiveis =
    ('0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    '��������������������������');
  SubstSemAcento =
    ('0123456789_ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    'AaAaAaAaEeEeEeIiOoOoOoUuCc');

  VALID_FILENAME_CHARS: TSysCharSet = ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_',
    '-', '.', '!', '@', '#', '$', '%', '&', '(', ')', '[', ']', '{', '}'];

function CharIsOnlyDigit(Key: Char): boolean;
begin
  Result := CharInSet(Key, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']);
end;

function StrToOnlyDigit(const pStr: string): string;
var
  i: integer;
  c: Char;
  bResultado: boolean;
begin
  Result := '';

  for i := 1 to Length(pStr) do
  begin
    c := pStr[i];
    bResultado := CharIsOnlyDigit(c);
    if bResultado then
      Result := Result + c;
  end;
end;

function StrIsOnlyDigit(const pStr: string): boolean;
var
  L: integer;
  i: integer;
  sStr: string;
begin
  sStr := Trim(pStr);
  Result := sStr <> '';
  if not Result then
    exit;

  Result := True;

  L := Length(sStr);
  for i := 1 to L do
  begin
    if not CharIsOnlyDigit(sStr[i]) then
    begin
      Result := False;
      break;
    end;
  end;
end;

// Procedure que recebe um par�metro var Key: char e faz a substitui��o
procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean);
var
  Posic: integer;
begin
  // Localiza o conte�do do par�metro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posi��o na segunda constante
  if Posic >= 1 then
    Key := UpCase(SubstSemAcento[Posic]);
end;

function CharIsUpper(pC: Char): boolean;
begin
  Result := (pC >= 'A') and (pC <= 'Z');
end;

function CharIsLower(pC: Char): boolean;
begin
  Result := not CharIsUpper(pC);
  // Result := (pC >= 'a') and (pC <= 'z');
end;

// Procedure que recebe um par�metro var s: string e faz a substitui��o de cada caractere
function StrSemAcento(const pStr: string; pTudoMaiusculas: boolean): string;
var
  i: integer;
begin
  Result := pStr;

  for i := 1 to Length(Result) do
  begin
    CharSemAcento(Result[i], pTudoMaiusculas);
  end;
  if pTudoMaiusculas then
    Result := UpperCase(Result);
end;

function AddSpacesBetweenChars(pStr: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(pStr) do
  begin
    Result := Result + pStr[i] + ' ';
  end;
  Result := Trim(Result);
end;

procedure CharToName(var Key: Char);
var
  Posic: integer;
begin
  // Localiza o conte�do do par�metro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posi��o na segunda constante

  if Posic >= 1 then
    Key := SubstSemAcento[Posic]
  else
    Key := '_';
end;

// gere, por favor, uma procedure no delphi que receba um char por referencia e, se for letra maiuscula, converte para minuscula
procedure CharToLow(var Key: Char);
begin
  if CharInSet(Key, ['A' .. 'Z']) then
    Key := Chr(Ord(Key) + 32);
end;

function StrToName(const pStr: string): string;
var
  i: integer;
begin
  Result := StrSemAcento(pStr);
  for i := 1 to Length(Result) do
  begin
    CharToName(Result[i]);
  end;
end;

function IsWindowsFilenameChar(c: Char): boolean;
begin
  Result := CharInSet(c, VALID_FILENAME_CHARS);
end;

function IsWindowsFilenameValid(filename: string): boolean;
var
  c: Char;
begin
  Result := True;
  for c in filename do
    if not IsWindowsFilenameChar(c) then
    begin
      Result := False;
      break;
    end;
end;

procedure ReplaceInvalidFilenameChar(var c: Char);
begin
  if not IsWindowsFilenameChar(c) then
    c := '_';
end;

{
  procedure ReplaceInvalidFilenameChars(var filename: string);
  var
  i: Integer;
  begin
  for i := 1 to Length(filename) do
  ReplaceInvalidFilenameChar(filename[i]);
  end;
}

function StrToNomeArq(const filename: string): string;
var
  i: integer;
begin
  Result := filename;
  for i := 1 to Length(Result) do
    ReplaceInvalidFilenameChar(Result[i]);
end;

function RightPos(pCar: Char; pStr: string): integer;
var
  t: integer;
begin
  Result := 0;
  for t := Length(pStr) downto 1 do
  begin
    if pCar = pStr[t] then
    begin
      Result := t;
      exit;
    end;
  end;
end;

function StrAntes(pStr, pBusca: string): string;
var
  iBuscaLen, iPosNaStr: integer;
begin
  Result := pStr;

  iBuscaLen := pBusca.Length;
  if iBuscaLen = 0 then
    exit;

  iPosNaStr := Pos(pBusca, Result);

  if iPosNaStr = 0 then
    exit;

  Result := Copy(Result, 1, iPosNaStr - 1);
end;

function StrApos(pStr, pBusca: string): string;
var
  iBuscaLen, iPosNaStr: integer;
begin
  Result := pStr;

  iBuscaLen := pBusca.Length;
  if iBuscaLen = 0 then
    exit;

  iPosNaStr := Pos(pBusca, Result);

  if iPosNaStr = 0 then
    exit;

  Delete(Result, 1, iPosNaStr);
end;

function StrValue(pStr: string): string;
var
  iPos: integer;
begin
  Result := '';
  iPos := Pos('=', pStr);
  if iPos = 0 then
    exit;

  Result := RightStr(pStr, Length(pStr) - iPos);
end;

function StrSemStr(pStr: string; pStrARemover: string = #32): string;
begin
  Result := ReplaceStr(pStr, pStrARemover, '');
end;

function StrSemCharRepetido(pStr: string; pChar: Char): string;
var
  i, j: integer;
begin
  // Remover espa�os no in�cio e no fim da string
  pStr := Trim(pStr);

  // Inicializar os �ndices i e j
  i := 1;
  j := 1;
  // Percorrer a string da esquerda para a direita
  while i <= Length(pStr) do
  begin
    // Copiar o caractere na posi��o i para a posi��o j
    pStr[j] := pStr[i];
    // Se o caractere for um espa�o, avan�ar i at� encontrar um caractere diferente de espa�o
    if pStr[i] = pChar then
    begin
      while (i <= Length(pStr)) and (pStr[i] = pChar) do
        Inc(i);
    end
    // Caso contr�rio, avan�ar i normalmente
    else
      Inc(i);
    // Avan�ar j tamb�m
    Inc(j);
  end;
  // Ajustar o tamanho da string para o valor de j - 1
  SetLength(pStr, j - 1);
  // Retornar a string modificada
  Result := pStr;
end;

procedure StrGarantirTermino(var pStr: string; const pTermino: string);
var
  iLenTermino: integer;
  sFinalAtual: string;
begin
  iLenTermino := Length(pTermino);

  if iLenTermino = 0 then
    exit;

  sFinalAtual := RightStr(pStr, iLenTermino);

  if sFinalAtual = pTermino then
    exit;

  pStr := pStr + pTermino;
end;

// Fun��o que recebe um char e retorna verdadeiro se for um algarismo
function IsDigit(c: Char): boolean;
begin
  // Verifica se o c�digo ASCII do char est� entre 48 e 57, que correspondem aos algarismos de 0 a 9
  IsDigit := (Ord(c) >= 48) and (Ord(c) <= 57);
end;

// Procedure que recebe uma string cujo conte�do s�o dados separados por ; e substitui as sequ�ncias de # seguidas de 3 algarismos pelo caractere ASCII correspondente
procedure AjusteAsciiCodeToChar(var pStr: string);
var
  i, code: integer;
  c: Char;
begin
  // Percorre a string da esquerda para a direita
  i := 1;
  while i <= Length(pStr) do
  begin
    // Se encontrar o caractere #
    if pStr[i] = '#' then
    begin
      // Verifica se os pr�ximos tr�s caracteres s�o algarismos
      if (i + 3 <= Length(pStr)) and IsDigit(pStr[i + 1]) and
        IsDigit(pStr[i + 2]) and IsDigit(pStr[i + 3]) then
      begin
        // Converte os tr�s algarismos em um n�mero inteiro
        code := StrToInt(pStr[i + 1] + pStr[i + 2] + pStr[i + 3]);
        // Converte o n�mero inteiro em um caractere ASCII
        c := Chr(code);
        // Substitui a sequ�ncia de # e tr�s algarismos pelo caractere ASCII na string original
        pStr := Copy(pStr, 1, i - 1) + c + Copy(pStr, i + 4,
          Length(pStr) - i - 3);
      end;
    end;
    // Incrementa o �ndice da string
    i := i + 1;
  end;
end;

function ArrayToSnaceCase(pPalavras: TArray<string>): string;
var
  i: integer;
begin
  Result := '';

  for i := 0 to Length(pPalavras) - 1 do
  begin
    if Result <> '' then
      Result := Result + '_';
    Result := Result + pPalavras[i];
  end;
end;

function CapitalizeWords(pStr: string): string;
const
  Conectores = '/�/e/o/a/os/as/um/uma/uns/umas/de/da/do/das/dos/em/na' +
    '/no/nas/nos/por/sem/sob/';
var
  aPalavras: TArray<string>;
  i: integer;
  NewSentence: boolean;
  sPalavra: string;
  p: integer;
begin
  pStr := AnsiLowerCase(pStr);

  NewSentence := True;
  i := 1;

  while i <= Length(pStr) do
  begin
    if NewSentence and (pStr[i] <> ' ') then
    begin
      pStr[i] := AnsiUpperCase(pStr[i])[1];
      NewSentence := False;
    end;

    if CharInSet(pStr[i], ['.', ';', '?', '!']) then
      NewSentence := True;

    Inc(i);
  end;

  aPalavras := pStr.Split([' ']);

  for i := 0 to Length(aPalavras) - 1 do
  begin
    sPalavra := aPalavras[i];
    p := Pos('/' + sPalavra + '/', Conectores);
    if p = 0 then
    begin
      sPalavra[1] := AnsiUpperCase(sPalavra[1])[1];
      aPalavras[i] := sPalavra;
    end;
  end;

  Result := '';

  for i := 0 to Length(aPalavras) - 1 do
  begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + aPalavras[i];
  end;
end;

function TruncSnakeCase(pIdentifier: string;
  pMaxIdentifierLenght: integer): string;
var
  aPalavras: TArray<string>;
  iMaior, i, L: integer;
begin
  Result := pIdentifier;
  L := Result.Length;

  if L <= pMaxIdentifierLenght then
    exit;

  Result := '';
  aPalavras := pIdentifier.Split(['_']);

  while SnakeCaseFutureLenght(aPalavras) > pMaxIdentifierLenght do
  begin
    iMaior := ArrayLargestIndex(aPalavras);
    StrDeleteNoFim(aPalavras[iMaior], 1);
    // aPalavras[iMaior] := StrDeleteNoFim(aPalavras[iMaior], 1);
  end;

  for i := 0 to Length(aPalavras) - 1 do
  begin
    if Result <> '' then
      Result := Result + '_';

    Result := Result + aPalavras[i];
  end;

  Result := StrSemCharRepetido(Result, '_');
end;

function ArrayLargestIndex(pPalavras: TArray<string>): integer;
var
  i, max, index: integer;
begin
  max := 0; // inicializa o comprimento m�ximo como zero
  index := -1; // inicializa o �ndice como -1 (significa que o array est� vazio)
  for i := 0 to Length(pPalavras) - 1 do // percorre o array de strings
  begin
    if Length(pPalavras[i]) > max then
    // se a string atual � mais longa do que o m�ximo atual
    begin
      max := Length(pPalavras[i]);
      // atualiza o m�ximo com o comprimento da string atual
      index := i; // atualiza o �ndice com o �ndice da string atual
    end;
  end;
  Result := index; // retorna o �ndice da string mais longa
end;

function SnakeCaseFutureLenght(pPalavras: TArray<string>): integer;
var
  L, i, len: integer;
begin
  L := Length(pPalavras) - 1;

  len := 0;
  for i := 0 to L do
  begin
    len := len + Length(pPalavras[i]);
  end;

  len := len + L;

  Result := len;
end;

procedure StrDeleteNoFim(var pStr: string; pQtdChars: integer);
var
  L: integer;
begin
  L := pStr.Length;

  if L = 0 then
  begin
    pStr := '';
    exit;
  end;

  L := L - pQtdChars;

  if L < 1 then
  begin
    pStr := '';
    exit;
  end;

  SetLength(pStr, L);
end;

procedure StrDeleteNoInicio(var pStr: string; pQtdChars: integer);
var
  L: integer;
begin
  L := pStr.Length;

  if L = 0 then
  begin
    pStr := '';
    exit;
  end;

  L := L - pQtdChars;

  if L < 1 then
  begin
    pStr := '';
    exit;
  end;

  pStr := Copy(pStr, pQtdChars + 1, L);
end;

procedure StrDeleteTrailingChars(var pStr: string; const CharSet: TSysCharSet);
begin
  while (pStr <> '') and CharInSet(pStr[Length(pStr)], CharSet) do
  begin
    StrDeleteNoFim(pStr, 1);
  end;
end;

procedure StrSepareInicio(pStrOrigem: string; pQtdChars: integer;
  out pStrIni: string; out pStrFim: string);
begin
  if pQtdChars < 1 then
  begin
    pStrIni := '';
    pStrFim := pStrOrigem;
    exit;
  end
  else if pQtdChars >= Length(pStrOrigem) then
  begin
    pStrIni := pStrOrigem;
    pStrFim := '';
    exit;
  end;

  pStrIni := Copy(pStrOrigem, 1, pQtdChars);
  pStrFim := Copy(pStrOrigem, pQtdChars + 1, Length(pStrOrigem) - pQtdChars);
end;

function StrCountCharLeft(pStr: string; pCharInicial: Char): integer;
var
  i, count: integer;
begin
  pStr := Trim(pStr);
  if pStr = '' then
  begin
    Result := 0;
    exit;
  end;

  if pStr[1] <> pCharInicial then
  begin
    Result := 0;
    exit;
  end;

  count := 0;
  for i := 1 to Length(pStr) do
  begin
    if pStr[i] = pCharInicial then
      Inc(count)
    else
      break;
  end;

  Result := count;
end;

procedure SemCharAEsquerda(var pStr: string; pCharInicial: Char = '0');
var
  iQtdCharsIniciais: integer;
begin
  pStr := Trim(pStr);

  iQtdCharsIniciais := StrCountCharLeft(pStr, pCharInicial);

  if iQtdCharsIniciais < 1 then
    exit;

  StrDeleteNoInicio(pStr, iQtdCharsIniciais);
end;

function TemChar(pStr: string; pChar: Char): boolean;
begin
  Result := Pos(pChar, pStr) > 0;
end;

function TemChars(const Str: string; const Chars: TArray<Char>): boolean;
var
  i: integer;
  c: Char;
begin
  Result := False;
  for c in Chars do
  begin
    for i := 1 to Length(Str) do
    begin
      if Str[i] = c then
      begin
        Result := True;
        exit;
      end;
    end;
  end;
end;

procedure DeleteChar(pStr: string; pCharToDel: Char);
begin
  pStr := StringReplace(pStr, pCharToDel, '', [rfReplaceAll]);
end;

procedure StrSemEnterNoFim(var pStr: string);
// Esta procedure modifica a string passada por refer�ncia, removendo o enter (#13#10) no final, se houver
begin
  if Length(pStr) >= 2 then
  // Verifica se a string tem pelo menos dois caracteres
  begin
    if (pStr[Length(pStr) - 1] = #13) and (pStr[Length(pStr)] = #10) then
    // Verifica se os dois �ltimos caracteres s�o #13#10
    begin
      SetLength(pStr, Length(pStr) - 2);
      // Remove os dois �ltimos caracteres da string
    end;
  end;
end;

function StrCheckSum(const pStr: string;
  pSHA2Version: THashSHA2.TSHA2Version): string;
begin
  // Cria uma inst�ncia da classe THashSHA2 com a vers�o SHA-256
  // var Hasher := THashSHA2.Create(THashSHA2.TSHA2Version.SHA256);
  var
  Hasher := THashSHA2.Create(pSHA2Version);
  // Calcula o hash da string pStr
  Hasher.Update(pStr);
  // Retorna o hash como uma string hexadecimal
  Result := Hasher.HashAsString;
end;

procedure StrCheckSum32(pStr: string; out pCheckStr: string);
begin
  pCheckStr := StrCheckSum32(pStr);
end;

function StrCheckSum32(pStr: string): string;
var
  Hasher: THashFNV1a32;
begin
  Hasher := THashFNV1a32.Create; // cria um objeto THashFNV1a32
  Hasher.Update(pStr); // atualiza o hash com a string pStr
  Result := Hasher.HashAsString; // obt�m o hash como uma string hexadecimal
end;

function VarToString(pValue: variant): string;
begin
  Result := VarToStrDef(pValue, '');
end;

function ConvertHTMLChars(pStr: string): string;
begin
  Result := pStr;
  Result := StringReplace(Result, '&atilde;', '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ccedil;', '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ccedil;', '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&eacute;', '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Eacute;', '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&otilde;', '�', [rfReplaceAll]);
  {
    &atilde;
    &ccedil;
    &Ccedil;
    &eacute;
    &Eacute;
    &otilde;
  }
end;

function ClassNameToNome(pClassName: string;
  pDeleteLastWord: boolean = True): string;
var
  i: integer;
  Words: TStringList;
  // CurrentWord: string;
begin
  Result := '';

  // Remove o primeiro caractere se for 'T'
  if (Length(pClassName) > 0) and (pClassName[1] = 'T') then
    Delete(pClassName, 1, 1);

  // Adiciona espa�os antes de letras mai�sculas seguidas de min�sculas ou n�meros
  Words := TStringList.Create;
  try
    i := 1;
    while i <= Length(pClassName) do
    begin
      if (i > 1) and ((CharInSet(pClassName[i], ['A' .. 'Z']) and
        CharInSet(pClassName[i - 1], ['a' .. 'z'])) or CharInSet(pClassName[i],
        ['0' .. '9'])) then
      begin
        Words.Add(Copy(pClassName, 1, i - 1));
        pClassName := Copy(pClassName, i, Length(pClassName) - i + 1);
        i := 1;
      end
      else
        Inc(i);
    end;
    Words.Add(pClassName);

    // Ignora a �ltima palavra se houver mais de uma e se pDeleteLastWord for True
    if pDeleteLastWord and (Words.count > 1) then
      Words.Delete(Words.count - 1);

    Result := StringReplace(Words.Text, sLineBreak, ' ', [rfReplaceAll]).Trim;
  finally
    Words.Free;
  end;
end;

procedure EnsureStringFixedLength(var aStr: string; aLength: integer);
begin
  if Length(aStr) < aLength then
    aStr := aStr + StringOfChar(' ', aLength - Length(aStr))
  else if Length(aStr) > aLength then
    aStr := Copy(aStr, 1, aLength);
end;

procedure EnsureStringMinimalLength(var aStr: string; aLength: integer);
begin
  if Length(aStr) < aLength then
    aStr := aStr + StringOfChar(' ', aLength - Length(aStr));
end;

procedure OverwriteString(var aTargetStr: string; const aSourceStr: string;
  pStartPos: integer);
var
  i: integer;
begin
  EnsureStringMinimalLength(aTargetStr, pStartPos + Length(aSourceStr) - 1);
  for i := 1 to Length(aSourceStr) do
    aTargetStr[pStartPos + i - 1] := aSourceStr[i];
end;

procedure OverwriteStringRight(var aTargetStr: string; const aSourceStr: string;
  aEndPos: integer);
var
  StartPos, i: integer;
begin
  StartPos := aEndPos - Length(aSourceStr) + 1;
  EnsureStringMinimalLength(aTargetStr, aEndPos);
  for i := 1 to Length(aSourceStr) do
    aTargetStr[StartPos + i - 1] := aSourceStr[i];
end;

// procedure CenterStr(var aTarget: string; aWidth: integer; aFillChar: char; aAddAtEnd: Boolean);
// var
// iPadding: integer;
// L: integer;
// begin
// aTarget := Trim(aTarget);
//
// L := Length(aTarget);
// if L = aWidth then
// exit;
//
// if L > aWidth then
// begin
// SetLength(aTarget, aWidth);
// exit;
// end;
//
// iPadding := (aWidth - L) div 2;
// aTarget := StringOfChar(aFillChar, iPadding) + aTarget;
//
// if aAddAtEnd then
// begin
// L := Length(aTarget);
// aTarget := aTarget + StringOfChar(aFillChar, aWidth - L - iPadding);
// end;
// end;

function CenterStr(aTarget: string; aWidth: integer; aFillChar: Char;
  aAddAtEnd: boolean): string;
var
  iPadding: integer;
  L: integer;
begin
  Result := Trim(aTarget);

  L := Length(Result);
  if L = aWidth then
    exit;

  if L > aWidth then
  begin
    SetLength(Result, aWidth);
    exit;
  end;

  iPadding := (aWidth - L) div 2;
  Result := StringOfChar(aFillChar, iPadding) + Result;

  if aAddAtEnd then
  begin
    L := Length(Result);
    Result := Result + StringOfChar(aFillChar, aWidth - L - iPadding);
  end;
end;

function KeyToStr(Key: Word): String;
begin
  case Key of
    // vkHIGHESTVALUE, vkUNKNOWN, vkUNDEFINED:
    // Result := '??';

    vk0:
      Result := '0';
    vk1:
      Result := '1';
    vk2:
      Result := '2';
    vk3:
      Result := '3';
    vk4:
      Result := '4';
    vk5:
      Result := '5';
    vk6:
      Result := '6';
    vk7:
      Result := '7';
    vk8:
      Result := '8';
    vk9:
      Result := '9';
    vkA:
      Result := 'A';
    vkB:
      Result := 'B';
    vkC:
      Result := 'C';
    vkD:
      Result := 'D';
    vkE:
      Result := 'E';
    vkF:
      Result := 'F';
    vkG:
      Result := 'G';
    vkH:
      Result := 'H';
    vkI:
      Result := 'I';
    vkJ:
      Result := 'J';
    vkK:
      Result := 'K';
    vkL:
      Result := 'L';
    vkM:
      Result := 'M';
    vkN:
      Result := 'N';
    vkO:
      Result := 'O';
    vkP:
      Result := 'P';
    vkQ:
      Result := 'Q';
    vkR:
      Result := 'R';
    vkS:
      Result := 'S';
    vkT:
      Result := 'T';
    vkU:
      Result := 'U';
    vkV:
      Result := 'V';
    vkW:
      Result := 'W';
    vkX:
      Result := 'X';
    vkY:
      Result := 'Y';
    vkZ:
      Result := 'Z';

    vkF1:
      Result := 'F1';
    vkF2:
      Result := 'F2';
    vkF3:
      Result := 'F2';
    vkF4:
      Result := 'F4';
    vkF5:
      Result := 'F5';
    vkF6:
      Result := 'F6';
    vkF7:
      Result := 'F7';
    vkF8:
      Result := 'F8';
    vkF9:
      Result := 'F9';
    vkF10:
      Result := 'F10';
    vkF11:
      Result := 'F11';
    vkF12:
      Result := 'F12';
    vkF13:
      Result := 'F13';
    vkF14:
      Result := 'F14';
    vkF15:
      Result := 'F15';
    vkF16:
      Result := 'F16';
    vkF17:
      Result := 'F17';
    vkF18:
      Result := 'F18';
    vkF19:
      Result := 'F19';
    vkF20:
      Result := 'F20';
    vkF21:
      Result := 'F21';
    vkF22:
      Result := 'F22';
    vkF23:
      Result := 'F23';
    vkF24:
      Result := 'F24';

    vkTAB:
      Result := 'Tab';
    vkSHIFT:
      Result := 'Shift'; // See also vkLSHIFT, vkRSHIFT
    vkRETURN:
      Result := 'Enter'; // The "Enter" key, also used for a keypad center press
    vkBACK:
      Result := 'Back'; // The "Backspace" key, dont confuse with the
    // Android BACK key which is mapped to vkESCAPE
    vkCONTROL:
      Result := 'Ctr'; // See also vkLCONTROL, vkRCONTROL
    vkDELETE:
      Result := 'Del';
    vkMENU:
      Result := 'Alt';
    // The ALT key. Also called "Option" in Mac OS X. See also vkLMENU, vkRMENU
    vkPAUSE:
      Result := 'Pause'; // Pause/Break key
    vkCAPITAL:
      Result := 'Caps'; // CapsLock key
    vkSPACE:
      Result := 'Space';
    vkEND:
      Result := 'End';
    vkHOME:
      Result := 'Home';
    vkLEFT:
      Result := 'Left';
    vkUP:
      Result := 'Up';
    vkRIGHT:
      Result := 'Right';
    vkDOWN:
      Result := 'Down';
    vkSELECT:
      Result := 'Selct';
    vkPRINT:
      Result := 'Print'; // PrintScreen key
    vkEXECUTE:
      Result := 'Execte';
    vkSNAPSHOT:
      Result := 'Snapsht';
    vkINSERT:
      Result := 'Insrt';
    vkCLEAR:
      Result := 'Clear';

    vkLWIN:
      Result := 'LSYS';
    // In Mac OS X this is the Apple, or Command key. Windows Key in PC keyboards
    vkRWIN:
      Result := 'RSYS';
    // In Mac OS X this is the Apple, or Command key. Windows Key in PC keyboards
    vkESCAPE:
      Result := 'Esc'; // Also used for the hardware Back key in Android
    vkPRIOR:
      Result := 'PageUp'; // Page Up
    vkNEXT:
      Result := 'PageDwn'; // Page Down
    vkSCROLL:
      Result := 'Scrll';

    vkNUMLOCK:
      Result := 'Num';
    vkNUMPAD0:
      Result := 'Num0';
    vkNUMPAD1:
      Result := 'Num1';
    vkNUMPAD2:
      Result := 'Num2';
    vkNUMPAD3:
      Result := 'Num3';
    vkNUMPAD4:
      Result := 'Num4';
    vkNUMPAD5:
      Result := 'Num5';
    vkNUMPAD6:
      Result := 'Num6';
    vkNUMPAD7:
      Result := 'Num7';
    vkNUMPAD8:
      Result := 'Num8';
    vkNUMPAD9:
      Result := 'Num9';
    vkMULTIPLY:
      Result := 'Num*';
    // vkMULTIPLY up to vkDIVIDE are usually in the numeric keypad in PC keyboards
    vkADD:
      Result := 'Num+';
    vkSEPARATOR:
      Result := 'NumEntr';
    vkSUBTRACT:
      Result := 'Num-';
    // vkDECIMAL:
    // Result := 'Num' + DefaultFormatSettings.DecimalSeparator;
    vkDIVIDE:
      Result := 'Num/';

    vkLBUTTON:
      Result := 'LBtn';
    vkRBUTTON:
      Result := 'RBtn';
    vkCANCEL:
      Result := 'Cncl';
    vkMBUTTON:
      Result := 'MBtn';
    vkXBUTTON1:
      Result := 'XBtn1';
    vkXBUTTON2:
      Result := 'XBtn2';

    // vkOEM_PLUS:
    // Result := '+'; // For any country/region, the '+' key
    // vkOEM_COMMA:
    // Result := ','; // For any country/region, the ',' key
    // vkOEM_MINUS:
    // Result := '-'; // For any country/region, the '-' key
    // vkOEM_PERIOD:
    // Result := '.'; // For any country/region, the '.' key

    // Application.ExtendedKeysSupport
    vkLSHIFT:
      Result := 'LShift';
    vkRSHIFT:
      Result := 'RShift';
    vkLCONTROL:
      Result := 'LCtr';
    vkRCONTROL:
      Result := 'RCtr';
    vkLMENU:
      Result := 'LAlt'; // Left ALT key (also named Option in Mac OS X)
    vkRMENU:
      Result := 'RAlt'; // Right ALT key (also named Option in Mac OS X)

    vkHELP:
      Result := 'Help';
    vkAPPS:
      Result := 'Apps'; // The PopUp key in PC keyboards
    vkSLEEP:
      Result := 'Sleep';

    vkPROCESSKEY:
      Result := 'Prgrss'; // IME Process key

    vkKANA:
      Result := 'Kana';
    // vkHANGUL:     Result := 'Hangul';
    vkJUNJA:
      Result := 'Junja';
    vkFINAL:
      Result := 'Final';
    vkHANJA:
      Result := 'Hanja';
    // vkKANJI:      Result := 'Kanji';
    vkCONVERT:
      Result := 'Conrt';
    vkNONCONVERT:
      Result := 'NConrt';
    vkACCEPT:
      Result := 'Acc';
    vkMODECHANGE:
      Result := 'MdlCh';

    vkATTN:
      Result := 'Attn';
    vkCRSEL:
      Result := 'CrSel';
    vkEXSEL:
      Result := 'ExSel';
    vkEREOF:
      Result := 'Ereof';
    vkPLAY:
      Result := 'Play';
    vkZOOM:
      Result := 'Zoom';
    vkNONAME:
      Result := 'NoName';
    vkPA1:
      Result := 'Pa1';

    // vkLCL_POWER:
    // Result := 'Power';
    // vkLCL_CALL:
    // Result := 'Call';
    // vkLCL_ENDCALL:
    // Result := 'EndCall';
    // vkLCL_AT:
    // Result := '@';
    // Not equivalent to anything < $FF, will only be sent by a primary "@" key
    // but not for a @ key as secondary action of a "2" key for example
  else
    Result := '???';

    { Not Used Keys:

      vkBROWSER_BACK        = $A6;
      vkBROWSER_FORWARD     = $A7;
      vkBROWSER_REFRESH     = $A8;
      vkBROWSER_STOP        = $A9;
      vkBROWSER_SEARCH      = $AA;
      vkBROWSER_FAVORITES   = $AB;
      vkBROWSER_HOME        = $AC;
      vkVOLUME_MUTE         = $AD;
      vkVOLUME_DOWN         = $AE;
      vkVOLUME_UP           = $AF;
      vkMEDIA_NEXT_TRACK    = $B0;
      vkMEDIA_PREV_TRACK    = $B1;
      vkMEDIA_STOP          = $B2;
      vkMEDIA_PLAY_PAUSE    = $B3;
      vkLAUNCH_MAIL         = $B4;
      vkLAUNCH_MEDIA_SELECT = $B5;
      vkLAUNCH_APP1         = $B6;
      vkLAUNCH_APP2         = $B7;

      // vkOEM keys are utilized only when Application.ExtendedKeysSupport is false

      vkOEM_1               = $BA; // Used for miscellaneous characters; it can vary by keyboard.
      // For the US standard keyboard, the ';:' key

      vkOEM_2               = $BF; // Used for miscellaneous characters; it can vary by keyboard.
      // For the US standard keyboard, the '/?' key
      vkOEM_3               = $C0; // Used for miscellaneous characters; it can vary by keyboard.
      // For the US standard keyboard, the '`~' key

      vkOEM_4               = $DB; // Used for miscellaneous characters; it can vary by keyboard.
      // For the US standard keyboard, the '[{' key
      vkOEM_5               = $DC; // Used for miscellaneous characters; it can vary by keyboard.
      // For the US standard keyboard, the '\|' key
      vkOEM_6               = $DD; // Used for miscellaneous characters; it can vary by keyboard.
      // For the US standard keyboard, the '] } // ' key vkOEM_7 = $DE;
    // Used for miscellaneous characters; it can vary by keyboard.
    // For the US standard keyboard, the 'single-quote/double-quote' key
    // vkOEM_8 = $DF;
    // Used for miscellaneous characters; it can vary by keyboard.

    // $E0 Reserved
    // $E1 OEM specific
    // vkOEM_102 = $E2;
    // Either the angle bracket key or the backslash key on the RT 102-key keyboard

    // vkOEM_CLEAR = $FE;
    // }
  end;
end;

function PosIndicada(const pStr, pSubStr: string;
  pOrdemOcorrenciaDesejada: integer): integer;
var
  Contador, InicioBusca, LS: integer;
begin
  Result := 0;

  if pOrdemOcorrenciaDesejada < 1 then
    exit;

  Contador := 0;
  InicioBusca := 1;
  LS := Length(pSubStr);

  // Buscar a ocorr�ncia espec�fica
  while Contador < pOrdemOcorrenciaDesejada do
  begin
    Result := PosEx(pSubStr, pStr, InicioBusca);
    if Result = 0 then
      Break;

    Inc(Contador);
    InicioBusca := Result + LS;
  end;

  if Contador >= pOrdemOcorrenciaDesejada then
    Dec(Result, LS);
end;

end.
