program VersaoAtu;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  VersaoAtu.SrcAtu_u in 'SrcAtu\VersaoAtu.SrcAtu_u.pas';

var
  sDescribe: string;
  sGMTDtH: string;
  sHash: string;

procedure LeiaStdIn;
begin
  ReadLn(sDescribe);
  ReadLn(sGMTDtH);
  ReadLn(sHash);
end;

begin
  try
    LeiaStdIn;
    SrcAtuExecute(sDescribe, sGMTDtH, sHash);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
