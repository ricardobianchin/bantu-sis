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

    function PDVSessFormCarregarDataSetSql(pSessLojaIdStr, pSessTerminalIdStr,
      pSessIdStr: string; pValues: variant): string;

    procedure PDVSessFormCarregarCxOper(pDMemTableMaster,
      pDMemTablePag: TFDMemTable; pDBConnection: IDBConnection);

    procedure PDVSessFormCarregarVenda(pDMemTableMaster, pDMemTableItem,
      pDMemTablePag: TFDMemTable; pDBConnection: IDBConnection);

  public
    constructor Create(pDBConnection: IDBConnection; pLogUsuario: IUsuario;
      pLojaId: TLojaId; pTerminalId: TTerminalId; pMachineIdentId: smallint);
      reintroduce;

    function CaixaSessaoAbertoGet(var pCaixaSessaoRec: TCaixaSessaoRec)
      : Boolean;
    procedure PegDados(pCaixaSessao: ICaixaSessao);

    function CaixaSessaoPreencheComUltimo(pCaixaSessao: ICaixaSessao): Boolean;

    property Mensagem: string read GetMensagem;

    procedure PDVSessFormCarregarDataSet(pDMemTableMaster, pDMemTableItem,
      pDMemTablePag: TFDMemTable; pCaixaSessao: ICaixaSessao; pValues: variant;
      pCarregaDetail: Boolean = True);

    procedure PDVSessFormCarregarDataSetDetail(pDMemTableMaster, pDMemTableItem,
      pDMemTablePag: TFDMemTable; pDBConnection: IDBConnection = nil);

    procedure PreenchaCxSessRelatorio(pLinhas: TStrings;
      pCaixaSessao: ICaixaSessao);

    procedure PreencherPagamentoFormaFiltroSL(pSL: TStrings);
    procedure PreencherSessFiltroSL(pSL: TStrings);
  end;

implementation

uses Sis.Win.Utils_u, Sis.DB.Factory, Sis.Types.Dates, System.SysUtils,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.DB.DataSet.Utils,
  Sis.Types.Bool_u;

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
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}
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

function TCaixaSessaoDBI.CaixaSessaoPreencheComUltimo
  (pCaixaSessao: ICaixaSessao): Boolean;
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

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

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

procedure TCaixaSessaoDBI.PDVSessFormCarregarCxOper(pDMemTableMaster,
  pDMemTablePag: TFDMemTable; pDBConnection: IDBConnection);
var
  iSessLojaId: smallint;
  iSessTerminalId: smallint;
  iSessId: integer;
  iSessLogId: integer;
  iSessOrdem: integer;

  sSql: string;

  q: TDataSet;

  i: integer;

  T: TFDMemTable;

  s: string;
begin
  iSessLojaId := pDMemTableMaster.Fields[0].AsInteger;
  iSessTerminalId := pDMemTableMaster.Fields[1].AsInteger;
  iSessId := pDMemTableMaster.Fields[2].AsInteger;
  iSessLogId := pDMemTableMaster.Fields[3].AsInteger;
  iSessOrdem := pDMemTableMaster.Fields[4].AsInteger;

  sSql := 'SELECT'#13#10 //
    + '2 TIPO_REG'#13#10 //
    + ', OPVAL.OPER_ORDEM ORDEM'#13#10 //
    + ', (OPVAL.OPER_ORDEM + 1) ITEM'#13#10 //
    + ', OPVAL.PAGAMENTO_FORMA_ID ID'#13#10 //
    + ', CASE'#13#10 //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''!'' THEN FORMA.DESCR'#13#10 //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''"'' THEN FORMA.DESCR || '' '' || TIPO.DESCR_RED'#13#10
  //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''#'' THEN FORMA.DESCR || '' '' || TIPO.DESCR_RED'#13#10
  //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''$'' THEN TIPO.DESCR_RED || '' '' || FORMA.DESCR'#13#10
  //
    + '  END AS DESCR'#13#10 //
    + ''#13#10 //
    + ', OPVAL.VALOR FLOAT1'#13#10 //
    + ', OPVAL.VALOR FLOAT2'#13#10 //
    + ', 0 FLOAT3'#13#10 //
    + ', 0 FLOAT4'#13#10 //
    + ', FALSE CANCELADO'#13#10 //
    + ''#13#10 //
    + 'FROM CAIXA_SESSAO_OPERACAO_VALOR OPVAL'#13#10 //
    + ''#13#10 //
    + 'JOIN PAGAMENTO_FORMA FORMA ON'#13#10 //
    + 'OPVAL.PAGAMENTO_FORMA_ID = FORMA.PAGAMENTO_FORMA_ID'#13#10 //
    + ''#13#10 //
    + 'JOIN PAGAMENTO_FORMA_TIPO TIPO ON'#13#10 //
    + 'TIPO.PAGAMENTO_FORMA_TIPO_ID = FORMA.PAGAMENTO_FORMA_TIPO_ID'#13#10 //

    + 'WHERE'#13#10 //
    + '  OPVAL.LOJA_ID = ' + iSessLojaId.ToString + #13#10 //
    + '  AND OPVAL.TERMINAL_ID = ' + iSessTerminalId.ToString + #13#10 //
    + '  AND OPVAL.SESS_ID = ' + iSessId.ToString + #13#10 //
    + '  AND OPVAL.OPER_ORDEM = ' + iSessOrdem.ToString + #13#10 //
    + '  AND OPVAL.OPER_LOG_ID = ' + iSessLogId.ToString + #13#10 //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  pDMemTablePag.DisableControls;

  try
    pDMemTablePag.EmptyDataSet;

    pDBConnection.QueryDataSet(sSql, q);
    if not Assigned(q) then
      exit;

    try
      while not q.Eof do
      begin
        T := pDMemTablePag;
        T.Append;
        T.Fields[0 { ORDEM } ].AsInteger := q.Fields[1 { ORDEM } ].AsInteger;
        T.Fields[1 { PAGAMENTO_FORMA_ID } ].AsInteger := q.Fields[3 { ID } ]
          .AsInteger;
        T.Fields[2 { DESCR } ].AsString := q.Fields[4 { DESCR } ].AsString;
        T.Fields[3 { VALOR_DEVIDO } ].AsCurrency := q.Fields[5 { FLOAT1 } ]
          .AsCurrency;
        T.Fields[4 { VALOR_ENTREGUE } ].AsCurrency := q.Fields[6 { FLOAT2 } ]
          .AsCurrency;
        T.Fields[5 { TROCO } ].AsCurrency := q.Fields[7 { FLOAT3 } ].AsCurrency;
        T.Fields[6 { CANCELADO } ].AsBoolean := q.Fields[9 { CANCELADO } ]
          .AsBoolean;
        T.Post;

        q.Next;
      end;
    finally
      q.Free;
    end;
  finally
    pDMemTablePag.First;
    pDMemTablePag.EnableControls;
  end;
end;

procedure TCaixaSessaoDBI.PDVSessFormCarregarDataSet(pDMemTableMaster,
  pDMemTableItem, pDMemTablePag: TFDMemTable; pCaixaSessao: ICaixaSessao;
  pValues: variant; pCarregaDetail: Boolean);
var
  bExibeVendas: Boolean;
  bExibeCxOper: Boolean;
  oDBQuery: IDBQuery;
  sSql: string;
  T: TFDMemTable;
  q: TDataSet;
  s, sLojaId, sTermId, sSessId: string;
  iSessId: integer;
begin
  T := pDMemTableMaster;

  T.DisableControls;
  T.EmptyDataSet;
  try
    bExibeCxOper := pValues[0];
    bExibeVendas := pValues[1];

    if (not bExibeVendas) and (not bExibeCxOper) then
      exit;

    DBConnection.Abrir;
    try
      sLojaId := pCaixaSessao.LojaId.ToString;
      sTermId := pCaixaSessao.TerminalId.ToString;
      iSessId := pCaixaSessao.Id;
      sSessId := iSessId.ToString;

      sSql := PDVSessFormCarregarDataSetSql(sLojaId, sTermId, sSessId, pValues);

      oDBQuery := DBQueryCreate('CxOperaca.tela.lista.get.q', DBConnection,
        sSql, nil, nil);

      T.Indexes.Clear;
      T.BeginBatch;
      try
        if iSessId < 1 then
          exit;

        oDBQuery.Abrir;
        q := oDBQuery.DataSet;
        while not q.Eof do
        begin
          T.Append;
          T.FieldByName('LOJA_ID').AsInteger := q.FieldByName('LOJA_ID')
            .AsInteger;
          T.FieldByName('TERMINAL_ID').AsInteger := q.FieldByName('TERMINAL_ID')
            .AsInteger;
          T.FieldByName('ID').AsInteger := q.FieldByName('ID').AsInteger;
          T.FieldByName('LOG_ID').AsLargeInt := q.FieldByName('LOG_ID')
            .AsLargeInt;
          T.FieldByName('ORDEM').AsInteger := q.FieldByName('ORDEM').AsInteger;
          T.FieldByName('TIPO_ID').AsString := q.FieldByName('TIPO_ID')
            .AsString;
          T.FieldByName('TIPO_STR').AsString :=
            q.FieldByName('TIPO_STR').AsString;
          T.FieldByName('CRIADO_EM').AsDateTime := //
            q.FieldByName('CRIADO_EM').AsDateTime;
          T.FieldByName('VALOR').AsCurrency := q.FieldByName('VALOR')
            .AsCurrency;

          T.FieldByName('FINALIZADO').AsBoolean := q.FieldByName('FINALIZADO')
            .AsBoolean;
          T.FieldByName('CANCELADO').AsBoolean := q.FieldByName('CANCELADO')
            .AsBoolean;

          if T.FieldByName('FINALIZADO').AsBoolean then
          begin
            s := q.FieldByName('FINALIZADO_EM').AsString;

            T.FieldByName('FINALIZADO_EM').AsDateTime := //
              TimeStampStrToDateTime(s);
          end;

          if T.FieldByName('CANCELADO').AsBoolean then
          begin
            s := q.FieldByName('CANCELADO_EM').AsString;
            T.FieldByName('CANCELADO_EM').AsDateTime := //
              TimeStampStrToDateTime(s);
          end;

          T.FieldByName('OBS').AsString := q.FieldByName('OBS').AsString;

          if T.FieldByName('TIPO_ID').AsString = cxopVenda.ToChar then
            T.FieldByName('COD_STR').AsString :=
              Sis.Entities.Types.GetCod(T.FieldByName('LOJA_ID').AsInteger,
              T.FieldByName('TERMINAL_ID').AsInteger,
              T.FieldByName('ID').AsInteger, 'VEN')
          else
            T.FieldByName('COD_STR').AsString :=
              Sis.Entities.Types.GetCod(T.FieldByName('LOJA_ID').AsInteger,
              T.FieldByName('TERMINAL_ID').AsInteger,
              T.FieldByName('ID').AsInteger, 'CX') + '-' +
              T.FieldByName('ORDEM').AsInteger.ToString;

          T.Post;
          oDBQuery.DataSet.Next;
        end;
      finally
        oDBQuery.Fechar;

        T.EndBatch;
        with T.Indexes.Add do
        begin
          Name := 'IdxCriadoEm';
          Fields := 'CRIADO_EM';
          Active := True;
        end;

        T.IndexesActive := True;
        T.IndexName := 'IdxCriadoEm';

      end;

      if not pCarregaDetail then
        exit;

      PDVSessFormCarregarDataSetDetail(pDMemTableMaster, pDMemTableItem,
        pDMemTablePag, DBConnection);
    finally
      DBConnection.Fechar;
    end;
  finally
    T.First;
    T.EnableControls;
  end;
end;

procedure TCaixaSessaoDBI.PDVSessFormCarregarDataSetDetail(pDMemTableMaster,
  pDMemTableItem, pDMemTablePag: TFDMemTable; pDBConnection: IDBConnection);
var
  bPrecisouConectar: Boolean;
  eCxOpTipo: TCxOpTipo;
begin
  bPrecisouConectar := pDBConnection = nil;

  if bPrecisouConectar then
  begin
    pDBConnection := DBConnection;
    pDBConnection.Abrir;
  end;

  try
    pDMemTableItem.EmptyDataSet;
    pDMemTablePag.EmptyDataSet;

    eCxOpTipo.FromString(pDMemTableMaster.Fields[6].AsString);

    if eCxOpTipo = TCxOpTipo.cxopVenda then
    begin
      PDVSessFormCarregarVenda(pDMemTableMaster, pDMemTableItem, pDMemTablePag,
        pDBConnection);
      exit;
    end;

    PDVSessFormCarregarCxOper(pDMemTableMaster, pDMemTablePag, pDBConnection);
  finally
    if bPrecisouConectar then
    begin
      pDBConnection.Abrir;
    end;
  end;
end;

function TCaixaSessaoDBI.PDVSessFormCarregarDataSetSql(pSessLojaIdStr,
  pSessTerminalIdStr, pSessIdStr: string; pValues: variant): string;
var
  bExibeVendas: Boolean;
  bExibeCxOper: Boolean;
  iPagFormaId: integer;
  iProdId: integer;
  // sLojaId, sTermId, sSessId: string;
begin
  Result := '';

  bExibeCxOper := pValues[0];
  bExibeVendas := pValues[1];
  iPagFormaId := pValues[2];
  iProdId := pValues[3];

  Result := Result //
    + 'WITH T AS'#13#10 //
    + '('#13#10 //
    + '  SELECT OPER_TIPO_ID, NAME'#13#10 //
    + '  FROM CAIXA_SESSAO_OPERACAO_TIPO'#13#10 //
    + '), DT AS'#13#10 //
    + '('#13#10 //
    + '  SELECT DESPESA_TIPO_ID, DESCR'#13#10 //
    + '  FROM DESPESA_TIPO'#13#10 //
    + '), O AS'#13#10 //
    + '('#13#10 //
  // CXOPER
    + '  SELECT COP.LOJA_ID, COP.TERMINAL_ID, COP.SESS_ID,'#13#10 //
    + '    COP.OPER_ORDEM, COP.OPER_LOG_ID, COP.OPER_TIPO_ID,'#13#10 //
    + '    COP.VALOR, COP.OBS, COP.CANCELADO'#13#10 //

    + '  FROM CAIXA_SESSAO_OPERACAO COP'#13#10 //
    ;
  if iPagFormaId > 0 then
  begin
    Result := Result //
      + '  JOIN CAIXA_SESSAO_OPERACAO_VALOR CVAL ON'#13#10 //
      + '  COP.LOJA_ID = CVAL.LOJA_ID'#13#10 //
      + '  AND COP.TERMINAL_ID = CVAL.TERMINAL_ID'#13#10 //
      + '  AND COP.SESS_ID = CVAL.SESS_ID'#13#10 //
      + '  AND COP.OPER_ORDEM = CVAL.OPER_ORDEM'#13#10 //
      + '  AND COP.OPER_LOG_ID = CVAL.OPER_LOG_ID'#13#10 //
      + '  AND CVAL.PAGAMENTO_FORMA_ID = ' + iPagFormaId.ToString + #13#10 //
      ;
  end;

  Result := Result //
    + '  WHERE COP.LOJA_ID = ' + pSessLojaIdStr + #13#10 //
    + '  AND COP.TERMINAL_ID = ' + pSessTerminalIdStr + #13#10 //
    + '  AND COP.SESS_ID = ' + pSessIdStr + #13#10 //
    + '  AND ' + BooleanToStrSQL(bExibeCxOper) + #13#10 //

    + '), L AS'#13#10 //
    + '('#13#10 //
    + '  SELECT LOJA_ID, TERMINAL_ID, LOG_ID, DTH'#13#10 //
    + '  FROM LOG'#13#10 //
    + '), D AS'#13#10 //
    + '('#13#10 //
    + '  SELECT LOJA_ID, TERMINAL_ID, SESS_ID, OPER_ORDEM,'#13#10 //
    + '    OPER_LOG_ID, DESPESA_TIPO_ID, FORNEC_NOME, NUMDOC'#13#10 //
    + '  FROM CAIXA_SESSAO_OPERACAO_DESPESA'#13#10 //
    + ')'#13#10 //
    + ', E AS'#13#10 //
    + '('#13#10 //
  // EST_MOV
    + '  SELECT EM.LOJA_ID, EM.TERMINAL_ID, EM.EST_MOV_ID,'#13#10 //
    + '    EM.CRIADO_EM, EM.CANCELADO, EM.CANCELADO_EM, EM.FINALIZADO,'#13#10 //
    + '    EM.FINALIZADO_EM'#13#10 //
    + '  FROM EST_MOV EM'#13#10 //
    ;

  if iProdId > 0 then
  begin
    Result := Result + '  JOIN EST_MOV_ITEM EMI ON'#13#10 //
      + '  EM.LOJA_ID = EMI.LOJA_ID'#13#10 //
      + '  AND EM.TERMINAL_ID = EMI.TERMINAL_ID'#13#10 //
      + '  AND EM.EST_MOV_ID = EMI.EST_MOV_ID'#13#10 //

      + '  AND EMI.PROD_ID = ' + iProdId.ToString + #13#10 //
  end;

  Result := Result + '' + '), V AS'#13#10 //
    + '('#13#10 //
    + '  SELECT VE.LOJA_ID, VE.TERMINAL_ID, VE.EST_MOV_ID,'#13#10 //
    + '    VE.VENDA_ID, VE.TOTAL_LIQUIDO'#13#10 //

    + '  FROM VENDA VE'#13#10 //
    ;

  if iPagFormaId > 0 then
  begin
    Result := Result //
      + '  JOIN VENDA_PAG VEP ON'#13#10 //
      + '  VE.LOJA_ID = VEP.LOJA_ID'#13#10 //
      + '  AND VE.TERMINAL_ID = VEP.TERMINAL_ID'#13#10 //
      + '  AND VE.EST_MOV_ID = VEP.EST_MOV_ID'#13#10 //

      + '  AND VEP.PAGAMENTO_FORMA_ID = ' + iPagFormaId.ToString + #13#10 //
  end;

  Result := Result //
    + '  WHERE VE.SESS_LOJA_ID = ' + pSessLojaIdStr + #13#10 //
    + '  AND VE.SESS_TERMINAL_ID = ' + pSessTerminalIdStr + #13#10 //
    + '  AND VE.SESS_ID = ' + pSessIdStr + #13#10 //
    + '  AND ' + BooleanToStrSQL(bExibeVendas) + #13#10 //

    + ')'#13#10 //
    + 'SELECT'#13#10 //
    + '  E.LOJA_ID'#13#10 //
    + '  , E.TERMINAL_ID'#13#10 //
    + '  , E.EST_MOV_ID ID'#13#10 //
    + '  , -1 AS LOG_ID'#13#10 //
    + '  , 0 AS ORDEM'#13#10 //
    + '  , ''*'' AS TIPO_ID'#13#10 //
    + '  , ''VENDA'' AS TIPO_STR'#13#10 //
    + '  , E.CRIADO_EM'#13#10 //
    + '  , V.TOTAL_LIQUIDO AS VALOR'#13#10 //
    + '  , E.FINALIZADO'#13#10 //
    + '  , E.CANCELADO'#13#10 //
    + '  , E.FINALIZADO_EM'#13#10 //
    + '  , E.CANCELADO_EM'#13#10 //
    + '  , '''' AS OBS'#13#10 //

    + 'FROM E'#13#10 //

    + 'JOIN V'#13#10 //
    + '  ON E.LOJA_ID = V.LOJA_ID'#13#10 //
    + '  AND E.TERMINAL_ID = V.TERMINAL_ID'#13#10 //
    + '  AND E.EST_MOV_ID = V.EST_MOV_ID'#13#10 //

    + 'UNION'#13#10 //

    + 'SELECT'#13#10 //
    + '  O.LOJA_ID'#13#10 //
    + '  , O.TERMINAL_ID'#13#10 //
    + '  , O.SESS_ID AS ID'#13#10 //
    + '  , O.OPER_LOG_ID AS LOG_ID'#13#10 //
    + '  , O.OPER_ORDEM AS ORDEM'#13#10 //
    + '  , O.OPER_TIPO_ID AS TIPO_ID'#13#10 //
    + '  , T.NAME AS TIPO_STR'#13#10 //
    + '  , L.DTH AS CRIADO_EM'#13#10 //
    + '  , O.VALOR'#13#10 //
    + '  , TRUE FINALIZADO'#13#10 //
    + '  , O.CANCELADO'#13#10 //
    + '  , L.DTH AS FINALIZADO_EM'#13#10 //
    + '  , ''01.01.1900'' AS CANCELADO_EM'#13#10 //
    + '  , TRIM(O.OBS || '' '' || DT.DESCR || '' '' || D.FORNEC_NOME' //
    + ' || '' '' || D.NUMDOC) OBS'#13#10 //
    + 'FROM T'#13#10 //
    + 'JOIN O'#13#10 //
    + '  ON T.OPER_TIPO_ID = O.OPER_TIPO_ID'#13#10 //
    + 'JOIN L'#13#10 //
    + '  ON O.LOJA_ID = L.LOJA_ID'#13#10 //
    + '  AND O.TERMINAL_ID = L.TERMINAL_ID'#13#10 //
    + '  AND O.OPER_LOG_ID = L.LOG_ID'#13#10 //
    + 'LEFT JOIN D ON'#13#10 //
    + '  O.LOJA_ID = D.LOJA_ID'#13#10 //
    + '  AND O.TERMINAL_ID = D.TERMINAL_ID'#13#10 //
    + '  AND O.SESS_ID = D.SESS_ID'#13#10 //
    + '  AND O.OPER_LOG_ID = D.OPER_LOG_ID'#13#10 //
    + 'LEFT JOIN DT ON'#13#10 //
    + '  D.DESPESA_TIPO_ID = DT.DESPESA_TIPO_ID'#13#10 //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure TCaixaSessaoDBI.PDVSessFormCarregarVenda(pDMemTableMaster,
  pDMemTableItem, pDMemTablePag: TFDMemTable; pDBConnection: IDBConnection);
var
  iEstMovLojaId: smallint;
  iEstMovTerminalId: smallint;
  iEstMovId: Int64;

  sSql: string;

  q: TDataSet;

  i: integer;

  T: TFDMemTable;

  s: string;
begin
  iEstMovLojaId := pDMemTableMaster.Fields[0].AsInteger;
  iEstMovTerminalId := pDMemTableMaster.Fields[1].AsInteger;
  iEstMovId := pDMemTableMaster.Fields[2].AsInteger;

  sSql := 'SELECT'#13#10 //
    + '1 TIPO_REG'#13#10 //
    + ', EI.ORDEM'#13#10 //
    + ', (EI.ORDEM + 1) ITEM'#13#10 //
    + ', EI.PROD_ID ID'#13#10 //
    + ', P.DESCR_RED DESCR'#13#10 //
    + ', EI.QTD FLOAT1'#13#10 //
    + ', VI.PRECO_UNIT FLOAT2'#13#10 //
    + ', VI.DESCONTO FLOAT3'#13#10 //
    + ', VI.PRECO FLOAT4'#13#10 //
    + ', EI.CANCELADO'#13#10 //

    + 'FROM EST_MOV_ITEM EI'#13#10 //

    + 'JOIN PROD P ON'#13#10 //
    + 'EI.PROD_ID = P.PROD_ID'#13#10 //

    + 'JOIN VENDA_ITEM VI ON'#13#10 //
    + '  EI.LOJA_ID = VI.LOJA_ID'#13#10 //
    + '  AND EI.TERMINAL_ID = VI.TERMINAL_ID'#13#10 //
    + '  AND EI.EST_MOV_ID = VI.EST_MOV_ID'#13#10 //
    + '  AND EI.ORDEM = VI.ORDEM'#13#10 //

    + 'WHERE'#13#10 //
    + '  EI.LOJA_ID = ' + iEstMovLojaId.ToString + #13#10 //
    + '  AND EI.TERMINAL_ID = ' + iEstMovTerminalId.ToString + #13#10 //
    + '  AND EI.EST_MOV_ID = ' + iEstMovId.ToString + #13#10 //

    + 'UNION'#13#10 //

    + 'SELECT'#13#10 //
    + '2 TIPO_REG'#13#10 //
    + ', VPAG.ORDEM'#13#10 //
    + ', (VPAG.ORDEM + 1) ITEM'#13#10 //
    + ', VPAG.PAGAMENTO_FORMA_ID ID'#13#10 //
    + ', CASE'#13#10 //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''!'' THEN FORMA.DESCR'#13#10 //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''"'' THEN FORMA.DESCR || '' '' || TIPO.DESCR_RED'#13#10
  //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''#'' THEN FORMA.DESCR || '' '' || TIPO.DESCR_RED'#13#10
  //
    + '    WHEN TIPO.PAGAMENTO_FORMA_TIPO_ID = ''$'' THEN TIPO.DESCR_RED || '' '' || FORMA.DESCR'#13#10
  //
    + '  END AS DESCR'#13#10 //
    + ', VPAG.VALOR_DEVIDO FLOAT1'#13#10 //
    + ', VPAG.VALOR_ENTREGUE FLOAT2'#13#10 //
    + ', VPAG.TROCO FLOAT3'#13#10 //
    + ', 0 FLOAT4'#13#10 //
    + ', VPAG.CANCELADO'#13#10 //

    + 'FROM VENDA_PAG VPAG'#13#10 //

    + 'JOIN PAGAMENTO_FORMA FORMA ON'#13#10 //
    + 'VPAG.PAGAMENTO_FORMA_ID = FORMA.PAGAMENTO_FORMA_ID'#13#10 //

    + 'JOIN PAGAMENTO_FORMA_TIPO TIPO ON'#13#10 //
    + 'TIPO.PAGAMENTO_FORMA_TIPO_ID = FORMA.PAGAMENTO_FORMA_TIPO_ID'#13#10 //

    + 'WHERE'#13#10 //
    + '  VPAG.LOJA_ID = ' + iEstMovLojaId.ToString + #13#10 //
    + '  AND VPAG.TERMINAL_ID = ' + iEstMovTerminalId.ToString + #13#10 //
    + '  AND VPAG.EST_MOV_ID = ' + iEstMovId.ToString + #13#10 //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  pDMemTableItem.DisableControls;
  pDMemTablePag.DisableControls;

  try

    pDMemTableItem.EmptyDataSet;
    pDMemTablePag.EmptyDataSet;

    pDBConnection.QueryDataSet(sSql, q);
    if not Assigned(q) then
      exit;

    try
      while not q.Eof do
      begin
        if q.Fields[0].AsInteger = 1 then
        begin
          T := pDMemTableItem;
          T.Append;
          T.Fields[0 { ORDEM } ].AsInteger := q.Fields[1 { ORDEM } ].AsInteger;
          T.Fields[1 { ITEM } ].AsInteger := q.Fields[2 { ITEM } ].AsInteger;
          T.Fields[2 { PROD_ID } ].AsInteger := q.Fields[3 { ID } ].AsInteger;
          T.Fields[3 { DESCR_RED } ].AsString := q.Fields[4 { DESCR } ]
            .AsString;
          T.Fields[4 { QTD } ].AsCurrency := q.Fields[5 { FLOAT1 } ].AsCurrency;
          T.Fields[5 { PRECO_UNIT } ].AsCurrency := q.Fields[6 { FLOAT2 } ]
            .AsCurrency;
          T.Fields[6 { DESCONTO } ].AsCurrency := q.Fields[7 { FLOAT3 } ]
            .AsCurrency;
          T.Fields[7 { PRECO } ].AsCurrency := q.Fields[8 { FLOAT4 } ]
            .AsCurrency;
          T.Fields[8 { CANCELADO } ].AsBoolean := q.Fields[9 { CANCELADO } ]
            .AsBoolean;
          T.Post;
        end
        else
        begin
          T := pDMemTablePag;
          T.Append;
          T.Fields[0 { ORDEM } ].AsInteger := q.Fields[1 { ORDEM } ].AsInteger;
          T.Fields[1 { PAGAMENTO_FORMA_ID } ].AsInteger := q.Fields[3 { ID } ]
            .AsInteger;
          T.Fields[2 { DESCR } ].AsString := q.Fields[4 { DESCR } ].AsString;
          T.Fields[3 { VALOR_DEVIDO } ].AsCurrency := q.Fields[5 { FLOAT1 } ]
            .AsCurrency;
          T.Fields[4 { VALOR_ENTREGUE } ].AsCurrency := q.Fields[6 { FLOAT2 } ]
            .AsCurrency;
          T.Fields[5 { TROCO } ].AsCurrency := q.Fields[7 { FLOAT3 } ]
            .AsCurrency;
          T.Fields[6 { CANCELADO } ].AsBoolean := q.Fields[9 { CANCELADO } ]
            .AsBoolean;
          T.Post;
        end;

        q.Next;
      end;
    finally
      q.Free;
    end;
  finally
    pDMemTableItem.First;
    pDMemTablePag.First;

    pDMemTableItem.EnableControls;
    pDMemTablePag.EnableControls;
  end;
end;

procedure TCaixaSessaoDBI.PegDados(pCaixaSessao: ICaixaSessao);
var
  sSql: string;
  q: TDataSet;
begin
  DBConnection.Abrir;

  try
    sSql := 'SELECT first(1)'#13#10 + 'SESS.SESS_ID'#13#10 // 0
      + ', PESS.PESSOA_ID'#13#10 // 1
      + ', PESS.APELIDO'#13#10 // 2
      + ', LOG.DTH ABERTO_EM'#13#10 // 3
      + ', sess.aberto'#13#10 // 4

      + 'FROM AMBIENTE_SIS AMBI'#13#10

      + 'JOIN CAIXA_SESSAO SESS ON'#13#10 + 'AMBI.LOJA_ID = SESS.LOJA_ID'#13#10
      + 'AND AMBI.TERMINAL_ID = SESS.TERMINAL_ID'#13#10

      + 'JOIN LOG ON'#13#10 + 'SESS.LOJA_ID = LOG.LOJA_ID'#13#10 +
      'AND SESS.TERMINAL_ID = LOG.TERMINAL_ID'#13#10 +
      'AND SESS.SESS_LOG_ID = LOG.LOG_ID'#13#10

      + 'JOIN PESSOA PESS ON'#13#10 + 'LOG.LOJA_ID = PESS.LOJA_ID'#13#10 +
      'AND LOG.PESSOA_TERMINAL_ID = PESS.TERMINAL_ID'#13#10 +
      'AND LOG.PESSOA_ID = PESS.PESSOA_ID'#13#10

      + 'order by log.dth desc'#13#10;
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}
    DBConnection.QueryDataSet(sSql, q);

    // Result := Assigned(q);
    // if not Result then
    // exit;
    try
      // Result := not q.IsEmpty;

      // if not Result then
      // exit;

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

procedure TCaixaSessaoDBI.PreencherPagamentoFormaFiltroSL(pSL: TStrings);
var
  oDBQuery: IDBQuery;
  sSql: string;
begin
  pSL.Clear;
  pSL.Add('<TODAS AS FORMAS>');
  DBConnection.Abrir;
  try
    sSql := //
      'SELECT FORMA_ID, DESCR'#13#10 //
      + 'FROM CAIXA_SESSAO_PDV_PA.FECH_TELA_PAGFORMA_LISTA_GET;' //
      ;

    oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
      sSql, nil, nil);

    oDBQuery.Abrir;
    try
      ListaSelectPreencher(oDBQuery.DataSet, pSL);
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TCaixaSessaoDBI.PreencherSessFiltroSL(pSL: TStrings);
var
  iId: integer;
  p: Pointer;
  sDescr: string;
  sNome: string;
  oDBQuery: IDBQuery;
  sSql: string;
  q: TDataSet;
  sIni, sFim: string;
begin
  pSL.Clear;
  DBConnection.Abrir;
  try
    sSql := //
      'SELECT'#13#10 + //
      'SESS_ID, OPER_APELIDO, ABERTO_EM, FECHADO_EM'#13#10 + //
      'FROM CAIXA_SESSAO_PDV_PA.SESS_TELA_LISTA_SELECT_GET('#13#10 + //
      FLojaId.ToString + ', '#13#10 + //
      FTerminalId.ToString + ');'#13#10 //
      ;

    oDBQuery := DBQueryCreate('CxSess.lista.select.get.q', DBConnection, sSql,
      nil, nil);

    oDBQuery.Abrir;
    try
      q := oDBQuery.DataSet;
      while not q.Eof do
      begin
        iId := q.Fields[0].AsInteger;

        if iId < 1 then
        begin
          pSL.Add('');
          continue;
        end;

        sNome := Trim(q.Fields[1].AsString);
        sIni := FormatDateTime('dd/mm/yy hh:nn', q.FieldByName('ABERTO_EM')
          .AsDateTime);

        if q.FieldByName('FECHADO_EM').IsNull then
          sFim := 'Não fechado'
        else
          sFim := FormatDateTime('dd/mm/yy hh:nn', q.FieldByName('FECHADO_EM')
            .AsDateTime);

        sDescr := GetCod(FLojaId, FTerminalId, iId, '') + ' ' + sNome + ' ' +
          sIni + ' - ' + sFim;

        p := Pointer(iId);
        pSL.AddObject(sDescr, p);

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
