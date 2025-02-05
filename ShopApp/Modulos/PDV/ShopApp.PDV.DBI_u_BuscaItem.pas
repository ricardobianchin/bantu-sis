unit ShopApp.PDV.DBI_u_BuscaItem;

interface

uses App.AppObj, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem, Sis.DB.DBTypes,
  Sis.Terminal, Sis.Entities.Types;

type
  TShopAppPDVDBI_BuscaItem = class
  private
    uQtd: Currency;
    sBusca: string;
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FShopPdvVenda: IShopPdvVenda;
    FDBConnection: IDBConnection;

    FBuscaQ: IDBQuery;
    FAddItemPesoQ: IDBQuery;

    bBuscaAberto: Boolean;

    procedure SepareQtdEBusca(pStrBusca: string);

    function GetSqlItemBusque: string;
    function GetSqlItemAddPeso: string;

    function BuscaQCreate: IDBQuery;
    function AddItemPesoQCreate: IDBQuery;
  public
    function ItemCreate(pStrBusca: string; out pEncontrou: Boolean;
      out pMensagem: string): IShopPDVVendaItem;

    constructor Create(pAppObj: IAppObj; pTerminal: ITerminal;
      pShopPdvVenda: IShopPdvVenda; pDBConnection: IDBConnection);
  end;

implementation

uses Sis.DB.Factory, Sis.Types.Floats, System.SysUtils, Sis.Types;

{ TShopAppPDVDBI_BuscaItem }

function TShopAppPDVDBI_BuscaItem.AddItemPesoQCreate: IDBQuery;
var
  sSql: string;
begin
  sSql := GetSqlItemAddPeso;
  Result := DBQueryCreate('pdvdbibusca.additempeso.exec', FDBConnection, sSql,
    nil, nil);
end;

function TShopAppPDVDBI_BuscaItem.BuscaQCreate: IDBQuery;
var
  sSql: string;
begin
  sSql := GetSqlItemBusque;
  Result := DBQueryCreate('pdvdbibusca.prod.q', FDBConnection, sSql,
    nil, nil);
end;

constructor TShopAppPDVDBI_BuscaItem.Create(pAppObj: IAppObj;
  pTerminal: ITerminal; pShopPdvVenda: IShopPdvVenda;
  pDBConnection: IDBConnection);
begin
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FShopPdvVenda := pShopPdvVenda;
  FDBConnection := pDBConnection;
  FBuscaQ := BuscaQCreate;
  FAddItemPesoQ := AddItemPesoQCreate;
end;

procedure TShopAppPDVDBI_BuscaItem.SepareQtdEBusca(pStrBusca: string);
var
  iQtdElementos: integer;
  aElementos: TArray<string>;
begin
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
end;

function TShopAppPDVDBI_BuscaItem.GetSqlItemAddPeso: string;
var
  V: IShopPdvVenda;
  T: ITerminal;
  LojaId: TShortId;
begin
  V := FShopPdvVenda;
  T := FTerminal;
  LojaId := FAppObj.Loja.Id;

  Result := //
    'SELECT' //
    +'EST_MOV_ID_RET' // 0
    +', VENDA_ID_RET' //1
    +', DTH_DOC_RET' //2
    +', EST_MOV_CRIADO_EM_RET' //3
    +', ORDEM_RET' //4
    +', EST_MOV_ITEM_CRIADO_EM_RET' //5
    +', MENSAGEM' //6
    +', LOG_STR_RET' //7

    +'FROM ITEM_PEGUE' //
    +'(' //
    +':LOJA_ID' //0
    +', :TERMINAL_ID' //1
    +', :EST_MOV_ID' //2
    +', :VENDA_ID' //3
    +', :SESS_LOJA_ID' //4
    +', :SESS_TERMINAL_ID' //5
    +', :SESS_ID' //6
    +', :PROD_ID' //7
    +', :QTD' //8
    +', :CUSTO_UNIT' //9
    +', :CUSTO' //10
    +', :PRECO_UNIT_ORIGINAL' //11
    +', :PRECO_UNIT_PROMO' //12
    +', :PRECO_UNIT' //13
    +', :PRECO_BRUTO' //14
    +', :DESCONTO' //15
    +', :PRECO' //16
    +', :LOG_STR' //17
    +');';

{
    +'LOJA_ID ID_SHORT_DOM NOT NULL' //0
    +', TERMINAL_ID ID_SHORT_DOM NOT NULL' //1
    +', EST_MOV_ID BIGINT NOT NULL' //2
    +', VENDA_ID ID_DOM NOT NULL' //3
    +', SESS_LOJA_ID ID_SHORT_DOM NOT NULL' //4
    +', SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL' //5
    +', SESS_ID ID_DOM NOT NULL' //6
    +', PROD_ID ID_DOM NOT NULL' //7
    +', QTD QTD_DOM NOT NULL' //8
    +', CUSTO_UNIT NUMERIC(12, 4) NOT NULL' //9
    +', CUSTO CUSTO_DOM NOT NULL' //10
    +', PRECO_UNIT_ORIGINAL NUMERIC(12, 3) NOT NULL' //11
    +', PRECO_UNIT_PROMO NUMERIC(12, 3) NOT NULL' //12
    +', PRECO_UNIT NUMERIC(12, 3) NOT NULL' //13
    +', PRECO_BRUTO NUMERIC(12, 2) NOT NULL' //14
    +', DESCONTO NUMERIC(12, 2) NOT NULL' //15
    +', PRECO PRECO_DOM' //16
    +', LOG_STR VARCHAR(200)' //17

}

end;

function TShopAppPDVDBI_BuscaItem.GetSqlItemBusque: string;
var
  V: IShopPdvVenda;
  T: ITerminal;
  LojaId: TShortId;
begin
  V := FShopPdvVenda;
  T := FTerminal;
  LojaId := FAppObj.Loja.Id;

  Result := //
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

    + ', BALANCA_EXIGE'#13#10 // 10

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
    + '  :LOJA_ID'#13#10 // 0
    + ', :TERMINAL_ID'#13#10 // 1

    + ', :EST_MOV_ID'#13#10 // 2
    + ', :VENDA_ID'#13#10 // 3

    + ', :SESS_LOJA_ID'#13#10 // 4
    + ', :SESS_TERMINAL_ID'#13#10 // 5
    + ', :SESS_ID'#13#10 // 6

    + ', :QTD'#13#10 // 7
    + ', :STR_BUSCA'#13#10 // 8

    + ');';


{
    + '  '0 + LojaId.ToString + ' -- LOJA_ID'#13#10 //
    + ', '1 + T.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //

    + ', '2 + V.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + ', '3 + V.VendaId.ToString + ' -- VENDA_ID'#13#10 //

    + ', '4 + V.CaixaSessao.LojaId.ToString + ' -- SESS_LOJA_ID'#13#10 //
    + ', '5 + V.CaixaSessao.TerminalId.ToString + ' -- SESS_TERMINAL_ID'#13#10 //
    + ', '6 + V.CaixaSessao.Id.ToString + ' -- SESS_ID'#13#10 //

    + ', '7 + CurrencyToStrPonto(uQtd) + ' -- QTD'#13#10 //
    + ', '8 + QuotedStr(sBusca) + ' -- STR_BUSCA'#13#10 //
}

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

end;

function TShopAppPDVDBI_BuscaItem.ItemCreate(pStrBusca: string;
  out pEncontrou: Boolean; out pMensagem: string): IShopPDVVendaItem;
begin
  Result := nil;
  SepareQtdEBusca(pStrBusca);
end;

end.
