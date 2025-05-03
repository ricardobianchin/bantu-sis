unit App.Retag.Est.EstSaida.Ent;

interface

uses App.Est.EstMovEnt, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.DB.DBTypes, App.Retag.Est.EstSaidaItem;

type
  IEstSaidaEnt = interface(IEstMovEnt<IRetagEstSaidaItem>)
    ['{6CA79337-D0A6-41CA-96A4-08958F95FE2E}']

    function GetEstSaidaId: TId;
    procedure SetEstSaidaId(Value: TId);
    property EstSaidaId: TId read GetEstSaidaId write SetEstSaidaId;

    function GetSaidaMotivoId: TId;
    procedure SetSaidaMotivoId(Value: TId);
    property SaidaMotivoId: TId read GetSaidaMotivoId write SetSaidaMotivoId;

    function GetCod(pSeparador: string = '-'): string;
  end;

implementation

end.
