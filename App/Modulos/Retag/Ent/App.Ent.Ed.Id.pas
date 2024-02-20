unit App.Ent.Ed.Id;

interface

uses App.Ent.Ed;

type
  IEntEdId = interface(IEntEd)
    ['{BACDF5CF-66E3-42E5-9E2D-E94272879D9E}']
    function GetId: integer;
    procedure SetId(Value: integer);
    property Id: integer read GetId write SetId;

    function GetAsString: string;
    property AsString: string read GetAsString;
  end;

implementation

end.
