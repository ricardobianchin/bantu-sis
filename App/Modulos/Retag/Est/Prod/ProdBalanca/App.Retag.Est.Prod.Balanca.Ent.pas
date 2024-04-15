unit App.Retag.Est.Prod.Balanca.Ent;

interface

uses App.Est.Types_u;

type
  IProdBalancaEnt = interface(IInterface)
    ['{2B8CB064-EE47-43EC-8F8E-214867847F60}']
    function GetBalancaUso: TBalancaUso;
    procedure SetBalancaUso(Value: TBalancaUso);
    property BalancaUso: TBalancaUso read GetBalancaUso write SetBalancaUso;

    function GetBalancaUsoStr: string;
    property BalancaUsoStr: string read GetBalancaUsoStr;

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
