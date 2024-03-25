unit Sis.Debug.DebugSteps;

interface

uses Sis.Sis.Executavel;

type
  IDebugSteps = interface(IExecutavel)
    ['{95816A7A-E939-4C99-BC37-03585C39421A}']
    function GetRootNodeName: string;
    property RootNodeName: string read GetRootNodeName;

    function GetTeclas: string;
    procedure SetTeclas(const Value: string);
    property Teclas: string read GetTeclas write SetTeclas;

    function GetNomeArqSteps: string;
    procedure SetNomeArqSteps(Values: string);
    property NomeArqSteps: string read GetNomeArqSteps write SetNomeArqSteps;
  end;

implementation

end.
