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

  s := '  Oi,    como   vai  voc�?  ';
  s := StrSemCharRepetido(s);
  //Sho wMe ssage(s);

  s := 'Esta   �  uma   string    com   muitos   espa�os  ';
  s := StrSemCharRepetido(s);
  //Sho wMe ssage(s);

  s := 'Sem espa�os';
  s := StrSemCharRepetido(s);
  //Sho wMe ssage(s);


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
