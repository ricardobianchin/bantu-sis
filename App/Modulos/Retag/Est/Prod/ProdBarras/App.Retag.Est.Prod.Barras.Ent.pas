unit App.Retag.Est.Prod.Barras.Ent;

interface

uses App.Ent.Ed.Id;

type
  IProdBarras = interface(IInterface)
    ['{20A47D76-68AE-4FBC-8706-2058213B25E1}']
    function GetOrdem: smallint;
    procedure SetOrdem(Value: smallInt);
    property Ordem: smallint read GetOrdem write SetOrdem;

    function GetBarras: string;
    procedure SetBarras(Value: string);
    property Barras: string read GetBarras write SetBarras;
  end;

implementation

end.
