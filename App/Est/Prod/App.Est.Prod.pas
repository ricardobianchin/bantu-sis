unit App.Est.Prod;

interface

uses Sis.Types;

type
  IProd = interface(IInterface)
    ['{455B4F0D-F4FC-4A55-8E3B-D569DE171DA7}']
    function GetId: TId;
    procedure SetId(Value: TId);
    property Id: TId read GetId write SetId;

    function GetIdAsStrZero: string;
    procedure SetIdAsStrZero(const Value: string);
    property IdAsStrZero: string read GetIdAsStrZero write SetIdAsStrZero;

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);
    property DescrRed: string read GetDescrRed write SetDescrRed;

    function GetFabrNome: string;
    procedure SetFabrNome(Value: string);
    property FabrNome: string read GetFabrNome write SetFabrNome;

    function GetUnidSigla: string;
    procedure SetUnidSigla(Value: string);
    property UnidSigla: string read GetUnidSigla write SetUnidSigla;
  end;

implementation

end.
