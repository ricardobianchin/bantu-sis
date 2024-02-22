unit App.Retag.Est.Prod.Unid.Ent;

interface

uses App.Ent.Ed.Id;

type
  IProdUnidEnt = interface(IEntEdId)
    ['{C4E2F62B-5E39-4B27-8FAF-89877C5A0BEB}']
    function GetDescr: string;
    procedure SetDescr(Value: string);
    property Descr: string read GetDescr write SetDescr;

    function GetSigla: string;
    procedure SetSigla(Value: string);
    property Sigla: string read GetSigla write SetSigla;
  end;

implementation

end.
