unit Sis.Win.Execute_u;

interface

uses Sis.Win.Execute, Sis.Sis.Executavel_u, ShellApi, Windows,
  Sis.UI.IO.Output, System.SysUtils, System.Classes,
  Sis.UI.IO.Output.ProcessLog;

type
  TWinExecute = class(TExecutavel, IWinExecute)
  private
    SEInfo: TShellExecuteInfo;
    FExecuteFile, FParams, FStartIn: string;
    FExecuteAoCriar: boolean;
    FShowMode: integer;
    FOutputFileName: string;
    FErrorFileName: string;
    FSaida: string;
    FErro: string;

    function GetSaida: string;
    function GetErro: string;
  public
    function Executando: boolean;
    function Execute: boolean; override;
    procedure EspereExecucao(pOutput: IOutput; pQtdIntervals: integer = 8);

    constructor Create(pExecuteFile, pParams, pStartIn: string;
      pExecuteAoCriar: boolean; pShowMode: integer = SW_SHOWMINNOACTIVE; pElevate: boolean = False;
      pOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
      pOutputFileName: string = ''; pErrorFileName: string = '');

    property Saida: string read GetSaida;
    property Erro: string read GetErro;
  end;

implementation

uses Vcl.Forms;

{ TWinExecute }

constructor TWinExecute.Create(pExecuteFile, pParams, pStartIn: string;
  pExecuteAoCriar: boolean; pShowMode: integer; pElevate: boolean; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputFileName: string; pErrorFileName: string);
var
  pApplicationHandle: HWnd;
  sOriginalCmd: string;
  sRedirect: string;
begin
  inherited Create(pOutput);

  pApplicationHandle := Application.Handle;
  FExecuteAoCriar := pExecuteAoCriar;

  FExecuteFile := pExecuteFile;
  FParams := pParams;
  FStartIn := pStartIn;
  FShowMode := pShowMode;
  FOutputFileName := pOutputFileName;
  FErrorFileName := pErrorFileName;

  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  with SEInfo do
  begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := pApplicationHandle;

    if pElevate then
      lpVerb := PChar('runas'); // Define 'runas' se pRunAs for True

    lpDirectory := PChar(FStartIn);
    nShow := pShowMode;

    // Configura redirecionamento se arquivos de saída/erro forem informados
    if (FOutputFileName <> '') or (FErrorFileName <> '') then
    begin
      sOriginalCmd := FExecuteFile;
      if FParams <> '' then
        sOriginalCmd := sOriginalCmd + ' ' + FParams;

      sRedirect := '';
      if FOutputFileName <> '' then
        sRedirect := sRedirect + ' > "' + FOutputFileName + '"';
      if FErrorFileName <> '' then
        sRedirect := sRedirect + ' 2> "' + FErrorFileName + '"';

      lpFile := PChar('cmd.exe');
      lpParameters := PChar('/c "' + sOriginalCmd + sRedirect + '"');
    end
    else
    begin
      lpFile := PChar(FExecuteFile);
      if FParams <> '' then
        lpParameters := PChar(FParams);
    end;
  end;

  if FExecuteAoCriar then
    Execute;
end;

function TWinExecute.Executando: boolean;
var
  ExitCode: DWORD;
begin
  GetExitCodeProcess(SEInfo.hProcess, ExitCode);
  Result := ExitCode = STILL_ACTIVE;
end;

function TWinExecute.Execute: boolean;
begin
  ProcessLog.PegueLocal('TWinExecute.Execute');
  try
    ProcessLog.RegistreLog('vai ShellExecuteEx');
    Result := ShellExecuteEx(@SEInfo);
    if Result then
    begin
      ProcessLog.RegistreLog('Retornou True');
      exit;
    end;
    ProcessLog.RegistreLog('Retornou False' + SysErrorMessage(GetLastError),
      Now, lptExecExternal, FExecuteFile);
    // Opcional: raise Exception.Create('Erro ao executar: ' + SysErrorMessage(GetLastError));
  finally
    ProcessLog.RetorneLocal;
  end;
end;

function TWinExecute.GetErro: string;
begin
  Result := FErro;
end;

function TWinExecute.GetSaida: string;
begin
  Result := FSaida;
end;

procedure TWinExecute.EspereExecucao(pOutput: IOutput;
  pQtdIntervals: integer = 8);
var
  iQtdVoltas: integer;
  iQtdExib: integer;
  iMod: integer;
  sl: TStringList;
begin
  ProcessLog.PegueLocal('TWinExecute.EspereExecucao');
  try
  iQtdVoltas := 0;
  iQtdExib := 0;
  repeat
    sleep(150);
    if not Executando then
      break;
    iMod := iQtdVoltas mod pQtdIntervals;
    if iMod = 0 then
    begin
      inc(iQtdExib);
      pOutput.Exibir('Aguardando a execução... ' + IntToStr(iQtdVoltas));
    end;

    inc(iQtdVoltas);
  until False;

  // Após aguardar a execução, carrega os conteúdos dos arquivos nas propriedades (se informados)
  if FOutputFileName <> '' then
  begin
    sl := TStringList.Create;
    try
      if FileExists(FOutputFileName) then
      begin
        sl.LoadFromFile(FOutputFileName);
        FSaida := sl.Text;
        // Opcional: DeleteFile(FOutputFileName); // Descomente se quiser apagar o arquivo após ler
      end;
    finally
      sl.Free;
    end;
  end;

  if FErrorFileName <> '' then
  begin
    sl := TStringList.Create;
    try
      if FileExists(FErrorFileName) then
      begin
        sl.LoadFromFile(FErrorFileName);
        FErro := sl.Text;
        // Opcional: DeleteFile(FErrorFile); // Descomente se quiser apagar o arquivo após ler
      end;
    finally
      sl.Free;
    end;
  end;
  finally
    ProcessLog.RegistreLog(#13#10'Saida='#13#10+FSaida+#13#10'Erro='#13#10+FErro+#13#10);
    ProcessLog.RetorneLocal;
  end;
end;

end.
