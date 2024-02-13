unit App.Entidade.Ed;

interface

uses Sis.Entidade, Data.DB;

type
  IEntidadeEd = interface(IEntidade)
    ['{C43FB3B8-3E01-40AC-85AE-C91EAD4BCE86}']
    function GetState: TDataSetState;
    property State: TDataSetState read GetState;
  end;

implementation

end.
