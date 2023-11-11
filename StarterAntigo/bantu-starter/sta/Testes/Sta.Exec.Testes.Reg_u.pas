unit sta.exec.testes.reg_u;

interface

procedure TestesRegChamar;

implementation

uses sis.win.registry, Winapi.Windows;

procedure TestesRegChamar;
var
  s: string;
begin
  s := ReadRegStr(HKEY_LOCAL_MACHINE
    , 'SOFTWARE\Firebird Project\Firebird Server\Instances'
    , 'DefaultInstance'
    , rvRegistry64
    );

  writeln(s);

//  const View: TRegistryView = rvDefault): string;

//  TRegistryView = (rvDefault, rvRegistry64, rvRegistry32);

//function ReadRegStr(const Root: HKEY; const Key, Name: string;
//  const View: TRegistryView = rvDefault): string;



end;

end.
