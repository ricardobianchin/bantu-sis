unit App.DB.Garantir_u.GravarInicialServ;

interface

uses Sis.DB.DBTypes, Sis.Usuario, Sis.Loja, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, App.AppObj, Sis.Terminal, Sis.Entities.Types,
  Sis.Types.Bool_u{, Vcl.Dialogs};

procedure GravarInicialServ(pTerminal: ITerminal;
  rDBConnectionParamsServ: TDBConnectionParams; pAppObj: IAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ISisLoja;
  pUsuarioAdmin: IUsuario);

implementation

uses Sis.DB.Factory, System.SysUtils, Sis.Threads.Crit.FixedCriticalSection_u,
  Sis.Win.Utils_u, Sis.Usuario.DBI, Sis.Usuario.Factory;

var
  DBConnectionServ: IDBConnection;
  DBExecScript: IDBExecScript;
  FixedCriticalSection: TFixedCriticalSection;

procedure GarantirTerminal(pTerminal: ITerminal; pAppObj: IAppObj;
  pLoja: ISisLoja; pUsuarioAdmin: IUsuario);
var
  sSql: string;
  T: ITerminal;
begin

  T := pTerminal;
  sSql := 'EXECUTE PROCEDURE TERMINAL_PA.GARANTIR (' //
    + T.TerminalId.ToString // TERMINAL_ID

    + ', ' + T.Apelido.QuotedString // APELIDO
    + ', ' + T.NomeNaRede.QuotedString // NOME_NA_REDE
    + ', ' + T.IP.QuotedString // IP
    + ', ' + T.LetraDoDrive.QuotedString // LETRA_DO_DRIVE

    + ', ' + T.NFSerie.ToString // NF_SERIE

    + ', ' + BooleanToStrSQL(T.GavetaTem) // GAVETA_TEM
    + ', ' + T.GavetaComando.QuotedString // GAVETA_COMANDO
    + ', ' + T.GavetaImprNome.QuotedString // GAVETA_IMPR_NOME

    + ', ' + T.BalancaModoUsoId.ToString // BALANCA_MODO_USO_ID
    + ', ' + T.BalancaId.ToString // BALANCA_ID

    + ', ' + T.BarCodigoIni.ToString // BARRAS_COD_INI
    + ', ' + T.BarCodigoTam.ToString // BARRAS_COD_TAM

    + ', ' + T.ImpressoraModoEnvioId.ToString // IMPRESSORA_MODO_ENVIO_ID
    + ', ' + T.ImpressoraModeloId.ToString // IMPRESSORA_MODELO_ID
    + ', ' + T.ImpressoraNome.QuotedString // GAVETA_IMPR_NOME
    + ', ' + T.ImpressoraColsQtd.ToString // IMPRESSORA_COLS_QTD

    + ', ' + T.CupomQtdLinsFinal.ToString // CUPOM_QTD_LINS_FINAL

    + ', ' + BooleanToStrSQL(T.SempreOffLine) // SEMPRE_OFFLINE
    + ', ' + BooleanToStrSQL(T.Ativo) // SEMPRE_OFFLINE

    + ', ' + T.BALANCA_PORTA.ToString // BALANCA_PORTA
    + ', ' + T.BALANCA_BAUDRATE.ToString // BALANCA_BAUDRATE
    + ', ' + T.BALANCA_DATABITS.ToString // BALANCA_DATABITS
    + ', ' + T.BALANCA_PARIDADE.ToString // BALANCA_PARIDADE
    + ', ' + T.BALANCA_STOPBITS.ToString // BALANCA_STOPBITS
    + ', ' + T.BALANCA_HANDSHAKING.ToString // BALANCA_HANDSHAKING

    + ', ' + pLoja.Id.ToString // LOG_LOJA_ID
    + ', ' + pUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + pAppObj.SisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ');'; //

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  DBExecScript.PegueComando(sSql);
end;

procedure GravarInicialServ(pTerminal: ITerminal;
  rDBConnectionParamsServ: TDBConnectionParams; pAppObj: IAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ISisLoja;
  pUsuarioAdmin: IUsuario);
var
  oUsuarioDBI: IUsuarioDBI;
begin
  FixedCriticalSection := TFixedCriticalSection.Create;
  DBConnectionServ := DBConnectionCreate('GravarInicialServ.Conn',
    pAppObj.SisConfig, rDBConnectionParamsServ, nil, nil);

  oUsuarioDBI := UsuarioDBICreate(DBConnectionServ, pUsuarioAdmin,
    pAppObj.SisConfig);

  DBConnectionServ.Abrir;
  try
    oUsuarioDBI.LeiaAdmin;

    DBExecScript := DBExecScriptCreate('GravarInicialServ.ExecScript',
      DBConnectionServ, nil, nil, FixedCriticalSection, False);

    GarantirTerminal(pTerminal, pAppObj, pLoja, pUsuarioAdmin);

    DBExecScript.Sql.SaveToFile('C:\DarosPDV\Garantir serv.sql');
    DBExecScript.Execute;
//    showmessage('C:\DarosPDV\Garantir serv.sql');
  finally
    DBConnectionServ.Fechar;
    FixedCriticalSection.Free;
  end;
end;

end.
