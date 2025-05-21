unit App.Retag.Est.EntradaItem_u;

interface

uses App.Retag.Est.EntradaItem, App.Est.EstMovItem_u, Sis.Sis.Constants,
  App.Est.Prod;

type
  TRetagEntradaItem = class(TEstMovItem, IRetagEntradaItem)
  private
    FCusto: Currency;

    function GetCusto: Currency;
    procedure SetCusto(Value: Currency);
  public
    property Custo: Currency read GetCusto write SetCusto;
    constructor Create( //
      pOrdem: SmallInt; //
      pProd: IProd; //
      pQtd: Currency; //
      pCusto: Currency; //
      pCriadoEm: TDateTime; //
      pCancelado: Boolean = False; //
      pAlteradoEm: TDateTime = DATA_ZERADA; //
      pCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;

implementation

{ TRetagEntradaItem }

constructor TRetagEntradaItem.Create(pOrdem: SmallInt; pProd: IProd; pQtd,
  pCusto: Currency; pCriadoEm: TDateTime; pCancelado: Boolean; pAlteradoEm,
  pCanceladoEm: TDateTime);
begin
  inherited Create(pOrdem, pProd, pQtd, pCriadoEm, pCancelado, pAlteradoEm, pCanceladoEm);
  Custo := pCusto;
end;

function TRetagEntradaItem.GetCusto: Currency;
begin
  Result := FCusto;
end;

procedure TRetagEntradaItem.SetCusto(Value: Currency);
begin
  FCusto := Value;
end;

end.
