unit App.Retag.Est.Prod.Ent;

interface

uses App.Ent.Ed.Id;

type
  IProdEnt = interface(IEntEdId)
    ['{3EC0EF2F-AEA4-4D28-93E1-153CEBDE69BB}']
    function GetDescr: string;
    procedure SetDescr(Value: string);
    property Descr: string read GetDescr write SetDescr;

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);
    property DescrRed: string read GetDescrRed write SetDescrRed;

    function GetFabrId: integer;
    procedure SetFabrId(Value: integer);
    property FabrId: integer read GetFabrId write SetFabrId;

    function GetFabrNome: string;
    procedure SetFabrNome(Value: string);
    property FabrNome: string read GetFabrNome write SetFabrNome;

  end;

implementation

end.
