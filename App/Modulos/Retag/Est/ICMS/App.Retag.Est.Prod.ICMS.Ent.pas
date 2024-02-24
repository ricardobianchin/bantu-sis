unit App.Retag.Est.Prod.ICMS.Ent;

interface

uses App.Ent.Ed.Id;

type
  IProdICMSEnt = interface(IEntEdId)
    ['{6D9D8C9E-99B0-494D-9241-C918627EC2C2}']
    function GetSigla: string;
    procedure SetSigla(Value: string);
    property Sigla: string read GetSigla write SetSigla;

    function GetDescr: string;
    procedure SetDescr(Value: string);
    property Descr: string read GetDescr write SetDescr;

    function GetPerc: currency;
    procedure SetPerc(Value: currency);
    property Perc: currency read GetPerc write SetPerc;

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);
    property Ativo: Boolean read GetAtivo write SetAtivo;
  end;

implementation

end.
