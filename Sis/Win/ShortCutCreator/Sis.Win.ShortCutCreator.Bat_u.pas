unit Sis.Win.ShortCutCreator.Bat_u;

interface

uses Sis.Win.ShortCutCreator, Sis.Win.ShortCutCreator_u, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

type
  TShortCutCreatorBat = class(TShortCutCreator, IShortCutCreator)
  private
  public
    procedure AddScriptFor(pNomeAtalho, pExe, pParams,
      pStartIn: string); override;
    function Execute: Boolean; override;
  end;

implementation

uses System.SysUtils, Sis.Win.Execute, Sis.Types.strings_u, Sis.Win.Factory,
  Winapi.Windows, Sis.UI.IO.Files;

{ TShortCutCreatorBat }

procedure TShortCutCreatorBat.AddScriptFor(pNomeAtalho, pExe, pParams,
  pStartIn: string);
var
  sPastaAtalho: string;
  sComando: string;
begin
  inherited;
  sPastaAtalho := PastaAcima(PastaComandos) + 'Inst\Atalhos\';
  sComando := 'copy "' + sPastaAtalho + pNomeAtalho + '.lnk" "' +
    PastaDesktop + '"';
  ScriptSL.Add(sComando);
  ScriptSL.Add('');

end;

function TShortCutCreatorBat.Execute: Boolean;
var
  sNomeScript: string;
  WinExec: IWinExecute;
  sLog: string;
begin
  ProcessLog.PegueLocal('TShortCutCreatorBat.Execute');
  try
    sNomeScript := PastaComandos + StrToNomeArq(Assunto) + '.bat';

    // Salva o script PowerShell no arquivo
    ScriptSL.SaveToFile(sNomeScript);
    ProcessLog.RegistreLog('Bat salvo: ' + sNomeScript, Now, lptExecExternal,
      sNomeScript);

    // Cria IWinExecute para executar o script com elevação e captura de saída/erro
    WinExec := WinExecuteCreate(pWideChar(sNomeScript), '', PastaComandos, //
      False, // Não executar ao criar
      SW_SHOWMINNOACTIVE, //
      True, // pElevate para runas
      Output, //
      ProcessLog, //
      PastaComandos, //
      '', // Nome padrão com timestamp (ex.: WinExec.saida.<timestamp>.txt)
      '' // Nome padrão com timestamp (ex.: WinExec.erro.<timestamp>.txt)
      );

    // Executa o comando
    ProcessLog.RegistreLog('vai WinExec.Execute');
    Result := WinExec.Execute;
    if Result then
    begin
      ProcessLog.RegistreLog('vai WinExec.EspereExecucao');
      WinExec.EspereExecucao(Output);

      Mens := WinExec.Saida + #13#10 + WinExec.Erro + #13#10;

      // // Exibe resultado, mantendo comportamento original
      // if WinExec.Erro <> '' then
      // ShowMessage('Erro no PowerShell: ' + WinExec.Erro)
      // else
      // ShowMessage('Execução OK: ' + WinExec.Saida);

      // Opcional: apaga o arquivo de script após execução
      // DeleteFile(sNomeScript);
    end
    else
    begin
      Mens := 'Falha ao iniciar execução do script PowerShell';
      ProcessLog.RegistreLog(Mens, Now, lptExecExternal, sNomeScript);
    end;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

end.
