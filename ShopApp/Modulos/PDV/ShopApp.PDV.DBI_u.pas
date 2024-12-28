unit ShopApp.PDV.DBI_u;

interface

uses ShopApp.PDV.DBI, App.PDV.DBI_u, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem,
  Sis.DB.DBTypes, App.AppObj, Sis.Entities.Terminal, Sis.Types.Floats,
  ShopApp.PDV.Factory_u;

type
  TShopAppPDVDBI = class(TAppPDVDBI, IShopAppPDVDBI)
  private
    FShopPdvVenda: IShopPdvVenda;

  public
    function ItemCreatePelaStrBusca(pStrBusca: string; out pEncontrou: Boolean;
      out pMensagem: string): IShopPDVVendaItem;

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pTerminal: ITerminal; pShopPdvVenda: IShopPdvVenda);
  end;

implementation

uses Sis.Win.Utils_u, System.SysUtils, Sis.Entities.Types, Data.DB,
  App.Est.Prod, App.Est.Factory_u, Sis.Sis.Constants;

{ TShopAppPDVDBI }

constructor TShopAppPDVDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pTerminal: ITerminal; pShopPdvVenda: IShopPdvVenda);
begin
  FShopPdvVenda := pShopPdvVenda;
  inherited Create(pDBConnection, pAppObj, pTerminal, pShopPdvVenda);
end;

function TShopAppPDVDBI.ItemCreatePelaStrBusca(pStrBusca: string;
  out pEncontrou: Boolean; out pMensagem: string): IShopPDVVendaItem;
var
  sSql: string;
  aElementos: TArray<string>;
  iQtdElementos: integer;
  uQtd: Currency;
  sBusca: string;
  q: TDataSet;
  oProd: IProd;
begin
  Result := nil;

  aElementos := pStrBusca.Split(['*']);
  iQtdElementos := Length(aElementos);

  if iQtdElementos > 1 then
  begin
    uQtd := StrToCurrency(aElementos[0]);
    sBusca := aElementos[1];
  end
  else
  begin
    uQtd := 1;
    sBusca := aElementos[0];
  end;

  sSql := //
    'SELECT'#13#10 //

    + 'EST_MOV_ID_RET'#13#10 // 0
    + ', VENDA_ID_RET'#13#10 // 1

    + ', DTH_DOC_RET'#13#10 // 2
    + ', EST_MOV_CRIADO_EM_RET'#13#10 // 3
    + ', ORDEM_RET'#13#10 // 4
    + ', EST_MOV_ITEM_CRIADO_EM_RET'#13#10 // 5

    + ', PROD_ID'#13#10 // 6
    + ', DESCR_RED'#13#10 // 7

    + ', FABR_NOME'#13#10 // 8
    + ', UNID_SIGLA'#13#10 // 9

    + ', BAL_USO'#13#10 // 10

    + ', CUSTO_UNIT'#13#10 // 11
    + ', CUSTO'#13#10 // 12
    + ', PRECO_UNIT_ORIGINAL'#13#10 // 13
    + ', PRECO_UNIT_PROMO'#13#10 // 14
    + ', PRECO_UNIT'#13#10 // 15
    + ', PRECO_BRUTO'#13#10 // 16

    + ', ENCONTRADO'#13#10 // 17
    + ', MENSAGEM'#13#10 // 18

    + 'FROM VENDA_PDV_INS_PA.ITEM_BUSQUE'#13#10 //

    + '('#13#10 //
    + '  ' + AppObj.Loja.id.ToString + ' -- LOJA_ID'#13#10 //
    + ', ' + Terminal.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //

    + ', ' + PDVVenda.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + ', ' + PDVVenda.VendaId.ToString + ' -- VENDA_ID'#13#10 //

    + ', ' + PDVVenda.CaixaSessao.LojaId.ToString + ' -- SESS_LOJA_ID'#13#10 //
    + ', ' + PDVVenda.CaixaSessao.TerminalId.ToString +
    ' -- SESS_TERMINAL_ID'#13#10 //
    + ', ' + PDVVenda.CaixaSessao.id.ToString + ' -- SESS_ID'#13#10 //

    + ', ' + CurrencyToStrPonto(uQtd) + ' -- QTD'#13#10 //
    + ', ' + QuotedStr(sBusca) + ' -- STR_BUSCA'#13#10 //

    + ');';

//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
  DBConnection.QueryDataSet(sSql, q);

  pEncontrou := Assigned(q);
  if not pEncontrou then
  begin
    pMensagem := 'ERRO BUSCANDO ITEM';
    exit;
  end;

  pEncontrou := q.Fields[17 {ENCONTRADO}].AsBoolean;

  if not pEncontrou then
  begin
    pMensagem := q.Fields[18 {MENSAGEM}].AsString;
    exit;
  end;

  if FShopPdvVenda.VendaId = 0 then
  begin
    FShopPdvVenda.EstMovId := q.Fields[0 { EST_MOV_ID_RET } ].AsLargeInt;
    FShopPdvVenda.VendaId := q.Fields[1 { VENDA_ID_RET } ].AsInteger;
    FShopPdvVenda.DtHDoc := q.Fields[2 { DTH_DOC_RET } ].AsDateTime;
    FShopPdvVenda.CriadoEm := q.Fields[3 { EST_MOV_CRIADO_EM_RET } ].AsDateTime;
  end;

  oProd := ProdCreate( //
    q.Fields[6 { PROD_ID } ].AsInteger //
    , q.Fields[7 { DESCR_RED } ].AsString //
    , q.Fields[8 { FABR_NOME } ].AsString
    , q.Fields[9 { UNID_SIGLA } ].AsString
    );

  Result := ShopPDVVendaItemCreate( //
    q.Fields[4 { ORDEM_RET } ].AsInteger
    , oProd //
    , uQtd    //

    , q.Fields[10 { BAL_USO } ].AsInteger//

    , q.Fields[11 { CUSTO_UNIT } ].AsCurrency//
    , q.Fields[12 { CUSTO } ].AsCurrency//

    , q.Fields[13 { PRECO_UNIT_ORIGINAL } ].AsCurrency//
    , q.Fields[14 { PRECO_UNIT_PROMO } ].AsCurrency//
    , q.Fields[15 { PRECO_UNIT } ].AsCurrency
    , q.Fields[16 { PRECO_BRUTO } ].AsCurrency

    , 0 // desconto
    , q.Fields[16 { PRECO_BRUTO } ].AsCurrency // preco

    , False // pEstMovItemCancelado
    , DATA_ZERADA // pEstMovItemCriadoEm
    , DATA_ZERADA // pEstMovItemAlteradoEm
    , DATA_ZERADA // pEstMovItemCanceladoEm
    );
end;

end.
