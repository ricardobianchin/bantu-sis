unit App.PDV.Venda_u;

interface

uses App.PDV.Venda, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  App.Est.Venda.Caixa.CaixaSessao, Sis.DB.DBTypes, App.Est.Mov_u,
  Sis.Sis.Constants, App.PDV.VendaItem, System.Generics.Collections;

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
    FAlteradoEm: TDateTime;

    FItemList: TList<IPDVVendaItem>;

    function GetVendaId: TId;
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

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(Value: TDateTime);
  public
    destructor Destroy; override;
    property VendaId: TId read GetVendaId;
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
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    function PegueItem( //
      pEstMovOrdem: SmallInt; //
      pEstMovProdId: TId; //
      pEstMovQtd: Currency; //

      pCustoUnit: Currency; //
      pCusto: Currency; //
      pPrecoUnitOriginal: Currency; //
      pPrecoUnitPromo: Currency; //
      pPrecoUnit: Currency; //
      pPrecoBruto: Currency; //
      pDesconto: Currency; //
      pPreco: Currency; //

      pEstMovCancelado: Boolean = False; //
      pEstMovCriadoEm: TDateTime = DATA_ZERADA; //
      pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
      pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
      ): integer;

    constructor Create( //
      pLojaId: TLojaId; //
      pTerminalId: TTerminalId; //
      pEstMovTipo: TEstMovTipo; //
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

{ TPDVVenda }

uses App.PDV.Factory_u;

constructor TPDVVenda.Create( //
  pLojaId: TLojaId; //
  pTerminalId: TTerminalId; //
  pEstMovTipo: TEstMovTipo; //
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
  inherited Create(pLojaId //
    , pTerminalId //
    , pEstMovTipo //
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
  FAlteradoEm := pVendaAlteradoEm;

  FCli.Zerar;
  FEnder.Zerar;

  FItemList := TList<IPDVVendaItem>.Create;

end;

destructor TPDVVenda.Destroy;
begin
  FItemList.Free;
  inherited;
end;

function TPDVVenda.GetAlteradoEm: TDateTime;
begin
  Result := FAlteradoEm;
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

function TPDVVenda.GetTotalLiquido: Currency;
begin
  Result := FTotalLiquido;
end;

function TPDVVenda.GetVendaId: TId;
begin
  Result := FVendaId;
end;

function TPDVVenda.PegueItem(
  pEstMovOrdem: SmallInt; //
  pEstMovProdId: TId; //
  pEstMovQtd: Currency; //

  pCustoUnit: Currency; //
  pCusto: Currency; //
  pPrecoUnitOriginal: Currency; //
  pPrecoUnitPromo: Currency; //
  pPrecoUnit: Currency; //
  pPrecoBruto: Currency; //
  pDesconto: Currency; //
  pPreco: Currency; //

  pEstMovCancelado: Boolean; //
  pEstMovCriadoEm: TDateTime; //
  pEstMovAlteradoEm: TDateTime; //
  pEstMovCanceladoEm: TDateTime //
  ): integer;
var
  oPdvVendaItem: IPdvVendaItem;
begin
  oPdvVendaItem := PdvVendaItemCreate(
    pEstMovOrdem //
    , pEstMovProdId //
    , pEstMovQtd //

    , pCustoUnit //
    , pCusto //
    , pPrecoUnitOriginal //
    , pPrecoUnitPromo //
    , pPrecoUnit //
    , pPrecoBruto //
    , pDesconto //
    , pPreco //

    , pEstMovCancelado //
    , pEstMovCriadoEm //
    , pEstMovAlteradoEm //
    , pEstMovCanceladoEm //
    );
end;

procedure TPDVVenda.SetAlteradoEm(Value: TDateTime);
begin
  FAlteradoEm := Value;
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

end.
