program VersaoAtu;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  VersaoAtu.SrcAtu_u in 'SrcAtu\VersaoAtu.SrcAtu_u.pas';

var
  sDescribe: string;
  sISO8601DtH: string;
  sHash: string;

procedure LeiaStdIn;
begin
  {$IFDEF DEBUG}
    sDescribe := '0.0.1-7-g9c74db8';
    sISO8601DtH := '2024-05-19 19:38:52 -0300';
    sHash := '9c74db80ea8f6c7d43cac7fb7f590fa2154455e3';
    exit;
  {$ENDIF}
  ReadLn(sDescribe);
  ReadLn(sISO8601DtH);
  ReadLn(sHash);
end;

begin
  try
    LeiaStdIn;
    SrcAtuExecute(sDescribe, sISO8601DtH, sHash);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
