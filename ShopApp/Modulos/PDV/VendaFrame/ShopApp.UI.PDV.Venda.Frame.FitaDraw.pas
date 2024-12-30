unit ShopApp.UI.PDV.Venda.Frame.FitaDraw;

interface

uses Sis.Sis.Atualizavel, ShopApp.PDV.Venda, Vcl.Grids, System.Types;

type
  IShopFitaDraw = interface(IAtualizavel)
    ['{0867312F-2954-4B4A-ABFB-E4DDAC4EE87D}']
    procedure FitaStringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  end;

implementation

end.
