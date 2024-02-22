unit Sis.Entidade_u;

interface

uses Sis.Entidade;

type
  TEntidade = class(TInterfacedObject, IEntidade)
  protected
    function GetNomeEnt: string; virtual; abstract;
    function GetTitulo: string; virtual; abstract;
    function GetNomeEntAbrev: string; virtual; abstract;
  public
    function EhIgualA(pOutraEntidade: IEntidade): boolean; virtual; abstract;
    procedure PegueDe(pOutraEntidade: IEntidade); virtual;

    procedure LimparEnt; virtual; abstract;

    property NomeEnt: string read GetNomeEnt;
    property NomeEntAbrev: string read GetNomeEntAbrev;
    property Titulo: string read GetTitulo;
  end;

implementation

{ TEntidade }

procedure TEntidade.PegueDe(pOutraEntidade: IEntidade);
begin

end;

end.
