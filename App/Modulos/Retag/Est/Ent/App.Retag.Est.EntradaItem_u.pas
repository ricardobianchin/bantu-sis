unit App.Retag.Est.EntradaItem_u;

interface

uses App.Retag.Est.EntradaItem, App.Est.EstMovItem_u, Sis.Sis.Constants,
  App.Est.Prod, App.Types;

type
  TRetagEntradaItem = class(TEstMovItem, IRetagEntradaItem)
  private
    FNItem: SmallInt;
    FProdIdDeles: string;
    FCusto: TCusto;
    FMargem: Currency;
    FPreco: TPreco;

    function GetNItem: SmallInt;
    procedure SetNItem(Value: SmallInt);

    function GetProdIdDeles: string;
    procedure SetProdIdDeles(Value: string);

    function GetCusto: TCusto;
    procedure SetCusto(Value: TCusto);

    function GetMargem: Currency;
    procedure SetMargem(Value: Currency);

    function GetPreco: TPreco;
    procedure SetPreco(Value: TPreco);

  public
    property NItem: SmallInt read GetNItem write SetNItem;
    property ProdIdDeles: string read GetProdIdDeles write SetProdIdDeles;
    property Custo: TCusto read GetCusto write SetCusto;
    property Margem: Currency read GetMargem write SetMargem;
    property Preco: TPreco read GetPreco write SetPreco;

    constructor Create( //
      pOrdem: SmallInt; //
      pNItem: SmallInt; //
      pProdIdDeles: string; //

      pProd: IProd; //
      pQtd: Currency; //
      pCusto: TCusto; //
      pMargem: Currency; //
      pPreco: TPreco; //

      pCriadoEm: TDateTime; //
      pCancelado: Boolean = False; //
      pAlteradoEm: TDateTime = DATA_ZERADA; //
      pCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;

implementation

{ TRetagEntradaItem }

constructor TRetagEntradaItem.Create( //
      pOrdem: SmallInt; //
      pNItem: SmallInt; //
      pProdIdDeles: string; //

      pProd: IProd; //
      pQtd: Currency; //
      pCusto: TCusto; //
      pMargem: Currency; //
      pPreco: TPreco; //

      pCriadoEm: TDateTime; //
      pCancelado: Boolean = False; //
      pAlteradoEm: TDateTime = DATA_ZERADA; //
      pCanceladoEm: TDateTime = DATA_ZERADA //
  );
begin
  inherited Create(pOrdem, pProd, pQtd, pCriadoEm, pCancelado, pAlteradoEm,
    pCanceladoEm);
  FProdIdDeles := pProdIdDeles;
  FCusto := pCusto;
  FMargem := pMargem;
  FPreco := pPreco;
  FNItem := pNItem;

end;

function TRetagEntradaItem.GetCusto: TCusto;
begin
  Result := FCusto;
end;

function TRetagEntradaItem.GetMargem: Currency;
begin
  Result := FMargem;
end;

function TRetagEntradaItem.GetNItem: SmallInt;
begin
  Result := FNItem;
end;

function TRetagEntradaItem.GetPreco: TPreco;
begin
  Result := FPreco;
end;

function TRetagEntradaItem.GetProdIdDeles: string;
begin
  Result := FProdIdDeles;
end;

procedure TRetagEntradaItem.SetCusto(Value: TCusto);
begin
  FCusto := Value;
end;

procedure TRetagEntradaItem.SetMargem(Value: Currency);
begin
  FMargem := Value;
end;

procedure TRetagEntradaItem.SetNItem(Value: SmallInt);
begin
  FNItem := Value;
end;

procedure TRetagEntradaItem.SetPreco(Value: TPreco);
begin
  FPreco := Value;
end;

procedure TRetagEntradaItem.SetProdIdDeles(Value: string);
begin
  FProdIdDeles := Value;
end;

end.
