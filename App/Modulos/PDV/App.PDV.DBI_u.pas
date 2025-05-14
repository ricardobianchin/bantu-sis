unit App.PDV.DBI_u;

interface

uses Sis.DBI_u, App.PDV.DBI, App.AppObj, Sis.DB.DBTypes, Sis.Terminal,
  App.PDV.Venda, App.PDV.VendaPag, App.PDV.VendaPag_u, App.PDV.VendaPag.List_u,
  FireDAC.Comp.Client, Sis.Types, App.Est.EstMovItem;

type
  TAppPDVDBI = class(TDBI, IAppPDVDBI)
  private
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FPdvVenda: IPDVVenda;
    FUsuarioId: TId;
  protected
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property PDVVenda: IPDVVenda read FPdvVenda;

    procedure InsiraPagItens; virtual;
    procedure InsiraEstItens; virtual;
    property UsuarioId: TId read FUsuarioId;
  public
    procedure PagSomenteDinheiro;
    procedure PagInserir(PAGAMENTO_FORMA_ID: TId; VALOR_DEVIDO, VALOR_ENTREGUE,
      TROCO: Currency);

    procedure PagFormaPreencheDataSet(pFDMemTable: TFDMemTable);
    procedure PagCancelar(pOrdem: SmallInt);
    procedure VendaFinalize;

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pTerminal: ITerminal; pPdvVenda: IPDVVenda; pUsuarioId: TId); reintroduce;

    procedure EstMovCancele(out pCanceladoEm: TDateTime; out pErroDeu: boolean;
      out pErroMensagem: string);

    procedure EstMovItemCancele(pEstMovItem: IEstMovItem;  out pErroDeu: boolean;
      out pErroMensagem: string);
  end;

implementation

uses Data.DB, System.SysUtils, Sis.Entities.Types, App.PDV.Factory_u,
  Sis.DB.DataSet.Utils, Sis.Win.Utils_u, Sis.Types.Floats, Sis.UI.IO.Files;

{ TAppPDVDBI }

constructor TAppPDVDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pTerminal: ITerminal; pPdvVenda: IPDVVenda; pUsuarioId: TId);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FPdvVenda := pPdvVenda;
  FUsuarioId := pUsuarioId;
end;

procedure TAppPDVDBI.PagInserir(PAGAMENTO_FORMA_ID: TId;
  VALOR_DEVIDO, VALOR_ENTREGUE, TROCO: Currency);
var
  sSql: string;
  sMens: string;
  V: IPDVVenda;
begin
  V := FPdvVenda;

  if VALOR_ENTREGUE = 0 then
  begin
    VALOR_ENTREGUE := VALOR_DEVIDO;
    TROCO := 0;
  end;

  sSql := //
    'INSERT INTO VENDA_PAG('#13#10 //

    + '  LOJA_ID,'#13#10 //
    + '  TERMINAL_ID,'#13#10 //
    + '  EST_MOV_ID,'#13#10 //
    + '  ORDEM,'#13#10 //
    + '  PAGAMENTO_FORMA_ID,'#13#10 //
    + '  VALOR_DEVIDO,'#13#10 //
    + '  VALOR_ENTREGUE,'#13#10 //
    + '  TROCO,'#13#10 //
    + '  CANCELADO'#13#10 //

    + ') VALUES ('#13#10 //

    + '  ' + V.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + V.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + V.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + '  , ' + V.VendaPagList.GetProximaOrdem.ToString + ' -- ORDEM'#13#10 //
    + '  , ' + PAGAMENTO_FORMA_ID.ToString + #13#10 //
    + '  , ' + CurrencyToStrPonto(VALOR_DEVIDO) + #13#10 //
    + '  , ' + CurrencyToStrPonto(VALOR_ENTREGUE) + #13#10 //
    + '  , ' + CurrencyToStrPonto(TROCO) + #13#10 //
    + '  , FALSE'#13#10 //
    + ');';
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  ExecuteSQL(sSql, sMens);
end;

procedure TAppPDVDBI.PagCancelar(pOrdem: SmallInt);
var
  sSql: string;
  sMens: string;
  V: IPDVVenda;
  vValor: variant;
begin
  V := FPdvVenda;

  sSql := //
    'SELECT CANCELADO_EM'#13#10 //
    + 'FROM VENDA_PAG_INS_PA.CANCELE'#13#10 //
    + '('#13#10 //
    + '  ' + V.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + V.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + V.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + '  , ' + pOrdem.ToString + ' -- ORDEM'#13#10 //
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  vValor := GetValue(sSql, sMens);
end;

procedure TAppPDVDBI.PagFormaPreencheDataSet(pFDMemTable: TFDMemTable);
var
  sSql: string;
  q: TDataSet;
begin
  sSql := //
    'WITH TIPO AS'#13#10 //
    + '('#13#10 //
    + '  SELECT'#13#10 //
    + '    PAGAMENTO_FORMA_TIPO_ID,'#13#10 //
    + '    DESCR,DESCR_RED'#13#10 //
    + '  FROM PAGAMENTO_FORMA_TIPO'#13#10 //
    + '  WHERE ATIVO'#13#10 //
    + '), FORMA AS'#13#10 //
    + '('#13#10 //
    + '  SELECT'#13#10 //
    + '    PAGAMENTO_FORMA_ID,'#13#10 //
    + '    PAGAMENTO_FORMA_TIPO_ID,'#13#10 //
    + '    DESCR,'#13#10 //
    + '    VALOR_MINIMO,'#13#10 //
    + '    PROMOCAO_PERMITE,'#13#10 //
    + '    TEF_USA,'#13#10 //
    + '    AUTORIZACAO_EXIGE,'#13#10 //
    + '    PESSOA_EXIGE,'#13#10 //
    + '    CASE WHEN PAGAMENTO_FORMA_ID = 1 THEN TRUE ELSE FALSE END AS ACEITA_TROCO'#13#10
  //
    + '  FROM PAGAMENTO_FORMA'#13#10 //
    + '  WHERE ATIVO AND PARA_VENDA'#13#10 //
    + ')'#13#10 //
    + 'SELECT'#13#10 //

    + '  FORMA.PAGAMENTO_FORMA_ID,'#13#10 // 0
    + '  FORMA.PAGAMENTO_FORMA_TIPO_ID,'#13#10 // 1
    + '  TIPO.DESCR_RED AS TIPO_DESCR_RED,'#13#10 // 2
    + '  FORMA.DESCR AS FORMA_DESCR,'#13#10 // 3
    + '  FORMA.VALOR_MINIMO,'#13#10 // 4
    + '  FORMA.PROMOCAO_PERMITE,'#13#10 // 5
    + '  FORMA.TEF_USA,'#13#10 // 6
    + '  FORMA.AUTORIZACAO_EXIGE,'#13#10 // 7
    + '  FORMA.PESSOA_EXIGE,'#13#10 // 8
    + '  FORMA.ACEITA_TROCO'#13#10 // 9

    + 'FROM'#13#10 //
    + '  TIPO'#13#10 //
    + 'JOIN'#13#10 //
    + '  FORMA ON'#13#10 //
    + '  TIPO.PAGAMENTO_FORMA_TIPO_ID = FORMA.PAGAMENTO_FORMA_TIPO_ID'#13#10 //
    + 'ORDER BY'#13#10 //
    + '  FORMA.PAGAMENTO_FORMA_TIPO_ID,FORMA_DESCR;';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  DBConnection.QueryDataSet(sSql, q);
  FDMemTableAppendDataSet(q, pFDMemTable);
end;

procedure TAppPDVDBI.PagSomenteDinheiro;
var
  sSql: string;
  V: IPDVVenda;
  q: TDataSet;
begin
  V := FPdvVenda;

  sSql := //
    'SELECT'#13#10 //

    + 'FINALIZADO_EM_RET'#13#10 //
    + ', DESCONTO_TOTAL_RET'#13#10 //
    + ', CUSTO_TOTAL_RET'#13#10 //
    + ', TOTAL_LIQUIDO_RET'#13#10 //

    + 'FROM VENDA_PAG_INS_PA.FINALIZE_SO_DIN'#13#10 //

    + '('#13#10 //
    + '  ' + V.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + V.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + V.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
  finally
    DBConnection.Fechar;
  end;
end;

procedure TAppPDVDBI.VendaFinalize; //
var
  sSql: string;
  V: IPDVVenda;
  q: TDataSet;
  sMachId: string;
begin
  V := FPdvVenda;
  sMachId := AppObj.SisConfig.LocalMachineId.IdentId.ToString;

  sSql := //
    'SELECT'#13#10 //

    + 'FINALIZADO_EM_RET'#13#10 //
    + ', DESCONTO_TOTAL_RET'#13#10 //
    + ', CUSTO_TOTAL_RET'#13#10 //
    + ', TOTAL_LIQUIDO_RET'#13#10 //

    + 'FROM VENDA_PDV_INS_PA.FINALIZE_E_TOTALIZE'#13#10 //

    + '('#13#10 //
    + '  ' + V.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + V.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + V.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //

    + '  , ' + FUsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
    + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
    + '  , ''#'' -- MODULO_SIS_ID'#13#10 //
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
  finally
    DBConnection.Fechar;
  end;
end;

procedure TAppPDVDBI.EstMovCancele(out pCanceladoEm: TDateTime;
  out pErroDeu: boolean; out pErroMensagem: string);
var
  sSql: string;
  V: IPDVVenda;
  q: TDataSet;
  sMachId: string;
begin
  V := FPdvVenda;
  sMachId := AppObj.SisConfig.LocalMachineId.IdentId.ToString;

  sSql := //
    'SELECT'#13#10 //

    + 'CANCELADO_EM'#13#10 //

    + 'FROM EST_MOV_MANUT_PA.EST_MOV_CANCELE'#13#10 //

    + '('#13#10 //
    + '  ' + V.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + V.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + V.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //

    + '  , ' + FUsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
    + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
    + '  , ''#'' -- MODULO_SIS_ID'#13#10 //

    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  pErroDeu := not DBConnection.Abrir;
  if pErroDeu then
  begin
    pErroMensagem := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSql, q);
    pCanceladoEm := q.Fields[0].AsDateTime;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TAppPDVDBI.EstMovItemCancele(pEstMovItem: IEstMovItem;
  out pErroDeu: boolean; out pErroMensagem: string);
var
  sSql: string;
  dCanceladoEm: TDateTime;
  V: IPDVVenda;
  q: TDataSet;
  sMachId: string;
begin
  V := FPdvVenda;
  sMachId := AppObj.SisConfig.LocalMachineId.IdentId.ToString;

  try
    sSql := //
      'SELECT CANCELADO_EM_RET'#13#10 //
      + 'FROM EST_MOV_MANUT_PA.EST_MOV_ITEM_CANCELE'#13#10 //
      + '('#13#10 //
      + '  ' + v.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
      + '  , ' + v.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
      + '  , ' + v.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
      + '  , ' + pEstMovItem.Ordem.ToString + ' -- ORDEM'#13#10 //
      + ');';

    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    pErroDeu := not DBConnection.Abrir;
    if pErroDeu then
    begin
      pErroMensagem := 'Erro ao tentar cancelar item. ' + DBConnection.UltimoErro;
      exit;
    end;

    try
      DBConnection.QueryDataSet(sSql, q);
      dCanceladoEm := q.Fields[0].AsDateTime;
    finally
      DBConnection.Fechar;
    end;

    try
      pEstMovItem.Cancelado := True;
      pEstMovItem.CanceladoEm := dCanceladoEm;
      pEstMovItem.AlteradoEm := dCanceladoEm;
      pEstMovItem.AlteradoEm := dCanceladoEm;
    finally
      DBConnection.Fechar;
    end;
  except
    on e: Exception do
    begin
      pErroDeu := True;
      pErroMensagem := 'Erro ao tentar cancelar item. ' + e.ClassName + ', ' +
        e.Message;
    end;
  end;
end;

procedure TAppPDVDBI.InsiraEstItens;
begin

end;

procedure TAppPDVDBI.InsiraPagItens;
var
  sSql: string;
  q: TDataSet;
  VendaPag: IVendaPag;
  sLog: string;
  sNomeArq: string;
begin
  sLog := '';
  try
    sSql := //
      'WITH TIPO AS'#13#10 //
      + '('#13#10 //
      + '  SELECT'#13#10 //
      + '  PAGAMENTO_FORMA_TIPO_ID ID'#13#10 //
      + '  , DESCR_RED'#13#10 //
      + '  FROM PAGAMENTO_FORMA_TIPO'#13#10 //
      + '), FORMA AS'#13#10 //
      + '('#13#10 //
      + '  SELECT'#13#10 //
      + '    PAGAMENTO_FORMA_ID ID'#13#10 //
      + '    , PAGAMENTO_FORMA_TIPO_ID TIPO_ID'#13#10 //
      + '    , DESCR'#13#10 //
      + '  FROM PAGAMENTO_FORMA'#13#10 //
      + '), PAG AS'#13#10 //
      + '('#13#10 //
      + '  SELECT'#13#10 //
      + '    ORDEM'#13#10 //
      + '    , PAGAMENTO_FORMA_ID FORMA_ID'#13#10 //
      + '    , VALOR_DEVIDO'#13#10 //
      + '    , VALOR_ENTREGUE'#13#10 //
      + '    , TROCO'#13#10 //
      + '    , CANCELADO'#13#10 //
      + '  FROM VENDA_PAG'#13#10 //
      + '  WHERE'#13#10 //
      + '    LOJA_ID = ' + FPdvVenda.Loja.Id.ToString + ' '#13#10 //
      + '    AND TERMINAL_ID = ' + FPdvVenda.TerminalId.ToString + ' '#13#10 //
      + '    AND EST_MOV_ID = ' + FPdvVenda.EstMovId.ToString + ' '#13#10 //
      + ')'#13#10 //
      + 'SELECT'#13#10 //
      + '  PAG.ORDEM'#13#10 // 0
      + '  , FORMA.ID'#13#10 // 1
      + '  , TIPO.ID'#13#10 // 2
      + '  , TIPO.DESCR_RED'#13#10 // 3
      + '  , FORMA.DESCR'#13#10 // 4
      + '  , PAG.VALOR_DEVIDO'#13#10 // 5
      + '  , PAG.VALOR_ENTREGUE'#13#10 // 6
      + '  , PAG.TROCO'#13#10 // 7
      + '  , PAG.CANCELADO'#13#10 // 8
      + 'FROM TIPO'#13#10 //
      + 'JOIN FORMA ON'#13#10 //
      + 'TIPO.ID = FORMA.TIPO_ID'#13#10 //
      + 'JOIN PAG ON'#13#10 //
      + 'FORMA.ID = PAG.FORMA_ID'#13#10 //
      + 'ORDER BY PAG.ORDEM;';

    sLog := sLog + sSql + #13#10#13#10;

    DBConnection.Abrir;
    try
      try
        DBConnection.QueryDataSet(sSql, q);
      except
        on e: Exception do
          sLog := sLog + e.Message + #13#10#13#10;
      end;
      FPdvVenda.VendaPagList.Clear;
      sLog := sLog + q.Fields[0 { 'ORDEM' } ].FieldName + ';' + //
        q.Fields[1 { 'FORMA.ID' } ].FieldName + ';' + //
        q.Fields[2 { 'TIPO.ID' } ].FieldName + ';' + //
        q.Fields[3 { 'TIPO.DESCR_RED' } ].FieldName + ';' + //
        q.Fields[4 { 'FORMA.DESCR' } ].FieldName + ';' + //
        q.Fields[5 { 'PAG.VALOR_DEVIDO' } ].FieldName + ';' + //
        q.Fields[6 { 'PAG.VALOR_ENTREGUE' } ].FieldName + ';' + //
        q.Fields[7 { 'PAG.TROCO' } ].FieldName + ';' + //
        q.Fields[8 { 'PAG.CANCELADO' } ].FieldName //
        + #13#10;
      while not q.Eof do
      begin
        sLog := sLog + q.Fields[0 { 'ORDEM' } ].AsString + ';' + //
          q.Fields[1 { 'FORMA.ID' } ].AsString + ';' + //
          q.Fields[2 { 'TIPO.ID' } ].AsString + ';' + //
          q.Fields[3 { 'TIPO.DESCR_RED' } ].AsString + ';' + //
          q.Fields[4 { 'FORMA.DESCR' } ].AsString + ';' + //
          q.Fields[5 { 'PAG.VALOR_DEVIDO' } ].AsString + ';' + //
          q.Fields[6 { 'PAG.VALOR_ENTREGUE' } ].AsString + ';' + //
          q.Fields[7 { 'PAG.TROCO' } ].AsString + ';' + //
          q.Fields[8 { 'PAG.CANCELADO' } ].AsString //
          + #13#10;

        VendaPag := VendaPagCreate( //
          q.Fields[0 { 'ORDEM' } ].AsInteger, //
          q.Fields[1 { 'FORMA.ID' } ].AsInteger, //
          q.Fields[2 { 'TIPO.ID' } ].AsString, //
          q.Fields[3 { 'TIPO.DESCR_RED' } ].AsString, //
          q.Fields[4 { 'FORMA.DESCR' } ].AsString, //
          q.Fields[5 { 'PAG.VALOR_DEVIDO' } ].AsCurrency, //
          q.Fields[6 { 'PAG.VALOR_ENTREGUE' } ].AsCurrency, //
          q.Fields[7 { 'PAG.TROCO' } ].AsCurrency, //
          q.Fields[8 { 'PAG.CANCELADO' } ].AsBoolean //
          );

        FPdvVenda.VendaPagList.Add(VendaPag);
        q.Next;
      end;
    finally
      DBConnection.Fechar;
    end;
  finally
    sLog := sLog + 'Fim'#13#10;

    sNomeArq := AppObj.AppInfo.PastaTmp + 'PDV\DBI\';
    ForceDirectories(sNomeArq);

    sNomeArq := sNomeArq + 'TAppPDVDBI.InsiraPagItens.txt';
    EscreverArquivo(sLog, sNomeArq);
  end;
end;

end.
