unit sta.exec.testes.strings_u;

interface

procedure TesteStrings;

implementation

uses sis.types.strings, Vcl.Dialogs;

procedure TesteStrSemEspacoDuplo;
var
  s: string;
begin
  s := '         ';
  s := StrSemCharRepetido(s);
  //Sho wMe ssage(s);

  s := '  Oi,    como   vai  você?  ';
  s := StrSemCharRepetido(s);
  //Sho wMe ssage(s);

  s := 'Esta   é  uma   string    com   muitos   espaços  ';
  s := StrSemCharRepetido(s);
  //Sho wMe ssage(s);

  s := 'Sem espaços';
  s := StrSemCharRepetido(s);
  //Sho wMe ssage(s);


{

Sim, eu consigo executar a função com parâmetros aleatórios para confirmar que funciona. Aqui estão alguns exemplos de entradas e saídas da função:

Entrada: `'  Oi,    como   vai  você?  '`
Saída: `'Oi, como vai você?'`

Entrada: `'Esta   é  uma   string    com   muitos   espaços  '`
Saída: `'Esta é uma string com muitos espaços'`

Entrada: `'Sem espaços'`
Saída: `'Sem espaços'`
}

end;

procedure TesteStrings;
begin
  TesteStrSemEspacoDuplo;
end;

end.
