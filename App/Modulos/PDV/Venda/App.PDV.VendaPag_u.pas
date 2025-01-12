unit App.PDV.VendaPag_u;

interface

uses
  App.PDV.VendaPag, Sis.Types;

type
  TVendaPag = class(TInterfacedObject, IVendaPag)
  private
    FOrdem: SmallInt;
    FPagamentoFormaId: TId;
    FPagamentoFormaTipoId: string;
    FPagamentoFormaTipoDescrRed: string;
    FPagamentoFormaDescr: string;

    FValorDevido: Currency;
    FValorEntregue: Currency;
    FTroco: Currency;
    FCancelado: Boolean;

    function GetOrdem: SmallInt;
    procedure SetOrdem(const Value: SmallInt);

    function GetPagamentoFormaTipoId: string;
    procedure SetPagamentoFormaTipoId(const Value: string);

    function GetPagamentoFormaTipoDescrRed: string;
    procedure SetPagamentoFormaTipoDescrRed(const Value: string);

    function GetPagamentoFormaDescr: string;
    procedure SetPagamentoFormaDescr(const Value: string);

    function GetPagamentoFormaId: TId;
    procedure SetPagamentoFormaId(const Value: TId);
    function GetValorDevido: Currency;
    procedure SetValorDevido(const Value: Currency);
    function GetValorEntregue: Currency;
    procedure SetValorEntregue(const Value: Currency);
    function GetTroco: Currency;
    procedure SetTroco(const Value: Currency);
    function GetCancelado: Boolean;
    procedure SetCancelado(const Value: Boolean);
    function GetAceitaTroco: Boolean;
  public
    constructor Create(AOrdem: SmallInt; APagamentoFormaId: TId;
      APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
      APagamentoFormaDescr: string; AValorDevido, AValorEntregue,
      ATroco: Currency; ACancelado: Boolean);

    property Ordem: SmallInt read GetOrdem write SetOrdem;
    property PagamentoFormaId: TId read GetPagamentoFormaId
      write SetPagamentoFormaId;
    property PagamentoFormaTipoId: string read GetPagamentoFormaTipoId;
    property PagamentoFormaTipoDescrRed: string
      read GetPagamentoFormaTipoDescrRed;
    property PagamentoFormaDescr: string read GetPagamentoFormaDescr;
    property ValorDevido: Currency read GetValorDevido write SetValorDevido;
    property ValorEntregue: Currency read GetValorEntregue
      write SetValorEntregue;
    property Troco: Currency read GetTroco write SetTroco;
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    property AceitaTroco: Boolean read GetAceitaTroco;
  end;

implementation

constructor TVendaPag.Create(AOrdem: SmallInt; APagamentoFormaId: TId;
      APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
      APagamentoFormaDescr: string; AValorDevido, AValorEntregue,
      ATroco: Currency; ACancelado: Boolean);
begin
  FOrdem := AOrdem;
  FPagamentoFormaId := APagamentoFormaId;
  FPagamentoFormaTipoId := APagamentoFormaTipoId;
  FPagamentoFormaTipoDescrRed := APagamentoFormaTipoDescrRed;
  FPagamentoFormaDescr := APagamentoFormaDescr;
  FValorDevido := AValorDevido;
  FValorEntregue := AValorEntregue;
  FTroco := ATroco;
  FCancelado := ACancelado;
end;

function TVendaPag.GetOrdem: SmallInt;
begin
  Result := FOrdem;
end;

procedure TVendaPag.SetOrdem(const Value: SmallInt);
begin
  FOrdem := Value;
end;

function TVendaPag.GetPagamentoFormaDescr: string;
begin
  Result := FPagamentoFormaDescr;
end;

function TVendaPag.GetPagamentoFormaId: TId;
begin
  Result := FPagamentoFormaId;
end;

function TVendaPag.GetPagamentoFormaTipoDescrRed: string;
begin
  Result := FPagamentoFormaTipoDescrRed;
end;

function TVendaPag.GetPagamentoFormaTipoId: string;
begin
  Result := FPagamentoFormaTipoId;
end;

procedure TVendaPag.SetPagamentoFormaDescr(const Value: string);
begin
  FPagamentoFormaDescr := Value;
end;

procedure TVendaPag.SetPagamentoFormaId(const Value: TId);
begin
  FPagamentoFormaId := Value;
end;

procedure TVendaPag.SetPagamentoFormaTipoDescrRed(const Value: string);
begin
  FPagamentoFormaTipoDescrRed := Value;
end;

procedure TVendaPag.SetPagamentoFormaTipoId(const Value: string);
begin
  FPagamentoFormaTipoId := Value;
end;

function TVendaPag.GetValorDevido: Currency;
begin
  Result := FValorDevido;
end;

procedure TVendaPag.SetValorDevido(const Value: Currency);
begin
  FValorDevido := Value;
end;

function TVendaPag.GetValorEntregue: Currency;
begin
  Result := FValorEntregue;
end;

procedure TVendaPag.SetValorEntregue(const Value: Currency);
begin
  FValorEntregue := Value;
end;

function TVendaPag.GetTroco: Currency;
begin
  Result := FTroco;
end;

procedure TVendaPag.SetTroco(const Value: Currency);
begin
  FTroco := Value;
end;

function TVendaPag.GetAceitaTroco: Boolean;
begin
  Result := FPagamentoFormaId = 1;
end;

function TVendaPag.GetCancelado: Boolean;
begin
  Result := FCancelado;
end;

procedure TVendaPag.SetCancelado(const Value: Boolean);
begin
  FCancelado := Value;
end;

end.
