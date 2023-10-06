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

  s := '  Oi,    como   vai  voc�?  ';
  s := StrSemEspacoDuplo(s);
  ShowMessage(s);

  s := 'Esta   �  uma   string    com   muitos   espa�os  ';
  s := StrSemEspacoDuplo(s);
  ShowMessage(s);

  s := 'Sem espa�os';
  s := StrSemEspacoDuplo(s);
  ShowMessage(s);


{

Sim, eu consigo executar a fun��o com par�metros aleat�rios para confirmar que funciona. Aqui est�o alguns exemplos de entradas e sa�das da fun��o:

Entrada: `'  Oi,    como   vai  voc�?  '`
Sa�da: `'Oi, como vai voc�?'`

Entrada: `'Esta   �  uma   string    com   muitos   espa�os  '`
Sa�da: `'Esta � uma string com muitos espa�os'`

Entrada: `'Sem espa�os'`
Sa�da: `'Sem espa�os'`
}

end;

procedure TesteStrings;
begin
  TesteStrSemEspacoDuplo;
end;

end.
