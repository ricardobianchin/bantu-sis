unit App.Ent.Ed;

interface

uses Sis.Entidade, Data.DB;

type
  IEntEd = interface(IEntidade)
    ['{C43FB3B8-3E01-40AC-85AE-C91EAD4BCE86}']
    function GetState: TDataSetState;
    procedure SetState(Value: TDataSetState);
    property State: TDataSetState read GetState write SetState;

    function GetStateAsTitulo: string;
    property StateAsTitulo: string read GetStateAsTitulo;
  end;

implementation

end.
