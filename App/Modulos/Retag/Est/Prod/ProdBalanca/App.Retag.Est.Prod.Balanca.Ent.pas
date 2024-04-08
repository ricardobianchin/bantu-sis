unit App.Retag.Est.Prod.Balanca.Ent;

interface

uses App.Est.Types_u;

type
  IProdBalancaEnt = interface(IInterface)
    ['{2B8CB064-EE47-43EC-8F8E-214867847F60}']
    function GetBalancaTipo: TBalancaTipo;
    procedure SetBalancaTipo(Value: TBalancaTipo);
    property BalancaTipo: TBalancaTipo read GetBalancaTipo write SetBalancaTipo;

    function GetBalancaTipoStr: string;
    property BalancaTipoStr: string read GetBalancaTipoStr;

    function GetDptoCod: string;
    procedure SetDptoCod(Value: string);
    property DptoCod: string read GetDptoCod write SetDptoCod;

    function GetValidadeDias: smallint;
    procedure SetValidadeDias(Value: smallint);
    property ValidadeDias: smallint read GetValidadeDias write SetValidadeDias;

    function GetTextoEtiq: string;
    procedure SetTextoEtiq(Value: string);
    property TextoEtiq: string read GetTextoEtiq write SetTextoEtiq;

    procedure LimparEnt;
  end;

implementation

end.
