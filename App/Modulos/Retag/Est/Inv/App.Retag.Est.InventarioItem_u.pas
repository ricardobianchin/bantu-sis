unit App.Retag.Est.InventarioItem_u;

interface

uses App.Retag.Est.InventarioItem, App.Est.EstMovItem_u, Sis.Sis.Constants,
  App.Est.Prod;

type
  TRetagInventarioItem = class(TEstMovItem, IRetagInventarioItem)
  public
    constructor Create( //
      pOrdem: SmallInt; //
      pProd: IProd; //
      pQtd: Currency; //
      pCriadoEm: TDateTime; //
      pCancelado: Boolean = False; //
      pAlteradoEm: TDateTime = DATA_ZERADA; //
      pCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;

implementation

{ TRetagInventarioItem }

constructor TRetagInventarioItem.Create(pOrdem: SmallInt; pProd: IProd;
  pQtd: Currency; pCriadoEm: TDateTime; pCancelado: Boolean; pAlteradoEm,
  pCanceladoEm: TDateTime);
begin
  inherited;
end;

end.
