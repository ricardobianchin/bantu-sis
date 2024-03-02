unit App.Retag.Est.Prod.Natu.Ent;

interface

type
  IProdNatuEnt = interface(IInterface)
    ['{EEC37339-D74D-4DE6-9942-0B4A004D47AD}']
    function GetId: char;
    procedure SetId(const pId: char);
    property Id: char read GetId write SetId;

    function GetNome: string;
    procedure SetNome(const Value: string);
    property Nome: string read GetNome write SetNome;
  end;

implementation

end.
