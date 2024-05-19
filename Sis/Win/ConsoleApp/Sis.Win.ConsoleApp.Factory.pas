unit Sis.Win.ConsoleApp.Factory;

interface

uses Sis.Win.ConsoleApp;

function ConsoleAppCreate: IConsoleApp;

implementation

uses Sis.Win.ConsoleApp_u;

function ConsoleAppCreate: IConsoleApp;
begin
  Result := TConsoleApp.Create;
end;

end.
