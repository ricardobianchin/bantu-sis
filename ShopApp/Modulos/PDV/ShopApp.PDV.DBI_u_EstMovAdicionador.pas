unit ShopApp.PDV.DBI_u_EstMovAdicionador;

interface

uses App.AppObj, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem, Sis.DB.DBTypes,
  Sis.Terminal, Sis.Entities.Types, Data.DB, App.PDV.Obj, FireDAC.Stan.Param,
  App.Est.Prod, Sis.Types;

type
  /// <summary>
  /// adiciona venda item no pdv durante a venda.
  /// </summary>
  TPDVVendaItemAdicionador = class
  private
    uQtd: Currency;
    sBusca: string;
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FVenda: IShopPdvVenda;
    FDBConnection: IDBConnection;
    FPDVObj: IPDVObj;
    FUsuarioId: TId;

    /// <summary>
    /// BusQ busca produto pela StrBusca.
    /// StrBusca pode conter ou prod_id ou um código de barras.
    ///
    /// Retorna se encontrou o produto,
    /// os dados do produto, incluindo se é um produto de balança.
    ///
    /// Se encontrou o produto, insere o item de venda no banco e retorna também
    /// os dados do cabeçalho da venda.
    /// Se não encontrou, retorna mensagem de erro.
    /// Se encontrou o produto e ele for de balança, apenas retorna os dados do
    /// produto sem criar nada no banco.
    /// </summary>
    BusQ: IDBQuery;

    /// <summary>
    /// PesoQ utilizada se o produto for de balança. Recebará os dados do
    /// produto de BusQ. Sistema entao lê a balança para obter a quantidade
    /// PesoQ então insere o item de venda no banco e retorna os dados do
    /// cabeçalho da venda.
    /// </summary>
    PesoQ: IDBQuery;

    bBuscaAberto: Boolean;
    CustoUnit, Custo, PrecoUnit, PrecoUnitOriginal, PrecoUnitPromo, PrecoBruto,
      Desconto, PrecoLIquido: Currency;

    function GetSqlItemBusque: string;
    function GetSqlItemAddPeso: string;

    function BuscaQCreate: IDBQuery;
    function AddItemPesoQCreate: IDBQuery;

    procedure BuscaQParmsPreencher;
    procedure PesoQParamsPreencher;

    function _ProdCreate: IProd;
    procedure BusQToVendaCabec;
    procedure PesoQToVendaCabec;

    function _BusQVendaItemCreate(pProd: IProd): IShopPDVVendaItem;
    function _PesoQVendaItemCreate(pProd: IProd): IShopPDVVendaItem;

    procedure TentaInserirVendaItem;
  public
    function BuscaProdAddEstMov(pStrBusca: string; out pEncontrou: Boolean;
      out pMensagem: string): IShopPDVVendaItem;

    constructor Create(pAppObj: IAppObj; pPDVObj: IPDVObj; pTerminal: ITerminal;
      pShopPdvVenda: IShopPdvVenda; pDBConnection: IDBConnection;
      pUsuarioId: TId);
  end;

implementation

uses Sis.DB.Factory, Sis.Types.Floats, System.SysUtils, App.Est.Factory_u,
  ShopApp.PDV.Factory_u, Sis.Sis.Constants, System.Math,
  ShopApp.PDV.Venda.Utils_u;

{ TPDVVendaItemAdicionador }

function TPDVVendaItemAdicionador.AddItemPesoQCreate: IDBQuery;
var
  sSql: string;
begin
  sSql := GetSqlItemAddPeso;
  Result := DBQueryCreate('pdvdbibusca.additempeso.exec', FDBConnection, sSql,
    nil, nil);
end;

procedure TPDVVendaItemAdicionador.BuscaQParmsPreencher;
begin
  BusQ.Params[0].AsSmallInt := FAppObj.Loja.Id;
  BusQ.Params[1].AsSmallInt := FTerminal.TerminalId;
  BusQ.Params[2].AsLargeInt := FVenda.EstMovId;
  BusQ.Params[3].AsInteger := FVenda.VendaId;
  BusQ.Params[4].AsInteger := FVenda.CaixaSessao.LojaId;
  BusQ.Params[5].AsSmallInt := FVenda.CaixaSessao.TerminalId;
  BusQ.Params[6].AsInteger := FVenda.CaixaSessao.Id;
  BusQ.Params[7].AsCurrency := uQtd;
  BusQ.Params[8].AsString := sBusca;
  BusQ.Params[9].AsBoolean := FPDVObj.Balanca.Habilitada;

  BusQ.Params[10].AsInteger := FUsuarioId;
  BusQ.Params[11].AsSmallInt := FAppObj.SisConfig.LocalMachineId.IdentId;
  BusQ.Params[12].AsString := Chr(34);
end;

procedure TPDVVendaItemAdicionador.BusQToVendaCabec;
begin
  if FVenda.VendaId <> 0 then
    exit;

  FVenda.EstMovId := BusQ.Fields[0 { EST_MOV_ID_RET } ].AsLargeInt;
  FVenda.VendaId := BusQ.Fields[1 { VENDA_ID_RET } ].AsInteger;
  FVenda.DtHDoc := BusQ.Fields[2 { DTH_DOC_RET } ].AsDateTime;
  FVenda.CriadoEm := BusQ.Fields[3 { EST_MOV_CRIADO_EM_RET } ].AsDateTime;
end;

function TPDVVendaItemAdicionador.BuscaQCreate: IDBQuery;
var
  sSql: string;
begin
  sSql := GetSqlItemBusque;
  Result := DBQueryCreate('pdvdbibusca.prod.q', FDBConnection, sSql, nil, nil);
end;

constructor TPDVVendaItemAdicionador.Create(pAppObj: IAppObj; pPDVObj: IPDVObj;
  pTerminal: ITerminal; pShopPdvVenda: IShopPdvVenda;
  pDBConnection: IDBConnection; pUsuarioId: TId);
begin
  FAppObj := pAppObj;
  FPDVObj := pPDVObj;
  FTerminal := pTerminal;
  FVenda := pShopPdvVenda;
  FDBConnection := pDBConnection;
  BusQ := BuscaQCreate;
  PesoQ := AddItemPesoQCreate;
  FUsuarioId := pUsuarioId;
end;

procedure TPDVVendaItemAdicionador.TentaInserirVendaItem;
begin

end;

function TPDVVendaItemAdicionador._ProdCreate: IProd;
begin
  Result := ProdCreate( //
    BusQ.Fields[6 { PROD_ID } ].AsInteger //
    , BusQ.Fields[7 { DESCR_RED } ].AsString //
    , BusQ.Fields[8 { FABR_NOME } ].AsString //
    , BusQ.Fields[9 { UNID_SIGLA } ].AsString) //
    ;
end;

function TPDVVendaItemAdicionador._PesoQVendaItemCreate(pProd: IProd)
  : IShopPDVVendaItem;
begin
  Result := ShopPDVVendaItemCreate( //
    PesoQ.Fields[4 { ORDEM_RET } ].AsInteger //
    , pProd //
    , uQtd //

    , BusQ.Fields[10 { BALANCA_EXIGE } ].AsBoolean //

    , CustoUnit //
    , Custo //

    , PrecoUnitOriginal //
    , PrecoUnitPromo //
    , PrecoUnit //
    , PrecoBruto //

    , Desconto //
    , PrecoLIquido //

    , False // pEstMovItemCancelado
    , DATA_ZERADA // pEstMovItemCriadoEm
    , DATA_ZERADA // pEstMovItemAlteradoEm
    , DATA_ZERADA // pEstMovItemCanceladoEm
    );
end;

function TPDVVendaItemAdicionador._BusQVendaItemCreate(pProd: IProd)
  : IShopPDVVendaItem;
begin
  Result := ShopPDVVendaItemCreate( //
    BusQ.Fields[4 { ORDEM_RET } ].AsInteger //
    , pProd //
    , uQtd //

    , BusQ.Fields[10 { BALANCA_EXIGE } ].AsBoolean //

    , BusQ.Fields[11 { CUSTO_UNIT } ].AsCurrency //
    , BusQ.Fields[12 { CUSTO } ].AsCurrency //

    , BusQ.Fields[13 { PRECO_UNIT_ORIGINAL } ].AsCurrency //
    , BusQ.Fields[14 { PRECO_UNIT_PROMO } ].AsCurrency //
    , BusQ.Fields[15 { PRECO_UNIT } ].AsCurrency //
    , BusQ.Fields[16 { PRECO_BRUTO } ].AsCurrency //
    // como nao tem desconto, uso duas vezes preco bruto

    , 0 // desconto
    , BusQ.Fields[16 { PRECO_BRUTO } ].AsCurrency // preco

    , False // pEstMovItemCancelado
    , DATA_ZERADA // pEstMovItemCriadoEm
    , DATA_ZERADA // pEstMovItemAlteradoEm
    , DATA_ZERADA // pEstMovItemCanceladoEm
    );
end;

function TPDVVendaItemAdicionador.GetSqlItemAddPeso: string;
var
  V: IShopPdvVenda;
  T: ITerminal;
  LojaId: TShortId;
begin
  V := FVenda;
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
    + ', MENSAGEM'#13#10 // 6
    + ', LOG_STR_RET'#13#10 // 7

    + 'FROM VENDA_PDV_INS_PA.ITEM_PEGUE'#13#10 //

    + '('#13#10 //
    + ':LOJA_ID'#13#10 // 0
    + ', :TERMINAL_ID'#13#10 // 1
    + ', :EST_MOV_ID'#13#10 // 2
    + ', :VENDA_ID'#13#10 // 3
    + ', :SESS_LOJA_ID'#13#10 // 4
    + ', :SESS_TERMINAL_ID'#13#10 // 5
    + ', :SESS_ID'#13#10 // 6
    + ', :PROD_ID'#13#10 // 7
    + ', :QTD'#13#10 // 8
    + ', :CUSTO_UNIT'#13#10 // 9
    + ', :CUSTO'#13#10 // 10
    + ', :PRECO_UNIT_ORIGINAL'#13#10 // 11
    + ', :PRECO_UNIT_PROMO'#13#10 // 12
    + ', :PRECO_UNIT'#13#10 // 13
    + ', :PRECO_BRUTO'#13#10 // 14
    + ', :DESCONTO'#13#10 // 15
    + ', :PRECO'#13#10 // 16
    + ', :LOG_STR'#13#10 // 17

    + ', :LOG_PESSOA_ID'#13#10 // 18
    + ', :MACHINE_ID'#13#10 // 19
    + ', :MODULO_SIS_ID'#13#10 // 20

    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
end;

function TPDVVendaItemAdicionador.GetSqlItemBusque: string;
begin
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
    + ', :BALANCA_HABILITADA'#13#10 // 9

    + ', :LOG_PESSOA_ID'#13#10 // 10
    + ', :MACHINE_ID'#13#10 // 11
    + ', :MODULO_SIS_ID'#13#10 // 12

    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
end;

procedure TPDVVendaItemAdicionador.PesoQParamsPreencher;
var
  q: TDataSet;
  Params: TFDParams;
begin
  // indices a esquerda vem de GetSqlItemAddPeso entre parenteses
  // indices a direita vem de GetSqlItemBusque do select

  q := BusQ.DataSet;
  Params := PesoQ.Params;

  Params[0].AsSmallInt := FAppObj.Loja.Id;
  Params[1].AsSmallInt := FTerminal.TerminalId;
  Params[2].AsSmallInt := FVenda.EstMovId;

  Params[3].AsInteger := FVenda.VendaId;

  Params[4].AsInteger := FVenda.CaixaSessao.LojaId;
  Params[5].AsSmallInt := FVenda.CaixaSessao.TerminalId;
  Params[6].AsInteger := FVenda.CaixaSessao.Id;

  Params[7].AsInteger := q.Fields[6 { PROD_ID } ].AsInteger;
  Params[8].AsCurrency := uQtd;

  Params[9].AsCurrency := CustoUnit;
  Params[10].AsCurrency := Custo;

  Params[11].AsCurrency := PrecoUnitOriginal;
  Params[12].AsCurrency := PrecoUnitPromo;
  Params[13].AsCurrency := PrecoUnit;
  Params[14].AsCurrency := PrecoBruto;
  Params[15].AsCurrency := Desconto;
  Params[16].AsCurrency := PrecoLIquido;
  Params[17].AsString := 'PDV ADD PESO';

  Params[18].AsInteger := FUsuarioId;
  Params[19].AsSmallInt := FAppObj.SisConfig.LocalMachineId.IdentId;
  Params[20].AsString := Chr(34);
end;

procedure TPDVVendaItemAdicionador.PesoQToVendaCabec;
begin
  if FVenda.VendaId <> 0 then
    exit;

  FVenda.EstMovId := PesoQ.Fields[0 { EST_MOV_ID_RET } ].AsLargeInt;
  FVenda.VendaId := PesoQ.Fields[1 { VENDA_ID_RET } ].AsInteger;
  FVenda.DtHDoc := PesoQ.Fields[2 { DTH_DOC_RET } ].AsDateTime;
  FVenda.CriadoEm := PesoQ.Fields[3 { EST_MOV_CRIADO_EM_RET } ].AsDateTime;
end;

function TPDVVendaItemAdicionador.BuscaProdAddEstMov(pStrBusca: string;
  out pEncontrou: Boolean; out pMensagem: string): IShopPDVVendaItem;
var
  q: TDataSet;
  oProd: IProd;
  bPrecisaPesar: Boolean;
  bErroDeu: Boolean;
begin
  Result := nil;

  SepareBuscaStr(pStrBusca, sBusca, uQtd);
  FDBConnection.Abrir;
  try
    BuscaQParmsPreencher;
    BusQ.Abrir;
    pEncontrou := BusQ.Fields[17 { ENCONTRADO } ].AsBoolean;

    if not pEncontrou then
    begin
      pMensagem := BusQ.Fields[18 { MENSAGEM } ].AsString;
      exit;
    end;

    q := BusQ.DataSet;

    oProd := _ProdCreate;

    bPrecisaPesar := q.Fields[10 { BALANCA_EXIGE } ].AsBoolean and
      FPDVObj.Balanca.Habilitada;

    if not bPrecisaPesar then
    begin
      BusQToVendaCabec;
      Result := _BusQVendaItemCreate(oProd);
      exit;
    end;

    // substitui uQtd pelo peso
    FPDVObj.Balanca.LePeso(uQtd, bErroDeu, pMensagem);
    if bErroDeu then
    begin
      pEncontrou := False;
      exit;
    end;

    CustoUnit := BusQ.Fields[11 { CUSTO_UNIT } ].AsCurrency;
    Custo := RoundTo(uQtd * CustoUnit, -2);

    PrecoUnitOriginal := BusQ.Fields[13 { PRECO_UNIT_ORIGINAL } ].AsCurrency;
    PrecoUnitPromo := BusQ.Fields[14 { PRECO_UNIT_PROMO } ].AsCurrency;
    PrecoUnit := BusQ.Fields[15 { PRECO_UNIT } ].AsCurrency;

    PrecoBruto := RoundTo(uQtd * PrecoUnit, -2);
    Desconto := 0;
    PrecoLIquido := PrecoBruto - Desconto;

    PesoQParamsPreencher;
    PesoQ.Abrir;
    PesoQToVendaCabec;
    Result := _PesoQVendaItemCreate(oProd);
  finally
    BusQ.Fechar;
    FDBConnection.Fechar;
  end;
end;

end.
