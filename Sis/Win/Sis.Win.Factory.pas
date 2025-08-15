unit Sis.Win.Factory;

interface

uses Sis.Win.VersionInfo, Sis.ui.io.output, Sis.Win.execute, WinApi.Windows,
  Sis.ui.io.Factory, Sis.ui.io.output.ProcessLog;

function WinVersionCreate: IWinVersionInfo;

function WinExecuteCreate(pExecuteFile, pParams, pStartIn: string;
  pExecuteAoCriar: boolean; pShowMode: integer = SW_SHOWMINNOACTIVE;
  pElevate: boolean = False; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil; pPastaComando: string = '';
  pOutputFileName: string = ''; pErrorFileName: string = ''): IWinExecute;

procedure WinExecuteComando(pExecuteFile, pParams: string;
  pStartIn: string = ''; pOutput: IOutput = nil);

implementation

uses Sis.Win.VersionInfo_u, Sis.ui.io.output.Mudo_u, Sis.Win.Execute_u,
  Sis.ui.io.Files.Factory, Sis.ui.io.Files, System.SysUtils;

function WinVersionCreate: IWinVersionInfo;
begin
  Result := TWinVersionInfo.Create;
end;

function WinExecuteCreate(pExecuteFile, pParams, pStartIn: string;
  pExecuteAoCriar: boolean; pShowMode: integer; pElevate: boolean;
  pOutput: IOutput; pProcessLog: IProcessLog; pPastaComando: string;
  pOutputFileName: string; pErrorFileName: string): IWinExecute;
var
  sOutputFileName: string;
  sErrorFileName: string;
  dtAgora: TDateTime;
begin
  if pPastaComando <> '' then
  begin
    pPastaComando := GarantaPasta(pPastaComando);

    dtAgora := Now;

    if pOutputFileName = '' then
      pOutputFileName := 'WinExec.saida.' + FormatDateTime('yyyymmddhhnnsszzz',
        dtAgora) + '.txt';
    if pErrorFileName = '' then
      pErrorFileName := 'WinExec.erro.' + FormatDateTime('yyyymmddhhnnsszzz',
        dtAgora) + '.txt';

    sOutputFileName := pPastaComando + pOutputFileName;
    sErrorFileName := pPastaComando + pErrorFileName;
  end;

  Result := TWinExecute.Create(pExecuteFile, pParams, pStartIn, pExecuteAoCriar,
    pShowMode, pElevate, pOutput, pProcessLog, sOutputFileName, sErrorFileName);
end;

procedure WinExecuteComando(pExecuteFile, pParams: string; pStartIn: string;
  pOutput: IOutput);
var
  we: IWinExecute;
begin
  we := WinExecuteCreate(pExecuteFile, pParams, pStartIn, true);
  we.EspereExecucao(pOutput);
end;

end.
