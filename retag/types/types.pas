unit types;

interface

procedure CharSemAcento(var Key: Char);
procedure StrSemAcento(var s: string);

implementation

// Constantes com os caracteres imprim�veis e os de substitui��o
const
  Imprimiveis  = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ����������������';
  Substituicao = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZaeiouAEIOUaoAOcC';

// Procedure que recebe um par�metro var Key: char e faz a substitui��o
procedure CharSemAcento(var Key: Char);
var
  Posic: Integer;
begin
  // Localiza o conte�do do par�metro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posi��o na segunda constante
  if Posic >= 1 then
    Key := Substituicao[Posic];
end;

// Procedure que recebe um par�metro var s: string e faz a substitui��o de cada caractere
procedure StrSemAcento(var s: string);
var
  i: Integer;
  c: Char;
begin
  // Percorre cada caractere da string
  for i := 1 to Length(s) do
  begin
    // Obt�m o caractere na posi��o i
    c := s[i];
    // Executa a procedure SubstituirCaractere para o caractere c
    CharSemAcento(c);
    // Atribui o caractere substitu�do na posi��o i da string
    s[i] := c;
  end;
end;


end.
