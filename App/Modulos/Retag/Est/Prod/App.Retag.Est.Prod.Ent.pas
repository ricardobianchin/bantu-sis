unit App.Retag.Est.Prod.Ent;

interface

uses App.Ent.Ed.Id, App.Retag.Est.Prod.Fabr.Ent;

type
  IProdEnt = interface(IEntEdId)
    ['{3EC0EF2F-AEA4-4D28-93E1-153CEBDE69BB}']
    function GetDescr: string;
    procedure SetDescr(Value: string);
    property Descr: string read GetDescr write SetDescr;

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);
    property DescrRed: string read GetDescrRed write SetDescrRed;

    function GetProdFabrEnt: IProdFabrEnt;
    property ProdFabrEnt: IProdFabrEnt read GetProdFabrEnt;

  end;

implementation

end.
