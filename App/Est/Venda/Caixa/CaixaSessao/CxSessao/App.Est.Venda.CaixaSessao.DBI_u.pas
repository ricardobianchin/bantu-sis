unit App.Est.Venda.CaixaSessao.DBI_u;

interface

uses Sis.DBI_u, App.Est.Venda.CaixaSessao.DBI, Sis.DB.DBTypes, Sis.Usuario,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Terminal, Sis.Entidade, App.Est.Venda.Caixa.CaixaSessao,
  Sis.Entities.Types, Data.DB, FireDAC.Comp.Client, System.Classes,
  App.Est.Venda.CaixaSessaoRecord_u;

type
  /// <summary>
  /// TCaixaSessaoDBI é uma classe que implementa as funcionalidades de Abertura de Caixa.
  /// </summary>
  TCaixaSessaoDBI = class(TDBI, ICaixaSessaoDBI)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FMachineIdentId: smallint;
    FLogUsuario: IUsuario;
    FMensagem: string;
    function GetMensagem: string;
  public
    constructor Create(pDBConnection: IDBConnection; pLogUsuario: IUsuario;
      pLojaId: TLojaId; pTerminalId: TTerminalId; pMachineIdentId: smallint);
      reintroduce;

    function CaixaSessaoAbertoGet(var pCaixaSessaoRec: TCaixaSessaoRec): Boolean;
    procedure PegDados(pCaixaSessao: ICaixaSessao);

    function CaixaSessaoUltimoGet(pCaixaSessao: ICaixaSessao): Boolean;

    property Mensagem: string read GetMensagem;

    procedure PDVCarregarDataSet(pDMemTable1: TFDMemTable;
      pCaixaSessao: ICaixaSessao);

    procedure PreenchaCxSessRelatorio(pLinhas: TStrings;
      pCaixaSessao: ICaixaSessao);
  end;

implementation

uses Sis.Win.Utils_u, Sis.DB.Factory, Sis.Types.Dates, System.SysUtils,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u;

{ TCaixaSessaoDBI }

function TCaixaSessaoDBI.CaixaSessaoAbertoGet(var pCaixaSessaoRec
  : TCaixaSessaoRec): Boolean;
var
  sSql: string;
  q: TDataSet;
begin
  pCaixaSessaoRec.Zerar;

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    sSql := 'SELECT'#13#10 //
      + 'SESS_ID'#13#10 // 0
      + ', PESSOA_ID'#13#10 // 1
      + ', APELIDO'#13#10 // 2
      + ', ABERTO_EM'#13#10 // 3
      + 'FROM CAIXA_SESSAO_MANUT_PA.ABERTO_GET'#13#10;
//     {$IFDEF DEBUG}
//     CopyTextToClipboard(sSql);
//     {$ENDIF}
    DBConnection.QueryDataSet(sSql, q);

    Result := Assigned(q);
    if not Result then
      exit;
    try
      Result := not q.IsEmpty;

      if not Result then
        exit;

      pCaixaSessaoRec.SessId := q.Fields[0].AsInteger;
      pCaixaSessaoRec.PessoaId := q.Fields[1].AsInteger;
      pCaixaSessaoRec.Apelido := q.Fields[2].AsString;
      pCaixaSessaoRec.AbertoEm := q.Fields[3].AsDateTime;
      pCaixaSessaoRec.Aberto := True;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

function TCaixaSessaoDBI.CaixaSessaoUltimoGet(pCaixaSessao
  : ICaixaSessao): Boolean;
var
  oDBQuery: IDBQuery;
  sSql: string;
begin
  pCaixaSessao.Zerar;

  sSql := 'SELECT'#13#10 //

    + 'SESS_LOJA_ID'#13#10 // 0
    + ', SESS_TERMINAL_ID'#13#10 // 1
    + ', SESS_ID'#13#10 // 2

    + ', OPERADOR_LOJA_ID'#13#10 // 3
    + ', OPERADOR_ID'#13#10 // 4

    + ', OPERADOR_APELIDO'#13#10 // 5
    + ', CRIADO_EM'#13#10 // 6

    + 'FROM CAIXA_SESSAO_PDV_PA.SESS_ULTIMO_GET;'#13#10 //
    ;

//   {$IFDEF DEBUG}
//   CopyTextToClipboard(sSql);
//   {$ENDIF}

  oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
    sSql, nil, nil);

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    Result := oDBQuery.Abrir;
    if not Result then
      exit;

    try
      pCaixaSessao.LogUsuario.TerminalId := 0;

      pCaixaSessao.LojaId := oDBQuery.DataSet.Fields[0].AsInteger;
      pCaixaSessao.TerminalId := oDBQuery.DataSet.Fields[1].AsInteger;
      pCaixaSessao.Id := oDBQuery.DataSet.Fields[2].AsInteger;

      pCaixaSessao.LogUsuario.LojaId := oDBQuery.DataSet.Fields[3].AsInteger;
      pCaixaSessao.LogUsuario.Id := oDBQuery.DataSet.Fields[4].AsInteger;

      pCaixaSessao.LogUsuario.NomeExib := oDBQuery.DataSet.Fields[5].AsString;
      pCaixaSessao.AbertoEm := oDBQuery.DataSet.Fields[6].AsDateTime;
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

constructor TCaixaSessaoDBI.Create(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint);
begin
  inherited Create(pDBConnection);
  FLogUsuario := pLogUsuario;
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
  FMachineIdentId := pMachineIdentId;
end;

function TCaixaSessaoDBI.GetMensagem: string;
begin
  Result := FMensagem;
end;

procedure TCaixaSessaoDBI.PDVCarregarDataSet(pDMemTable1: TFDMemTable;
  pCaixaSessao: ICaixaSessao);
var
  oDBQuery: IDBQuery;
  sSql: string;
  t: TFDMemTable;
  q: TDataSet;
  sL, sT, sI: string;
begin
  t := pDMemTable1;

  sL := pCaixaSessao.LojaId.ToString;
  sT := pCaixaSessao.TerminalId.ToString;
  sI := pCaixaSessao.Id.ToString;

  DBConnection.Abrir;
  try
    sSql := //
      'SELECT' //
      + ' LOJA_ID'#13#10 //
      + ', TERMINAL_ID'#13#10 //
      + ', ID'#13#10 //
      + ', LOG_ID'#13#10 //
      + ', ORDEM'#13#10 //
      + ', TIPO_ID'#13#10 //
      + ', TIPO_STR'#13#10 //
      + ', CRIADO_EM'#13#10 //
      + ', VALOR'#13#10 //
      + ', CANCELADO'#13#10 //
      + ', CANCELADO_EM'#13#10 //
      + ', OBS'#13#10 //
      + ' FROM CAIXA_SESSAO_PDV_PA.SESS_TELA_LISTA_GET('#13#10 //

      + sL + ' -- SESS_LOJA_ID'#13#10 //
      + ', ' + sT + ' -- SESS_TERMINAL_ID'#13#10 //
      + ', ' + sI + ' -- SESS_ID'#13#10 //

      + ');';

//{$IFDEF DEBUG}
//    CopyTextToClipboard(sSql);
//{$ENDIF}
    oDBQuery := DBQueryCreate('CxOperaca.tela.lista.get.q', DBConnection, sSql,
      nil, nil);

    pDMemTable1.DisableControls;
    pDMemTable1.Indexes.Clear;
    pDMemTable1.EmptyDataSet;
    pDMemTable1.BeginBatch;

    try
      if pCaixaSessao.Id < 1 then
        exit;

      oDBQuery.Abrir;
      q := oDBQuery.DataSet;
      while not q.Eof do
      begin
        t.Append;
        t.FieldByName('LOJA_ID').AsInteger := q.FieldByName('LOJA_ID')
          .AsInteger;
        t.FieldByName('TERMINAL_ID').AsInteger := q.FieldByName('TERMINAL_ID')
          .AsInteger;
        t.FieldByName('ID').AsInteger := q.FieldByName('ID').AsInteger;
        t.FieldByName('LOG_ID').AsLargeInt := q.FieldByName('LOG_ID')
          .AsLargeInt;
        t.FieldByName('ORDEM').AsInteger := q.FieldByName('ORDEM').AsInteger;
        t.FieldByName('TIPO_ID').AsString := q.FieldByName('TIPO_ID').AsString;
        t.FieldByName('TIPO_STR').AsString := q.FieldByName('TIPO_STR')
          .AsString;
        t.FieldByName('CRIADO_EM').AsDateTime := q.FieldByName('CRIADO_EM')
          .AsDateTime;
        t.FieldByName('VALOR').AsCurrency := q.FieldByName('VALOR').AsCurrency;
        t.FieldByName('CANCELADO').AsBoolean := q.FieldByName('CANCELADO')
          .AsBoolean;
        t.FieldByName('OBS').AsString := q.FieldByName('OBS').AsString;

        if t.FieldByName('TIPO_ID').AsString = cxopVenda.ToChar then
          t.FieldByName('COD_STR').AsString :=
            Sis.Entities.Types.GetCod(t.FieldByName('LOJA_ID').AsInteger,
            t.FieldByName('TERMINAL_ID').AsInteger,
            t.FieldByName('ID').AsInteger, 'VEN')
        else
          t.FieldByName('COD_STR').AsString :=
            Sis.Entities.Types.GetCod(t.FieldByName('LOJA_ID').AsInteger,
            t.FieldByName('TERMINAL_ID').AsInteger,
            t.FieldByName('ID').AsInteger, 'CX') + '-' + t.FieldByName('ORDEM')
            .AsInteger.ToString;

        pDMemTable1.Post;
        oDBQuery.DataSet.Next;
      end;
    finally
      oDBQuery.Fechar;

      pDMemTable1.EndBatch;
      with pDMemTable1.Indexes.Add do
      begin
        Name := 'IdxCriadoEm';
        Fields := 'CRIADO_EM';
        Active := True;
      end;

      pDMemTable1.IndexesActive := True;
      pDMemTable1.IndexName := 'IdxCriadoEm';

      pDMemTable1.First;
      pDMemTable1.EnableControls;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TCaixaSessaoDBI.PegDados(pCaixaSessao: ICaixaSessao);
var
  sSql: string;
  q: TDataSet;
begin
//  pCaixaSessaoRec.Zerar;

  DBConnection.Abrir;

  try
    sSql :=
      'SELECT first(1)'#13#10
      +'SESS.SESS_ID'#13#10//0
      +', PESS.PESSOA_ID'#13#10//1
      +', PESS.APELIDO'#13#10//2
      +', LOG.DTH ABERTO_EM'#13#10//3
      +', sess.aberto'#13#10//4

      +'FROM AMBIENTE_SIS AMBI'#13#10

      +'JOIN CAIXA_SESSAO SESS ON'#13#10
      +'AMBI.LOJA_ID = SESS.LOJA_ID'#13#10
      +'AND AMBI.TERMINAL_ID = SESS.TERMINAL_ID'#13#10

      +'JOIN LOG ON'#13#10
      +'SESS.LOJA_ID = LOG.LOJA_ID'#13#10
      +'AND SESS.TERMINAL_ID = LOG.TERMINAL_ID'#13#10
      +'AND SESS.SESS_LOG_ID = LOG.LOG_ID'#13#10

      +'JOIN PESSOA PESS ON'#13#10
      +'LOG.LOJA_ID = PESS.LOJA_ID'#13#10
      +'AND LOG.PESSOA_TERMINAL_ID = PESS.TERMINAL_ID'#13#10
      +'AND LOG.PESSOA_ID = PESS.PESSOA_ID'#13#10

      +'order by log.dth desc'#13#10
      ;
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}
    DBConnection.QueryDataSet(sSql, q);

    //Result := Assigned(q);
//    if not Result then
//      exit;
    try
      //Result := not q.IsEmpty;

      //if not Result then
        //exit;

      pCaixaSessao.Id := q.Fields[0].AsInteger;
      pCaixaSessao.LogUsuario.Id := q.Fields[1].AsInteger;
      pCaixaSessao.LogUsuario.NomeExib := q.Fields[2].AsString;
      pCaixaSessao.AbertoEm := q.Fields[3].AsDateTime;
      pCaixaSessao.Aberto := q.Fields[4].AsBoolean;

    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TCaixaSessaoDBI.PreenchaCxSessRelatorio(pLinhas: TStrings;
  pCaixaSessao: ICaixaSessao);
var
  oDBQuery: IDBQuery;
  sSql: string;
  q: TDataSet;
  sL, sT, sI: string;
  sLinha: string;
begin
  pLinhas.Clear;
  DBConnection.Abrir;
  try
    try
      if pCaixaSessao.Id < 1 then
        exit;

      sL := pCaixaSessao.LojaId.ToString;
      sT := pCaixaSessao.TerminalId.ToString;
      sI := pCaixaSessao.Id.ToString;

      sSql := //
        'SELECT'#13#10 //
        + 'LINHA'#13#10 //
        + 'FROM CAIXA_SESSAO_PDV_PA.SESS_RELAT_BYID_GET('#13#10 //

        + sL + ' -- SESS_LOJA_ID'#13#10 //
        + ', ' + sT + ' -- SESS_TERMINAL_ID'#13#10 + ', ' + sI +
        ' -- SESS_ID'#13#10 //

        + ');';

//       {$IFDEF DEBUG}
//       CopyTextToClipboard(sSql);
//       {$ENDIF}

      oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
        sSql, nil, nil);

      oDBQuery.Abrir;
      q := oDBQuery.DataSet;
      while not q.Eof do
      begin
        sLinha := q.Fields[0].AsString.Trim;
        pLinhas.Add(sLinha);
        q.Next;
      end;
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

end.
