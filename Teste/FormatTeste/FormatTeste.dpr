program FormatTeste;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;
var
  curr: Currency;
  s: string;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    curr := 0;
    writeln(Format('%.3f', [curr])); // 0,000
    writeln(Format('%.f', [curr])); // 0,00
    writeln(Format('%f', [curr])); // 0,00
    writeln(Format('%n', [curr])); // 0,00
    writeln(Format('%g', [curr])); // 0
    writeln(Format('%.g', [curr])); // 0

    writeln(Format('%g', [0.1]));
    writeln(Format('%g', [0.10]));
    writeln(Format('%g', [0.11]));
    writeln(Format('%g', [0.111]));
    writeln(Format('%g', [0.0001]));

    writeln('--------');

    writeln(Format('%6.4f', [32.01]));
    writeln('--------');
  s := FormatFloat('000000.0000', 32.01);

    {
0,000
0,00
0,00
0,00
0
0
0,1
0,1
0,11
0,111
0,0001
    }

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
