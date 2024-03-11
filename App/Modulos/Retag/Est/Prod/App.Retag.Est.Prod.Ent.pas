unit App.Retag.Est.Prod.Ent;

interface

uses App.Ent.Ed.Id
  //
  , App.Retag.Est.Prod.Fabr.Ent//
  , App.Retag.Est.Prod.Tipo.Ent//
  , App.Retag.Est.Prod.Unid.Ent//
  , App.Retag.Est.Prod.Icms.Ent//

  //
  , App.Retag.Est.Prod.Natu.Ent
  , App.Retag.Est.Prod.Barras.Ent.List
  ;

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

    function GetProdTipoEnt: IProdTipoEnt;
    property ProdTipoEnt: IProdTipoEnt read GetProdTipoEnt;

    function GetProdUnidEnt: IProdUnidEnt;
    property ProdUnidEnt: IProdUnidEnt read GetProdUnidEnt;

    function GetProdICMSEnt: IProdICMSEnt;
    property ProdICMSEnt: IProdICMSEnt read GetProdICMSEnt;

    function GetProdNatuEnt: IProdNatuEnt;
    property ProdNatuEnt: IProdNatuEnt read GetProdNatuEnt;

    function GetProdBarrasList: IProdBarrasList;
    property ProdBarrasList: IProdBarrasList read GetProdBarrasList;
  end;

implementation

end.
