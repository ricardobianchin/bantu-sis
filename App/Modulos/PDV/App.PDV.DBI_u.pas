unit App.PDV.DBI_u;

interface

uses Sis.DBI_u, App.PDV.DBI, App.AppObj, Sis.DB.DBTypes, Sis.Entities.Terminal,
  App.PDV.Venda, App.PDV.VendaPag, App.PDV.VendaPag_u, App.PDV.VendaPag.List_u,
  FireDAC.Comp.Client;

type
  TAppPDVDBI = class(TDBI, IAppPDVDBI)
  private
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FPdvVenda: IPDVVenda;
  protected
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property PDVVenda: IPDVVenda read FPdvVenda;
  public
    procedure PagSomenteDinheiro;
    procedure InsiraPagItens; virtual;
    procedure InsiraEstItens; virtual;
    procedure PagamentoFormaPreencheDataSet(pFDMemTable: TFDMemTable);

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pTerminal: ITerminal; pPdvVenda: IPDVVenda);
  end;

implementation

uses Data.DB, System.SysUtils, Sis.Entities.Types, App.PDV.Factory_u,
  Sis.DB.DataSet.Utils, Sis.Win.Utils_u;

{ TAppPDVDBI }

constructor TAppPDVDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pTerminal: ITerminal; pPdvVenda: IPDVVenda);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FPdvVenda := pPdvVenda;
end;

procedure TAppPDVDBI.PagamentoFormaPreencheDataSet(pFDMemTable: TFDMemTable);
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
    + '    PESSOA_EXIGE'#13#10 //
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
    + '  FORMA.PESSOA_EXIGE'#13#10 // 8

    + 'FROM'#13#10 //
    + '  TIPO'#13#10 //
    + 'JOIN'#13#10 //
    + '  FORMA ON'#13#10 //
    + '  TIPO.PAGAMENTO_FORMA_TIPO_ID = FORMA.PAGAMENTO_FORMA_TIPO_ID'#13#10 //
    + 'ORDER BY'#13#10 //
    + '  FORMA.PAGAMENTO_FORMA_TIPO_ID,FORMA_DESCR;';

//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
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

procedure TAppPDVDBI.InsiraEstItens;
begin

end;

procedure TAppPDVDBI.InsiraPagItens;
var
  sSql: string;
  q: TDataSet;
  VendaPag: IVendaPag;
begin
  sSql := //
    'SELECT'#13#10 //

    + '  ORDEM,'#13#10 // 0
    + '  PAGAMENTO_FORMA_ID,'#13#10 // 1
    + '  VALOR_DEVIDO,'#13#10 // 2
    + '  VALOR_ENTREGUE,'#13#10 // 3
    + '  TROCO,'#13#10 // 4
    + '  CANCELADO'#13#10 // 5

    + 'FROM VENDA_PAG '#13#10 //

    + 'WHERE LOJA_ID = ' + FPdvVenda.Loja.Id.ToString + ' '#13#10 //
    + 'AND TERMINAL_ID = ' + FPdvVenda.TerminalId.ToString + ' '#13#10 //
    + 'AND EST_MOV_ID = ' + FPdvVenda.EstMovId.ToString + ' '#13#10 //

    + 'ORDER BY ORDEM';

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    FPdvVenda.VendaPagList.Clear;
    while not q.Eof do
    begin
      VendaPag := VendaPagCreate(q.FieldByName('ORDEM').AsInteger,
        q.FieldByName('PAGAMENTO_FORMA_ID').AsLargeInt,
        q.FieldByName('VALOR_DEVIDO').AsCurrency,
        q.FieldByName('VALOR_ENTREGUE').AsCurrency, q.FieldByName('TROCO')
        .AsCurrency, q.FieldByName('CANCELADO').AsBoolean);
      FPdvVenda.VendaPagList.Add(VendaPag);
      q.Next;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

end.
