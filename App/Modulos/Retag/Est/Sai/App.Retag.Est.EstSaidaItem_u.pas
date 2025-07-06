unit App.Retag.Est.EstSaidaItem_u;

interface

uses App.Retag.Est.EstSaidaItem, App.Est.EstMovItem_u, Sis.Sis.Constants,
  App.Est.Prod;

type
  TRetagEstSaiItem = class(TEstMovItem, IRetagEstSaidaItem)
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

{ TRetagEstSaiItem }

constructor TRetagEstSaiItem.Create(pOrdem: SmallInt; pProd: IProd;
  pQtd: Currency; pCriadoEm: TDateTime; pCancelado: Boolean; pAlteradoEm,
  pCanceladoEm: TDateTime);
begin
  inherited;
end;

end.
