program VersaoAtu;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  VersaoAtu.SrcAtu_u in 'SrcAtu\VersaoAtu.SrcAtu_u.pas';
var
  sDescribe: string;
  sHash: string;
  sGMTDtH: string;
begin
  try
    ReadLn(sDescribe);
    ReadLn(sHash);
    ReadLn(sGMTDtH);
    SrcAtuExecute(sDescribe, sHash, sGMTDtH);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
