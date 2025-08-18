unit Sis.DB.Updater.Firebird_u;

interface

uses Sis.DB.Updater_u, Sis.DB.DBTypes, Sis.Config.SisConfig,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, Sis.Loja, Sis.Usuario,
  Sis.Entities.Types;

// upd ates especifico para firebird, no pai, funcito q diz se existe o arq dados
type
  TDBUpdaterFirebird = class(TDBUpdater)
  private
  protected

    // procedure AtualizeBanco;virtual; abstract;
    function GetNomeBanco: string; override;

    /// <summary>
    /// Verifica se o banco de dados existe.
    /// </summary>
    /// <returns>
    /// Retorna um valor de <c>TGetDBExisteRetorno</c> indicando se o banco de dados existia,
    /// se n�o existia e foi copiado, ou se n�o existia.
    /// </returns>
    function GetDBExiste: TGetDBExisteRetorno; override;

    procedure CrieDB; override;
    // function GetSqlDbUpdateIns: string; override;
    // function GetSqlDbUpdateGetMax: string; override;
  public
    constructor Create(pTerminalId: TTerminalId;
      pDBConnectionParams: TDBConnectionParams; pPastaProduto: string;
      pDBMS: IDBMS; pSisConfig: ISisConfig; pProcessLog: IProcessLog;
      pOutput: IOutput; pLoja: ISisLoja; pUsuarioAdmin: IUsuario;
      pVariaveis: string);
  end;

implementation

uses System.SysUtils, System.StrUtils, Winapi.Windows, System.Variants,
  Sis.win.VersionInfo, dialogs, Sis.UI.IO.Files, Sis.win.Utils_u,
  Sis.Types.Bool_u, Sis.DB.Updater.Firebird.GetSql_u, Sis.Types.strings_u;

{ TDBUpdaterFirebird }

constructor TDBUpdaterFirebird.Create(pTerminalId: TTerminalId;
  pDBConnectionParams: TDBConnectionParams; pPastaProduto: string; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput;
  pLoja: ISisLoja; pUsuarioAdmin: IUsuario; pVariaveis: string);
begin
  pProcessLog.PegueLocal('TDBUpdaterFirebird.Create');
  try
    pProcessLog.RegistreLog('vai inherited Create');
    inherited Create(pTerminalId, pDBConnectionParams, pPastaProduto, pDBMS,
      pSisConfig, pProcessLog, pOutput, pLoja, pUsuarioAdmin, pVariaveis);
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdaterFirebird.CrieDB;
var
  sLog: string;
  sAssunto: string;
  sNomeBanco: string;
  ComandosSQL: string;
begin
  ProcessLog.PegueLocal('TDBUpdaterFirebird.CrieDB');
  try
    ComandosSQL := GetSQLCreateDatabase(DBConnectionParams.Arq);

    sAssunto := 'Cria';
    sNomeBanco := DBConnectionParams.GetNomeBanco;
    sLog := 'vai DBMS.ExecInterative,sAssunto=' + sAssunto + ',ComandosSQL=' +
      ComandosSQL;
    ProcessLog.RegistreLog(sLog);

    DBMS.ExecInterative(sAssunto, ComandosSQL, sNomeBanco,
      PastaProduto + 'Comandos\Updater\', ProcessLog, Output);

    sleep(200);
  finally
    ProcessLog.RegistreLog('fim');
    ProcessLog.RetorneLocal;
  end;
end;

// TGetDBExisteRetorno = (dbeExistia, dbeNaoExistiaCopiou, dbeNaoExistia);
function TDBUpdaterFirebird.GetDBExiste: TGetDBExisteRetorno;
var
  sPastaInstDados, sNomeArqInstDados: string;
  Resultado: Boolean;
begin
  Result := dbeNaoExistia;
  ProcessLog.PegueLocal('TDBUpdaterFirebird.GetDBExiste');
  try
    ProcessLog.RegistreLog('vai testar se existe DBConnectionParams.Arq=' +
      DBConnectionParams.Arq);

    Resultado := FileExists(DBConnectionParams.Arq);

    if Resultado then
    begin
      Result := dbeExistia;
      ProcessLog.RegistreLog('existia, vai abortar');
      exit;
    end;

    ProcessLog.RegistreLog('nao existia');

    GarantaPastaDoArquivo(DBConnectionParams.Arq);

    sPastaInstDados := PastaProduto + 'Inst\inst-Firebird\dados\';
    ProcessLog.RegistreLog('sPastaInstDados=' + sPastaInstDados);

    GarantaPasta(sPastaInstDados);
    sNomeArqInstDados :=
      ChangeFileExt(ExtractFileName(DBConnectionParams.Arq), '');
    if TerminalId > 0 then
    begin
      StrDeleteNoFim(sNomeArqInstDados, 4);
    end;
    (*
      if SisConfig.WinVersionInfo.Version <= 6.1 then
      begin

      end
      else
      begin
      sNomeArqInstDados := sNomeArqInstDados + '5';
      if SisConfig.WinVersionInfo.WinPlatform = wplatWin64 then
      begin
      sNomeArqInstDados := sNomeArqInstDados + '32'; //+ '64';//NAO DEPENDE DA PLATAFORMA, MAS DA VARSAO DO FIREBIRD, SEMPRE 32
      end
      else
      begin
      sNomeArqInstDados := sNomeArqInstDados + '32';
      end;
      end;
    *)
    sNomeArqInstDados := sNomeArqInstDados + '_v5_32bits';
    sNomeArqInstDados := sPastaInstDados + sNomeArqInstDados + '.fdb';

    ProcessLog.RegistreLog('vai testar se existe ' + sNomeArqInstDados);

    Resultado := FileExists(sNomeArqInstDados);

    if not Resultado then
    begin
      ProcessLog.RegistreLog('Nao existia arquivo original. vai terminar');
      exit;
    end;

    ProcessLog.RegistreLog('vai copiar(' + sNomeArqInstDados + ',' +
      DBConnectionParams.Arq + ')');

    CopyFile(PChar(sNomeArqInstDados), PChar(DBConnectionParams.Arq), False);
    Result := dbeNaoExistiaCopiou;

    ProcessLog.RegistreLog('vai testar se existe');
    Resultado := FileExists(DBConnectionParams.Arq);
    ProcessLog.RegistreLog('Resultado=' + BooleanToStr(Resultado));
    if not Resultado then
      Result := dbeNaoExistia;
  finally
    ProcessLog.RegistreLog('Resultado=' + BooleanToStr(Resultado));
    ProcessLog.RetorneLocal;
  end;
end;

function TDBUpdaterFirebird.GetNomeBanco: string;
begin
  Result := 'FIREBIRD';
end;

// function TDBUpdaterFirebird.GetSqlDbUpdateGetMax: string;
// begin
// Result := GetSqlDBUpdateGetMaxFirebird;
// end;

// function TDBUpdaterFirebird.GetSqlDbUpdateIns: string;
// begin
// Result := GetSqlDBUpdateInsFirebird;
// end;

end.
