unit Sis.Entidade;

interface

type
  IEntidade = interface(IInterface)
    ['{A5EA36DE-B06C-4876-96BB-B07E41FC834B}']
    function EhIgualA(pOutraEntidade: IEntidade): boolean;
    procedure PegueDe(pOutraEntidade: IEntidade);

    procedure LimparEnt;

    function GetNomeEnt: string;
    property NomeEnt: string read GetNomeEnt;

    function GetNomeEntAbrev: string;
    property NomeEntAbrev: string read GetNomeEntAbrev;

    function GetTitulo: string;
    property Titulo: string read GetTitulo;

    function GetAsStringExib: string;
    property AsStringExib: string read GetAsStringExib;
  end;


implementation

end.
