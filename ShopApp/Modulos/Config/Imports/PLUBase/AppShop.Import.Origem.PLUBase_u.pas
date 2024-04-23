unit AppShop.Import.Origem.PLUBase_u;

interface

uses App.DB.Import.Origem;

type
  TDBImportOrigemPLUBase = class(TInterfacedObject, IDBImportOrigem)
  private
  public
    function PodeImportar: boolean;
  end;

implementation

{ TDBImportOrigemPLUBase }

function TDBImportOrigemPLUBase.PodeImportar: boolean;
begin
  Result := true;
end;

end.
