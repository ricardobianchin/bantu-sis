unit App.Est.PromoItem;

interface

uses Sis.Types, App.Est.Prod;

type
  IEstPromoItem = interface(IInterface)
    ['{8215473D-DAEE-4CB1-A938-9327DCAA4C83}']
    function GetProd: IProd;
    property Prod: IProd read GetProd;

    function GetPrecoPromo: Currency;
    procedure SetPrecoPromo(Value: Currency);
    property PrecoPromo: Currency read GetPrecoPromo write SetPrecoPromo;

//    function GetAtivo: Boolean;
//    procedure SetAtivo(Value: Boolean);
//    property Ativo: Boolean read GetAtivo write SetAtivo;
end;

implementation

end.
