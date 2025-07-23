unit App.Retag.Est.Saldo.Ent;

interface

uses App.Ent.Ed.Id, Sis.Loja, App.Est.Types_u, Sis.Entities.Types
  //
  , App.Retag.Est.Prod.Fabr.Ent//
  , App.Retag.Est.Prod.Tipo.Ent//
  , App.Retag.Est.Prod.Unid.Ent//
  , App.Retag.Est.Prod.Icms.Ent//
  , App.Retag.Est.Prod.Barras.Ent.List//
  , App.Retag.Est.Prod.Balanca.Ent, Sis.Usuario//
  ;

type
  IRetagSaldoEnt = interface(IEntEdId)
    ['{1DA1CC1E-7389-4E65-AAEE-C87A5645F7ED}']
    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);
    property LojaId: TLojaId read GetLojaId write SetLojaId;

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

    function GetProdBarrasList: IProdBarrasList;
    property ProdBarrasList: IProdBarrasList read GetProdBarrasList;

    function GetCustoUnit: double;
    procedure SetCustoUnit(Value: double);
    property CustoUnit: double read GetCustoUnit write SetCustoUnit;

    function GetCustoTot: double;
    procedure SetCustoTot(Value: double);
    property CustoTot: double read GetCustoTot write SetCustoTot;

    function GetPrecoUnit: Currency;
    procedure SetPrecoUnit(Value: Currency);
    property PrecoUnit: Currency read GetPrecoUnit write SetPrecoUnit;

    function GetPrecoTotal: Currency;
    procedure SetPrecoTotal(Value: Currency);
    property PrecoTotal: Currency read GetPrecoTotal write SetPrecoTotal;

    function GetProdBalancaEnt: IProdBalancaEnt;
    property ProdBalancaEnt: IProdBalancaEnt read GetProdBalancaEnt;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
    property Ativo: boolean read GetAtivo write SetAtivo;

    function GetLocaliz: string;
    procedure SetLocaliz(Value: string);
    property Localiz: string read GetLocaliz write SetLocaliz;

    function GetCapacEmb: Currency;
    procedure SetCapacEmb(Value: Currency);
    property CapacEmb: Currency read GetCapacEmb write SetCapacEmb;
 end;

implementation

end.
