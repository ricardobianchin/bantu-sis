unit Sis.Types.strings_u;

interface

uses System.UITypes, System.Hash;

procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean = True);
function StrSemAcento(const pStr: string;
  pTudoMaiusculas: boolean = True): string;

function CharIsUpper(pC: Char): boolean;
function CharIsLower(pC: Char): boolean;

function StrSemStr(pStr: string; pStrARemover: string = #32): string;
function StrSemCharRepetido(pStr: string; pChar: Char = #32): string;

function CharIsOnlyDigit(Key: Char): boolean;
function StrToOnlyDigit(const pStr: string): string;
function StrIsOnlyDigit(const pStr: string): boolean;

procedure CharToName(var Key: Char);
function StrToName(const pStr: string): string;

function StrDeleteNoFim(pStr: string; pQtdChars: integer): string;
function StrDeleteNoInicio(pStr: string; pQtdChars: integer): string;

procedure StrSepareInicio(pStrOrigem: string; pQtdChars: integer;
  out pStrIni: string; out pStrFim: string);

function IsWindowsFilenameChar(c: Char): boolean;
procedure ReplaceInvalidFilenameChar(var c: Char);
function StrToNomeArq(const filename: string): string;
function IsWindowsFilenameValid(filename: string): boolean;

function RightPos(pCar: Char; pStr: string): integer;

function StrApos(pStr, pBusca: string): string;
function StrValue(pStr: string): string;

function StrGarantirTermino(pStr, pTermino: string): string;

function IsDigit(c: Char): boolean;
procedure AjusteAsciiCodeToChar(var pStr: string);

function TruncSnakeCase(pIdentifier: string;
  pMaxIdentifierLenght: integer): string;
// function ArrayToSnakeCase(pPalavras: TArray<string>): string;
function ArrayLargestIndex(pPalavras: TArray<string>): integer;
function SnakeCaseFutureLenght(pPalavras: TArray<string>): integer;
function StrCountCharLeft(pStr: string; pCharInicial: Char = '0'): integer;
function SemCharAEsquerda(pStr: string; pCharInicial: Char = '0'): string;
function TemChar(pStr: string; pChar: Char): boolean;
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

// function WrapTexto(pStr: string; pMaxCol: integer = 45): boolean;

implementation

uses System.SysUtils, System.StrUtils, System.Variants, System.Classes;

const
  Imprimiveis = ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    '¡·¿‡√„¬‚…È»Ë ÍÕÌ”Û’ı‘Ù⁄˙«Á');
  SubstSemAcento = ('ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ' +
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
      Result := false;
      break;
    end;
  end;
end;

// Procedure que recebe um par‚metro var Key: char e faz a substituiÁ„o
procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean);
var
  Posic: integer;
begin
  // Localiza o conte˙do do par‚metro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posiÁ„o na segunda constante
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

// Procedure que recebe um par‚metro var s: string e faz a substituiÁ„o de cada caractere
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

procedure CharToName(var Key: Char);
var
  Posic: integer;
begin
  // Localiza o conte˙do do par‚metro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posiÁ„o na segunda constante

  if Posic >= 1 then
    Key := SubstSemAcento[Posic]
  else
    Key := '_';
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
      Result := false;
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
  // Remover espaÁos no inÌcio e no fim da string
  pStr := Trim(pStr);

  // Inicializar os Ìndices i e j
  i := 1;
  j := 1;
  // Percorrer a string da esquerda para a direita
  while i <= Length(pStr) do
  begin
    // Copiar o caractere na posiÁ„o i para a posiÁ„o j
    pStr[j] := pStr[i];
    // Se o caractere for um espaÁo, avanÁar i atÈ encontrar um caractere diferente de espaÁo
    if pStr[i] = pChar then
    begin
      while (i <= Length(pStr)) and (pStr[i] = pChar) do
        Inc(i);
    end
    // Caso contr·rio, avanÁar i normalmente
    else
      Inc(i);
    // AvanÁar j tambÈm
    Inc(j);
  end;
  // Ajustar o tamanho da string para o valor de j - 1
  SetLength(pStr, j - 1);
  // Retornar a string modificada
  Result := pStr;
end;

function StrGarantirTermino(pStr, pTermino: string): string;
var
  iLenTermino: integer;
  sFinalAtual: string;
begin
  Result := pStr;

  iLenTermino := Length(pTermino);

  if iLenTermino = 0 then
    exit;

  sFinalAtual := RightStr(pStr, iLenTermino);
  if sFinalAtual = pTermino then
    exit;

  Result := Result + pTermino;
end;

// FunÁ„o que recebe um char e retorna verdadeiro se for um algarismo
function IsDigit(c: Char): boolean;
begin
  // Verifica se o cÛdigo ASCII do char est· entre 48 e 57, que correspondem aos algarismos de 0 a 9
  IsDigit := (ord(c) >= 48) and (ord(c) <= 57);
end;

// Procedure que recebe uma string cujo conte˙do s„o dados separados por ; e substitui as sequÍncias de # seguidas de 3 algarismos pelo caractere ASCII correspondente
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
      // Verifica se os prÛximos trÍs caracteres s„o algarismos
      if (i + 3 <= Length(pStr)) and IsDigit(pStr[i + 1]) and
        IsDigit(pStr[i + 2]) and IsDigit(pStr[i + 3]) then
      begin
        // Converte os trÍs algarismos em um n˙mero inteiro
        code := StrToInt(pStr[i + 1] + pStr[i + 2] + pStr[i + 3]);
        // Converte o n˙mero inteiro em um caractere ASCII
        c := chr(code);
        // Substitui a sequÍncia de # e trÍs algarismos pelo caractere ASCII na string original
        pStr := Copy(pStr, 1, i - 1) + c + Copy(pStr, i + 4,
          Length(pStr) - i - 3);
      end;
    end;
    // Incrementa o Ìndice da string
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
    aPalavras[iMaior] := StrDeleteNoFim(aPalavras[iMaior], 1);
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
  max := 0; // inicializa o comprimento m·ximo como zero
  index := -1; // inicializa o Ìndice como -1 (significa que o array est· vazio)
  for i := 0 to Length(pPalavras) - 1 do // percorre o array de strings
  begin
    if Length(pPalavras[i]) > max then
    // se a string atual È mais longa do que o m·ximo atual
    begin
      max := Length(pPalavras[i]);
      // atualiza o m·ximo com o comprimento da string atual
      index := i; // atualiza o Ìndice com o Ìndice da string atual
    end;
  end;
  Result := index; // retorna o Ìndice da string mais longa
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

function StrDeleteNoFim(pStr: string; pQtdChars: integer): string;
var
  L: integer;
begin
  Result := pStr;

  L := pStr.Length;
  if L = 0 then
    exit;

  L := L - pQtdChars;
  if L < 1 then
  begin
    Result := '';
    exit;
  end;

  Result := LeftStr(pStr, L);
end;

function StrDeleteNoInicio(pStr: string; pQtdChars: integer): string;
var
  L: integer;
begin
  Result := pStr;

  L := pStr.Length;
  if L = 0 then
    exit;

  L := L - pQtdChars;
  if L < 1 then
  begin
    Result := '';
    exit;
  end;

  Result := RightStr(pStr, L);
  {
    // Verifica se a quantidade de caracteres È v·lida
    if (pQtdChars > 0) and (pQtdChars < Length(pStr)) then
    // Retorna a substring a partir da posiÁ„o pQtdChars + 1
    Result := Copy(pStr, pQtdChars + 1, Length(pStr) - pQtdChars)
    else
    // Retorna a string original se a quantidade de caracteres È inv·lida
    Result := pStr;
  }
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

function SemCharAEsquerda(pStr: string; pCharInicial: Char = '0'): string;
var
  iQtdCharsIniciais: integer;
  sCortada: string;
begin
  pStr := Trim(pStr);

  iQtdCharsIniciais := StrCountCharLeft(pStr, pCharInicial);

  if iQtdCharsIniciais < 1 then
  begin
    Result := pStr;
    exit;
  end;

  sCortada := StrDeleteNoInicio(pStr, iQtdCharsIniciais);
  Result := sCortada;
end;

function TemChar(pStr: string; pChar: Char): boolean;
begin
  Result := Pos(pChar, pStr) > 0;
end;

procedure DeleteChar(pStr: string; pCharToDel: Char);
begin
  pStr := StringReplace(pStr, pCharToDel, '', [rfReplaceAll]);
end;

procedure StrSemEnterNoFim(var pStr: string);
// Esta procedure modifica a string passada por referÍncia, removendo o enter (#13#10) no final, se houver
begin
  if Length(pStr) >= 2 then
  // Verifica se a string tem pelo menos dois caracteres
  begin
    if (pStr[Length(pStr) - 1] = #13) and (pStr[Length(pStr)] = #10) then
    // Verifica se os dois ˙ltimos caracteres s„o #13#10
    begin
      SetLength(pStr, Length(pStr) - 2);
      // Remove os dois ˙ltimos caracteres da string
    end;
  end;
end;

function StrCheckSum(const pStr: string;
  pSHA2Version: THashSHA2.TSHA2Version): string;
begin
  // Cria uma inst‚ncia da classe THashSHA2 com a vers„o SHA-256
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
  Result := Hasher.HashAsString; // obtÈm o hash como uma string hexadecimal
end;

function VarToString(pValue: variant): string;
begin
  Result := VarToStrDef(pValue, '');
end;

function ConvertHTMLChars(pStr: string): string;
begin
  Result := pStr;
  Result := StringReplace(Result, '&atilde;', '„', [rfReplaceAll]);
  Result := StringReplace(Result, '&ccedil;', 'Á', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ccedil;', '«', [rfReplaceAll]);
  Result := StringReplace(Result, '&eacute;', 'È', [rfReplaceAll]);
  Result := StringReplace(Result, '&Eacute;', '…', [rfReplaceAll]);
  Result := StringReplace(Result, '&otilde;', 'ı', [rfReplaceAll]);
  {
    &atilde;
    &ccedil;
    &Ccedil;
    &eacute;
    &Eacute;
    &otilde;
  }
end;

(*
  function ClassNameToNome(pClassName: string): string;
  var
  i: Integer;
  begin
  Result := '';

  // Remove o primeiro caractere se for 'T'
  if (Length(pClassName) > 0) and (pClassName[1] = 'T') then
  Delete(pClassName, 1, 1);

  // Adiciona espaÁos antes de letras mai˙sculas seguidas de min˙sculas
  for i := 1 to Length(pClassName) do
  begin
  if (i > 1) and (pClassName[i] in ['A'..'Z']) and (pClassName[i-1] in ['a'..'z']) then
  Result := Result + ' ';
  Result := Result + pClassName[i];
  end;
  end;
*)

function ClassNameToNome(pClassName: string;
  pDeleteLastWord: boolean = True): string;
var
  i: integer;
  Words: TStringList;
  CurrentWord: string;
begin
  Result := '';

  // Remove o primeiro caractere se for 'T'
  if (Length(pClassName) > 0) and (pClassName[1] = 'T') then
    Delete(pClassName, 1, 1);

  // Adiciona espaÁos antes de letras mai˙sculas seguidas de min˙sculas ou n˙meros
  Words := TStringList.Create;
  try
    i := 1;
    while i <= Length(pClassName) do
    begin
      if (i > 1) and ((pClassName[i] in ['A' .. 'Z']) and
        (pClassName[i - 1] in ['a' .. 'z'])) or (pClassName[i] in ['0' .. '9'])
      then
      begin
        Words.Add(Copy(pClassName, 1, i - 1));
        pClassName := Copy(pClassName, i, Length(pClassName) - i + 1);
        i := 1;
      end
      else
        Inc(i);
    end;
    Words.Add(pClassName);

    // Ignora a ˙ltima palavra se houver mais de uma e se pDeleteLastWord for True
    if pDeleteLastWord and (Words.count > 1) then
      Words.Delete(Words.count - 1);

    Result := StringReplace(Words.Text, sLineBreak, ' ', [rfReplaceAll]).Trim;
  finally
    Words.Free;
  end;
end;

end.
