program Pausa;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

procedure Apresentacao;
begin
  Writeln('Pausa eh usado para uma pausa na execucao de arquvos em lote');
  Writeln('Uso: pausa <qtd segundos>');
  Writeln('Exemplo: pausa 7');
  Writeln('Faz uma pausa de 7 segundos antes de terminar e liberar a execucao');
end;

procedure Erro;
begin
  Writeln('Erro: parametro deve ser um numero inteiro maior do que zero');
  Apresentacao;
end;

var
  q: integer;
  i: integer;
  s: string;
  bResultado: Boolean;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    if ParamCount = 0 then
    begin
      Apresentacao;
      exit;
    end;

    s := paramstr(1);
    bResultado := TryStrToInt(s, q);
    if not bResultado then
    begin
      Erro;
      exit;
    end;

    for i := 1 to q do
    begin
      Sleep(1000);
      Write(i.ToString + ' ');
    end;
    Writeln('');
    Writeln('Fim da pausa');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
