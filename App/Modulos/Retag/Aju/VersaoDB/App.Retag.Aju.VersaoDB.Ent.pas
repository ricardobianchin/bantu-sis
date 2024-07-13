unit App.Retag.Aju.VersaoDB.Ent;

interface

uses App.Ent.Ed.Id;

type
  IVersaoDBEnt = interface(IEntEdId)
    ['{32F5968B-4204-476C-8E89-2D8C2E1032E2}']
    function GetDtHIns: TDateTime;
    procedure SetDtHIns(Value: TDateTime);
    property DtHIns: TDateTime read GetDtHIns write SetDtHIns;

    function GetAssunto: string;
    procedure SetAssunto(Value: string);
    property Assunto: string read GetAssunto write SetAssunto;

    function GetObjetivo: string;
    procedure SetObjetivo(Value: string);
    property Objetivo: string read GetObjetivo write SetObjetivo;

    function GetObs: string;
    procedure SetObs(Value: string);
    property Obs: string read GetObs write SetObs;

  end;

implementation

end.
