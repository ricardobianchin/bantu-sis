unit types;

interface

procedure CharSemAcento(var Key: Char);
procedure StrSemAcento(var s: string);

implementation

// Constantes com os caracteres imprimíveis e os de substituição
const
  Imprimiveis  = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZáéíóúÁÉÍÓÚãõÃÕçÇ';
  Substituicao = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZaeiouAEIOUaoAOcC';

// Procedure que recebe um parâmetro var Key: char e faz a substituição
procedure CharSemAcento(var Key: Char);
var
  Posic: Integer;
begin
  // Localiza o conteúdo do parâmetro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posição na segunda constante
  if Posic >= 1 then
    Key := Substituicao[Posic];
end;

// Procedure que recebe um parâmetro var s: string e faz a substituição de cada caractere
procedure StrSemAcento(var s: string);
var
  i: Integer;
  c: Char;
begin
  // Percorre cada caractere da string
  for i := 1 to Length(s) do
  begin
    // Obtém o caractere na posição i
    c := s[i];
    // Executa a procedure SubstituirCaractere para o caractere c
    CharSemAcento(c);
    // Atribui o caractere substituído na posição i da string
    s[i] := c;
  end;
end;


end.
