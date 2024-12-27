unit ShopApp.PDV.DBI_u;

interface

uses ShopApp.PDV.DBI, App.PDV.DBI_u, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem,
  Sis.DB.DBTypes, App.AppObj, Sis.Entities.Terminal, Sis.Types.Floats;

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

uses Sis.Win.Utils_u, System.SysUtils, Sis.Entities.Types;

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

    + 'EST_MOV_ID_RET'#13#10 //
    + ', ORDEM_RET'#13#10 //
    + ', VENDA_ID_RET'#13#10 //

    + ', DTH_DOC_RET'#13#10 //
    + ', EST_MOV_CRIADO_EM_RET'#13#10 //

    + ', PROD_ID'#13#10 //
    + ', DESCR_RED'#13#10 //

    + ', FABR_NOME'#13#10 //
    + ', UNID_SIGLA'#13#10 //

    + ', BAL_USO'#13#10 //

    + ', CUSTO_UNIT'#13#10 //
    + ', CUSTO'#13#10 //
    + ', PRECO_UNIT_ORIGINAL'#13#10 //
    + ', PRECO_UNIT_PROMO'#13#10 //
    + ', PRECO_UNIT'#13#10 //
    + ', PRECO'#13#10 //

    + ', ENCONTRADO'#13#10 //
    + ', MENSAGEM'#13#10 //

    + 'FROM VENDA_PDV_INS_PA.PEGUE_ITEM('#13#10 //

    + '('#13#10 //
    + '  ' + AppObj.Loja.id.ToString  + ' -- LOJA_ID'#13#10 //
    + ', ' +  Terminal.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + ', ' + PDVVenda.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + ', ' + PDVVenda.VendaId.ToString + ' -- VENDA_ID'#13#10 //
    + ', ' + PDVVenda.CaixaSessao.LojaId.ToString +' -- SESS_LOJA_ID'#13#10 //
    + ', ' + PDVVenda.CaixaSessao.TerminalId.ToString +' -- SESS_TERMINAL_ID'#13#10 //
    + ', ' + PDVVenda.CaixaSessao.Id.ToString +' -- SESS_ID'#13#10 //
    + ', ' + CurrencyToStrPonto(uQtd) +' -- QTD'#13#10 //
    + ', ' + QuotedStr(sBusca) +' -- STR_BUSCA'#13#10 //
    +');';

  {

    PROCEDURE PEGUE_ITEM
    (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , VENDA_ID ID_DOM NOT NULL
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
    , QTD QTD_DOM NOT NULL
    , STR_BUSCA VARCHAR(30)
    )
    RETURNS
    (
    EST_MOV_ID_RET BIGINT
    , ORDEM_RET SMALLINT
    , VENDA_ID_RET ID_DOM
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    , PROD_ID ID_DOM
    , DESCR_RED PROD_DESCR_RED_DOM
    , FABR_NOME NOME_REDU_DOM
    , UNID_SIGLA CHAR(6)
    , BAL_USO SMALLINT
    , CUSTO CUSTO_DOM
    , PRECO PRECO_DOM
    , ENCONTRADO BOOLEAN
    , MENSAGEM VARCHAR(30)
    , LOG_STR_RET VARCHAR(200)



    SELECT *
    FROM VENDA_PDV_INS_PA.PEGUE_ITEM(
    1 -- LOJA_ID
    , 1 -- TERMINAL_ID
    , NULL -- EST_MOV_ID

    , 1 -- SESS_LOJA_ID
    , 1 -- SESS_TERMINAL_ID
    , 3 -- SESS_ID
    , 1
    , '7869549490313'
    );

  }

{$IFDEF DEBUG}
    CopyTextToClipboard(sSql);
{$ENDIF}
  end;

  end.
