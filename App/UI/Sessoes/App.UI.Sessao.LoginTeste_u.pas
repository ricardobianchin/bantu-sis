unit App.UI.Sessao.LoginTeste_u;

interface

uses Sis.UI.Form.Login.Teste, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output,
  Sis.ModuloSistema.Types, Sis.DB.DBTypes, Sis.Entities.Types, App.AppObj,
  Sis.Terminal, Sis.UI.Controls.AndamentoFrame_u;

type
  TLoginTeste = class(TInterfacedObject, ILoginTeste)
  private
    // FServDBConnection: IDBConnection;
    // FTermDBConnection: IDBConnection;
    FAppObj: IAppObj;

    function LojaPessoaExiste(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
      pDBConnection: IDBConnection; pOutput: IOutPut;
      pProcessLog: IProcessLog): Boolean;

    function SequencesOk(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
      pTerminalId: TTerminalId; pServDBConnection: IDBConnection;
      pTermDBConnection: IDBConnection; pOutput: IOutPut;
      pProcessLog: IProcessLog): Boolean;

  public
    function PodeIniciar(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
      pTerminalId: TTerminalId; pOutput: IOutPut;
      pProcessLog: IProcessLog): Boolean;

    constructor Create(pAppObj: IAppObj);
  end;

implementation

uses App.DB.Utils, Sis.Sis.Constants, Sis.DB.Factory, System.SysUtils, Data.DB;

{ TLoginTeste }

constructor TLoginTeste.Create(pAppObj: IAppObj);
begin
  FAppObj := pAppObj;
end;

function TLoginTeste.LojaPessoaExiste(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
  pDBConnection: IDBConnection; pOutput: IOutPut;
  pProcessLog: IProcessLog): Boolean;
// const
// SetExigeLoja: set of TOpcaoSisIdModulo = [TOpcaoSisIdModulo.opmoduRetaguarda,
// TOpcaoSisIdModulo.opmoduPDV];
var
  // SetExigeLoja: set of TOpcaoSisIdModulo;
  sSql: string;
  sPessoaNome: string;
begin
  // para o caso de voltar a ser variavei
  // SetExigeLoja := [TOpcaoSisIdModulo.opmoduRetaguarda,
  // TOpcaoSisIdModulo.opmoduPDV];

  // Result := not(pOpcaoSisIdModulo in SetExigeLoja);
  // if Result then
  // exit;

  sSql := //
    'SELECT PES.NOME'#13#10 + #13#10 //

    + 'FROM LOJA LOJ'#13#10 + #13#10 //

    + 'LEFT JOIN LOJA_EH_PESSOA LEP ON'#13#10 //
    + 'LOJ.LOJA_ID = LEP.LOJA_ID'#13#10 + #13#10 //

    + 'LEFT JOIN PESSOA PES ON'#13#10 //
    + 'LEP.LOJA_ID = PES.LOJA_ID'#13#10 //
    + 'AND LEP.TERMINAL_ID = PES.TERMINAL_ID'#13#10 //
    + 'AND LEP.PESSOA_ID = PES.PESSOA_ID'#13#10 //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  sPessoaNome := pDBConnection.GetValueString(sSql);
  Result := sPessoaNome <> '';
  if not Result then
  begin
    pOutput.Exibir('Antes de utilizar o Módulo ' //
      + TipoOpcaoSisModuloToStr(pOpcaoSisIdModulo) //
      + ', é necessário completar os dados do estabelecimento ' +
      'no Módulo de Configurações');
  end;
end;

function TLoginTeste.PodeIniciar(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
  pTerminalId: TTerminalId; pOutput: IOutPut; pProcessLog: IProcessLog)
  : Boolean;
var
  ServDBConnectionParams: TDBConnectionParams;
  TermDBConnectionParams: TDBConnectionParams;
  ServDBConnection: IDBConnection;
  TermDBConnection: IDBConnection;

  oTerminal: ITerminal;
  bServAbriu: Boolean;
begin
  try
    Result := pOpcaoSisIdModulo = TOpcaoSisIdModulo.opmoduConfiguracoes;
    if Result then
      exit;

    ServDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, FAppObj);
    ServDBConnection := DBConnectionCreate
      ('TLoginTeste.LojaPessoaExiste.Retag.Conn', FAppObj.SisConfig,
      ServDBConnectionParams, pProcessLog, nil);

    if pOpcaoSisIdModulo = TOpcaoSisIdModulo.opmoduRetaguarda then
    begin
      Result := ServDBConnection.Abrir;
      if not Result then
      begin
        pOutput.Exibir('Erro buscando o servidor: ' +
          ServDBConnection.UltimoErro);
        exit;
      end;

      try
        Result := LojaPessoaExiste(pOpcaoSisIdModulo, ServDBConnection, pOutput,
          pProcessLog);
      finally
        ServDBConnection.Fechar;
      end;
      exit;
    end;

    oTerminal := FAppObj.TerminalList.TerminalIdToTerminal(pTerminalId);
    TermDBConnectionParams.Server := oTerminal.IdentStr;
    TermDBConnectionParams.Arq := oTerminal.LocalArqDados;
    TermDBConnectionParams.Database := oTerminal.Database;
    TermDBConnection := DBConnectionCreate
      ('TLoginTeste.LojaPessoaExiste.Retag.Conn', FAppObj.SisConfig,
      TermDBConnectionParams, pProcessLog, nil);

    Result := TermDBConnection.Abrir;
    if not Result then
    begin
      pOutput.Exibir('Erro conectando ao terminal: ' +
        TermDBConnection.UltimoErro);
      exit;
    end;
    try
      Result := LojaPessoaExiste(pOpcaoSisIdModulo, TermDBConnection, pOutput,
        pProcessLog);

      if not Result then
        exit;

      bServAbriu := ServDBConnection.Abrir;
      if not bServAbriu then
        exit;
      try
        Result := SequencesOk(pOpcaoSisIdModulo, pTerminalId, ServDBConnection,
          TermDBConnection, pOutput, pProcessLog);
      finally
        ServDBConnection.Fechar;
      end;
    finally
      TermDBConnection.Fechar;
    end;
  finally
    if Result then
      pOutput.Exibir('');
  end;
end;

function TLoginTeste.SequencesOk(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
  pTerminalId: TTerminalId; pServDBConnection: IDBConnection;
  pTermDBConnection: IDBConnection; pOutput: IOutPut;
  pProcessLog: IProcessLog): Boolean;
var
  sSqlServ: string;
  sSqlTerm: string;

  CAIXA_SESSAO_SEQ_SERV: Int64;
  EST_MOV_SEQ_SERV: Int64;
  LOG_SEQ_SERV: Int64;
  PESSOA_SEQ_SERV: Int64;
  VENDA_SEQ_SERV: Int64;

  CAIXA_SESSAO_SEQ_TERM: Int64;
  EST_MOV_SEQ_TERM: Int64;
  LOG_SEQ_TERM: Int64;
  PESSOA_SEQ_TERM: Int64;
  VENDA_SEQ_TERM: Int64;

  Q: TDataSet;

  sMens: string;
begin
  sSqlServ :=
    'SELECT CAIXA_SESSAO_SEQ, EST_MOV_SEQ, LOG_SEQ, PESSOA_SEQ, VENDA_SEQ FROM SEQUENCES_ATUAIS_PA.VALUES_GET('
    + pTerminalId.ToString + ');';
  sSqlTerm :=
    'SELECT CAIXA_SESSAO_SEQ, EST_MOV_SEQ, LOG_SEQ, PESSOA_SEQ, VENDA_SEQ FROM SEQUENCES_ATUAIS_PA.VALUES_GET;';

  pServDBConnection.QueryDataSet(sSqlServ, Q);
  CAIXA_SESSAO_SEQ_SERV := Q.fields[0].AsLargeInt;
  EST_MOV_SEQ_SERV := Q.fields[1].AsLargeInt;
  LOG_SEQ_SERV := Q.fields[2].AsLargeInt;
  PESSOA_SEQ_SERV := Q.fields[3].AsLargeInt;
  VENDA_SEQ_SERV := Q.fields[4].AsLargeInt;
  Q.Free;

  pTermDBConnection.QueryDataSet(sSqlTerm, Q);
  CAIXA_SESSAO_SEQ_TERM := Q.fields[0].AsLargeInt;
  EST_MOV_SEQ_TERM := Q.fields[1].AsLargeInt;
  LOG_SEQ_TERM := Q.fields[2].AsLargeInt;
  PESSOA_SEQ_TERM := Q.fields[3].AsLargeInt;
  VENDA_SEQ_TERM := Q.fields[4].AsLargeInt;
  Q.Free;

  sMens := '';

  if CAIXA_SESSAO_SEQ_SERV <> CAIXA_SESSAO_SEQ_TERM then
    sMens := sMens + '.SESS';

  if EST_MOV_SEQ_SERV <> EST_MOV_SEQ_TERM then
    sMens := sMens + '.EST';

  if LOG_SEQ_SERV <> LOG_SEQ_TERM then
    sMens := sMens + '.LOG';

  if PESSOA_SEQ_SERV <> PESSOA_SEQ_TERM then
    sMens := sMens + '.PESS';

  if VENDA_SEQ_SERV <> VENDA_SEQ_TERM then
    sMens := sMens + '.VEN';

  Result := sMens = '';
  if not Result then
    pOutput.Exibir('Erro na geração de códigos: ' + sMens)

end;

end.
