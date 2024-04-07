unit App.Retag.Est.Prod.Ent;

interface

uses App.Ent.Ed.Id, Sis.Loja
  //
  , App.Retag.Est.Prod.Fabr.Ent//
  , App.Retag.Est.Prod.Tipo.Ent//
  , App.Retag.Est.Prod.Unid.Ent//
  , App.Retag.Est.Prod.Icms.Ent//
  , App.Retag.Est.Prod.Barras.Ent.List//
  , App.Retag.Est.Prod.Balanca.Ent, Sis.Usuario//
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

    function GetProdBarrasList: IProdBarrasList;
    property ProdBarrasList: IProdBarrasList read GetProdBarrasList;

    function GetCustoAtual: double;
    procedure SetCustoAtual(Value: double);
    property CustoAtual: double read GetCustoAtual write SetCustoAtual;

    function GetCustoNovo: double;
    procedure SetCustoNovo(Value: double);
    property CustoNovo: double read GetCustoNovo write SetCustoNovo;

    function GetPrecoAtual: Currency;
    procedure SetPrecoAtual(Value: Currency);
    property PrecoAtual: Currency read GetPrecoAtual write SetPrecoAtual;

    function GetPrecoNovo: Currency;
    procedure SetPrecoNovo(Value: Currency);
    property PrecoNovo: Currency read GetPrecoNovo write SetPrecoNovo;

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

    function GetMargem: Currency;
    procedure SetMargem(Value: Currency);
    property Margem: Currency read GetMargem write SetMargem;

    function GetLoja: ILoja;
    property Loja: ILoja read GetLoja;

    function GetUsuarioId: integer;
    property UsuarioId: integer read GetUsuarioId;

    function GetMachineIdentId: smallint;
    property MachineIdentId: smallint read GetMachineIdentId;
 end;

implementation

end.
