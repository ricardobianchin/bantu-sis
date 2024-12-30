unit ShopApp.UI.PDV.Venda.Frame.FitaDraw_u;

interface

uses ShopApp.UI.PDV.Venda.Frame.FitaDraw, ShopApp.PDV.Venda, Vcl.Grids, System.Types;

type
  TShopFitaDraw = class(TInterfacedObject, IShopFitaDraw)
  private
    FVenda: IShopPDVVenda;
    FStringGrid: TStringGrid;
    procedure PreenchaStringGrid;
  public
    constructor Create(pVenda: IShopPDVVenda; pStringGrid: TStringGrid);
    procedure Atualize;
    procedure FitaStringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  end;

implementation

uses Sis.Types.Bool_u;

{ TShopFitaDraw }

procedure TShopFitaDraw.Atualize;
begin
  PreenchaStringGrid;
end;

constructor TShopFitaDraw.Create(pVenda: IShopPDVVenda;
  pStringGrid: TStringGrid);
begin
  FVenda := pVenda;
  FStringGrid := pStringGrid;
end;

procedure TShopFitaDraw.FitaStringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
{
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdRowSelected,
    gdHotTrack, gdPressed);

}
end;

procedure TShopFitaDraw.PreenchaStringGrid;
var
  iRowCount: integer;
begin
  iRowCount := Iif(FVenda.Count = 0, 1, FVenda.Count);

  FStringGrid.RowCount := iRowCount;
end;

end.
