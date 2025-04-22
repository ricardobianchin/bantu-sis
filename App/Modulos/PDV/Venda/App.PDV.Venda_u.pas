unit App.PDV.Venda_u;

interface

uses App.PDV.Venda, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  App.Est.Venda.Caixa.CaixaSessao, Sis.DB.DBTypes, App.Est.Mov_u,
  Sis.Sis.Constants, App.PDV.VendaItem, App.Loja, System.Generics.Collections,
  App.PDV.VendaPag.List;

type
  TPDVVenda = class(TEstMov, IPDVVenda)
  private
    FVendaId: TId;
    FCaixaSessao: ICaixaSessao;
    FC: string;
    FCli: TIdLojaTermRecord;
    FEnder: TIdLojaTermRecord;
    FCustoTotal: Currency;
    FDescontoTotal: Currency;
    FTotalLiquido: Currency;
    FEntregaTem: Boolean;
    FEntregadorId: TId;
    FEntregaEm: TDateTime;
    FVendaAlteradoEm: TDateTime;
    FVendaPagList: IVendaPagList;

    function GetVendaId: TId;
    procedure SetVendaId(Value: TId);

    function GetCaixaSessao: ICaixaSessao;

    function GetC: string;
    procedure SetC(Value: string);

    function GetCli: TIdLojaTermRecord;
    function GetEnder: TIdLojaTermRecord;

    function GetCustoTotal: Currency;
    procedure SetCustoTotal(Value: Currency);

    function GetDescontoTotal: Currency;
    procedure SetDescontoTotal(Value: Currency);

    function GetTotalLiquido: Currency;
    procedure SetTotalLiquido(Value: Currency);

    function GetEntregaTem: Boolean;
    procedure SetEntregaTem(Value: Boolean);

    function GetEntregadorId: TId;
    procedure SetEntregadorId(Value: TId);

    function GetEntregaEm: TDateTime;
    procedure SetEntregaEm(Value: TDateTime);

    function GetVendaAlteradoEm: TDateTime;
    procedure SetVendaAlteradoEm(Value: TDateTime);

    function GetItems: TList<IPDVVendaItem>;

    function GetVendaPagList: IVendaPagList;

  public
    property VendaId: TId read GetVendaId Write SetVendaId;
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;
    property C: string read GetC write SetC;
    property Cli: TIdLojaTermRecord read GetCli;
    property Ender: TIdLojaTermRecord read GetEnder;
    property CustoTotal: Currency read GetCustoTotal write SetCustoTotal;
    property DescontoTotal: Currency read GetDescontoTotal
      write SetDescontoTotal;
    property TotalLiquido: Currency read GetTotalLiquido write SetTotalLiquido;
    property EntregaTem: Boolean read GetEntregaTem write SetEntregaTem;
    property EntregadorId: TId read GetEntregadorId write SetEntregadorId;
    property EntregaEm: TDateTime read GetEntregaEm write SetEntregaEm;
    property VendaAlteradoEm: TDateTime read GetVendaAlteradoEm
      write SetVendaAlteradoEm;
    property VendaPagList: IVendaPagList read GetVendaPagList;

    function GetCod(pSeparador: string = '-'): string;

    procedure Zerar; override;

    function GetItensPrecoTot: Currency;
    function GetFalta: Currency;

    procedure ItensPegarTots( //
      out pTotalLiquido: Currency; //
      out pTotalDevido: Currency; //
      out pTotalEntregue: Currency; //
      out pFalta: Currency; //
      out pTroco: Currency //
      );

    function GetQtdItensAtivos: integer;

    constructor Create( //
      pLoja: IAppLoja; //
      pTerminalId: TTerminalId; //
      pDtHDoc: TDateTime; //
      pEstMovCriadoEm: TDateTime; //
      pCaixaSessao: ICaixaSessao; //

      // pCli: TIdLojaTermRecord; //
      // pEnder: TIdLojaTermRecord; //

      pVendaId: TId = 0; //
      pC: string = ''; //
      pCustoTotal: Currency = 0; //
      pDescontoTotal: Currency = 0; //
      pTotalLiquido: Currency = 0; //
      pEntregaTem: Boolean = False; //
      pEntregadorId: TId = 0; //
      pEntregaEm: TDateTime = DATA_ZERADA; //
      pVendaAlteradoEm: TDateTime = DATA_ZERADA; //

      pEstMovId: Int64 = 0; //
      pEstMovFinalizado: Boolean = False; //
      pEstMovCancelado: Boolean = False; //
      pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
      pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
      pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
      );

  end;

implementation

uses App.PDV.Factory_u, System.SysUtils;

{ TPDVVenda }

constructor TPDVVenda.Create( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //
  pCaixaSessao: ICaixaSessao; //

  // pCli: TIdLojaTermRecord; //
  // pEnder: TIdLojaTermRecord; //

  pVendaId: TId; //
  pC: string; //
  pCustoTotal: Currency; //
  pDescontoTotal: Currency; //
  pTotalLiquido: Currency; //
  pEntregaTem: Boolean; //
  pEntregadorId: TId; //
  pEntregaEm: TDateTime; //
  pVendaAlteradoEm: TDateTime; //

  pEstMovId: Int64; //
  pEstMovFinalizado: Boolean; //
  pEstMovCancelado: Boolean; //
  pEstMovAlteradoEm: TDateTime; //
  pEstMovFinalizadoEm: TDateTime; //
  pEstMovCanceladoEm: TDateTime //
  );
begin
  inherited Create( //
    pLoja //
    , pTerminalId //
    , TEstMovTipo.emtipoVenda //
    , pDtHDoc //
    , pEstMovCriadoEm //
    , pEstMovId

    , pEstMovFinalizado //
    , pEstMovCancelado //
    , pEstMovAlteradoEm //
    , pEstMovFinalizadoEm //
    , pEstMovCanceladoEm //
    );

  FCaixaSessao := pCaixaSessao;

  FVendaId := pVendaId;
  FCaixaSessao := pCaixaSessao;
  FC := pC;

  FCustoTotal := pCustoTotal;
  FDescontoTotal := pDescontoTotal;
  FTotalLiquido := pTotalLiquido;
  FEntregaTem := pEntregaTem;
  FEntregadorId := pEntregadorId;
  FEntregaEm := pEntregaEm;
  FVendaAlteradoEm := pVendaAlteradoEm;

  FCli.Zerar;
  FEnder.Zerar;

  FVendaPagList := VendaPagListCreate;
end;

function TPDVVenda.GetVendaAlteradoEm: TDateTime;
begin
  Result := FVendaAlteradoEm;
end;

function TPDVVenda.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(Loja.Id, TerminalId, VendaId, 'VEN',
    pSeparador);
end;

function TPDVVenda.GetC: string;
begin
  Result := FC;
end;

function TPDVVenda.GetCaixaSessao: ICaixaSessao;
begin
  Result := FCaixaSessao;
end;

function TPDVVenda.GetCli: TIdLojaTermRecord;
begin
  Result := FCli;
end;

function TPDVVenda.GetCustoTotal: Currency;
begin
  Result := FCustoTotal;
end;

function TPDVVenda.GetDescontoTotal: Currency;
begin
  Result := FDescontoTotal;
end;

function TPDVVenda.GetEnder: TIdLojaTermRecord;
begin
  Result := FEnder;
end;

function TPDVVenda.GetEntregadorId: TId;
begin
  Result := FEntregadorId;
end;

function TPDVVenda.GetEntregaEm: TDateTime;
begin
  Result := FEntregaEm;
end;

function TPDVVenda.GetEntregaTem: Boolean;
begin
  Result := FEntregaTem;
end;

function TPDVVenda.GetFalta: Currency;
var
  uItensTot: Currency;
  uPagTot: Currency;
  uDif: Currency;
begin
  uItensTot := GetItensPrecoTot;
  uPagTot := VendaPagList.Total;
  uDif := uItensTot - uPagTot;
  Result := uDif;
end;

function TPDVVenda.GetTotalLiquido: Currency;
begin
  Result := FTotalLiquido;
end;

function TPDVVenda.GetVendaId: TId;
begin
  Result := FVendaId;
end;

function TPDVVenda.GetItems: TList<IPDVVendaItem>;
begin
  Result := TList<IPDVVendaItem>(inherited Items);
end;

function TPDVVenda.GetItensPrecoTot: Currency;
var
  oItem: IPDVVendaItem;
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
  begin
    oItem := IPDVVendaItem(Items[I]);
    Result := Result + oItem.Preco;
  end;
end;

function TPDVVenda.GetQtdItensAtivos: integer;
var
  oItem: IPDVVendaItem;
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
  begin
    oItem := IPDVVendaItem(Items[I]);
    if not oItem.Cancelado then
      inc(Result);
  end;
end;

function TPDVVenda.GetVendaPagList: IVendaPagList;
begin
  Result := FVendaPagList;
end;

procedure TPDVVenda.ItensPegarTots( //
  out pTotalLiquido: Currency; //
  out pTotalDevido: Currency; //
  out pTotalEntregue: Currency; //
  out pFalta: Currency; //
  out pTroco: Currency //
  );
begin
  pTotalLiquido := GetItensPrecoTot;

  FVendaPagList.GetTots(pTotalDevido, pTotalEntregue, pTroco);

  pFalta := pTotalLiquido - (pTotalEntregue - pTroco);
end;

procedure TPDVVenda.SetVendaAlteradoEm(Value: TDateTime);
begin
  FVendaAlteradoEm := Value;
end;

procedure TPDVVenda.SetC(Value: string);
begin
  FC := Value;
end;

procedure TPDVVenda.SetCustoTotal(Value: Currency);
begin
  FCustoTotal := Value;
end;

procedure TPDVVenda.SetDescontoTotal(Value: Currency);
begin
  FDescontoTotal := Value;
end;

procedure TPDVVenda.SetEntregadorId(Value: TId);
begin
  FEntregadorId := Value;
end;

procedure TPDVVenda.SetEntregaEm(Value: TDateTime);
begin
  FEntregaEm := Value;
end;

procedure TPDVVenda.SetEntregaTem(Value: Boolean);
begin
  FEntregaTem := Value;
end;

procedure TPDVVenda.SetTotalLiquido(Value: Currency);
begin
  FTotalLiquido := Value;
end;

procedure TPDVVenda.SetVendaId(Value: TId);
begin
  FVendaId := Value;
end;

procedure TPDVVenda.Zerar;
begin
  inherited;
  VendaId := 0;
  FC := '';
  FCli.Zerar;
  FEnder.Zerar;
  FCustoTotal := 0;
  FDescontoTotal := 0;
  FTotalLiquido := 0;
  FEntregaTem := False;
  FEntregadorId := 0;
  FEntregaEm := DATA_ZERADA;
  FVendaAlteradoEm := DATA_ZERADA;
  Items.Clear;
  FVendaPagList.Clear;
end;

end.
