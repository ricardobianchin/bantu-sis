unit btu.sta.exec.testes.strings_u;

interface

procedure TesteStrings;

implementation

uses btn.lib.types.strings, Vcl.Dialogs;

procedure TesteStrSemEspacoDuplo;
var
  s: string;
begin
  s := '         ';
  s := StrSemEspacoDuplo(s);
  ShowMessage(s);

  s := '  Oi,    como   vai  você?  ';
  s := StrSemEspacoDuplo(s);
  ShowMessage(s);

  s := 'Esta   é  uma   string    com   muitos   espaços  ';
  s := StrSemEspacoDuplo(s);
  ShowMessage(s);

  s := 'Sem espaços';
  s := StrSemEspacoDuplo(s);
  ShowMessage(s);


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
