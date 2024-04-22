unit ShopApp.DB.Import_u;

interface

uses App.DB.Import_u;

type
  TShopAppImport = class(TAppImport)
  private
  public
    function Execute: Boolean; override;
  end;

implementation

end.
