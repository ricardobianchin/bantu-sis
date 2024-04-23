unit ShopApp.DB.Import_u;

interface

uses App.DB.Import_u;

type
  TShopDBImport = class(TDBImport)
  private
  public
    function Execute: Boolean; override;
  end;

implementation

{ TShopDBImport }

function TShopDBImport.Execute: Boolean;
begin
  result := Inherited;
end;

end.
