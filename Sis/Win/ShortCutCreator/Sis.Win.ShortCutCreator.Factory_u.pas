unit Sis.Win.ShortCutCreator.Factory_u;

interface

uses Sis.Win.ShortCutCreator, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

function ShortCutCreatorCreate(pAssunto, pPastaComandos, pPastaDesktop: string;
  pExtension: string = 'bat'; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil): IShortCutCreator;

implementation

uses Sis.Win.ShortCutCreator.PowerShell_u, System.SysUtils,
  Sis.Win.ShortCutCreator.Bat_u;

function ShortCutCreatorCreate(pAssunto, pPastaComandos, pPastaDesktop: string;
  pExtension: string = 'bat'; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil): IShortCutCreator;
begin
  pExtension := AnsiLowerCase(pExtension);

  if pExtension = 'bat' then
    Result := TShortCutCreatorBat.Create(pOutput, pProcessLog)
  else if pExtension = 'ps1' then
    Result := TShortCutCreatorPowerShell.Create(pOutput, pProcessLog)
  else
    Result := nil;

  if Result = nil then
    exit;

  Result.Inicialize(pAssunto, pPastaComandos, pPastaDesktop);
end;

end.
