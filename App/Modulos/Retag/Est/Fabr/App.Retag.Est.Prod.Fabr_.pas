unit App.Retag.Est.Prod.Fabr;

interface

type
  IProdFabr = interface(IInterface)
    ['{52F619A7-2E96-43AC-9A62-DB6A4F064753}']
    function GetId: smallint;
    procedure SetId(const Value: smallint);
    property Id: smallint read GetId write SetId;

    function GetNome: string;
    procedure SetNome(const Value: string);
    property Nome: string read GetNome write SetNome;

    procedure Clear;
  end;

implementation

end.
