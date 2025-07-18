unit App.Retag.Est.Venda.Ent_u;

interface

uses App.Est.EstMovEnt_u, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.DB.DBTypes, App.Retag.Est.VendaItem, App.Retag.Est.Venda.Ent, App.Loja,
  System.Generics.Collections, Sis.Sis.Constants;

type
  TRetagVendaEnt = class(TEstMovEnt, IRetagVendaEnt)
  private
    FVendaId: TId;
    FDescontoTotal: Currency;
    FTotalLiquido: Currency;

    function GetVendaId: TId;
    procedure SetVendaId(Value: TId);

    function GetDescontoTotal: Currency;
    procedure SetDescontoTotal(Value: Currency);

    function GetTotalLiquido: Currency;
    procedure SetTotalLiquido(Value: Currency);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

    function GetItems: TList<IRetagVendaItem>;
    procedure LimparEnt; override;
  public
    property VendaId: TId read GetVendaId write SetVendaId;
    property DescontoTotal: Currency read GetDescontoTotal
      write SetDescontoTotal;
    property TotalLiquido: Currency read GetTotalLiquido write SetTotalLiquido;

    function GetCod(pSeparador: string = '-'): string;

    constructor Create( //
      pLoja: IAppLoja; //
      pTerminalId: TTerminalId; //
      pDtHDoc: TDateTime; //
      pEstMovCriadoEm: TDateTime; //

      pVendaId: TId = 0; //

      pEstMovId: Int64 = 0; //
      pEstMovFinalizado: Boolean = False; //
      pEstMovCancelado: Boolean = False; //
      pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
      pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
      pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;

implementation

{ TRetagVendaEnt }

constructor TRetagVendaEnt.Create(pLoja: IAppLoja; pTerminalId: TTerminalId;
  pDtHDoc, pEstMovCriadoEm: TDateTime; pVendaId: TId; pEstMovId: Int64;
  pEstMovFinalizado, pEstMovCancelado: Boolean; pEstMovAlteradoEm,
  pEstMovFinalizadoEm, pEstMovCanceladoEm: TDateTime);
begin
  inherited Create( //
    pLoja //
    , pTerminalId //
    , TEstMovTipo.emtipoSaida //
    , pDtHDoc //
    , pEstMovCriadoEm //
    , pEstMovId

    , pEstMovFinalizado //
    , pEstMovCancelado //
    , pEstMovAlteradoEm //
    , pEstMovFinalizadoEm //
    , pEstMovCanceladoEm //
    );

  FVendaId := pVendaId;
end;

function TRetagVendaEnt.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(Loja.Id, TerminalId, FVendaId, 'VEN',
    pSeparador);
end;

function TRetagVendaEnt.GetDescontoTotal: Currency;
begin
  Result := FDescontoTotal;
end;

function TRetagVendaEnt.GetItems: TList<IRetagVendaItem>;
begin
  Result := TList<IRetagVendaItem>(inherited Items);
end;

function TRetagVendaEnt.GetNomeEnt: string;
begin
  Result := 'Venda';
end;

function TRetagVendaEnt.GetNomeEntAbrev: string;
begin
  Result := 'Ven';
end;

function TRetagVendaEnt.GetTitulo: string;
begin
  Result := 'Vendas';
end;

function TRetagVendaEnt.GetTotalLiquido: Currency;
begin
  Result := FTotalLiquido;
end;

function TRetagVendaEnt.GetVendaId: TId;
begin
  Result := FVendaId;
end;

procedure TRetagVendaEnt.LimparEnt;
begin
  if EditandoItem then
    exit;
  inherited;
  FVendaId := 0;
end;

procedure TRetagVendaEnt.SetDescontoTotal(Value: Currency);
begin
  FDescontoTotal := Value;
end;

procedure TRetagVendaEnt.SetTotalLiquido(Value: Currency);
begin
  FTotalLiquido := Value;
end;

procedure TRetagVendaEnt.SetVendaId(Value: TId);
begin
  FVendaId := Value;
end;

end.
