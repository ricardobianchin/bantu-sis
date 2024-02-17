unit Sis.Entidade_u;

interface

uses Sis.Entidade;

type
  TEntidade = class(TInterfacedObject, IEntidade)
  protected
    function GetNome: string; virtual; abstract;
    function GetTitulo: string; virtual; abstract;
  public
    function EhIgualA(pOutraEntidade: IEntidade): boolean; virtual; abstract;
    procedure PegueDe(pOutraEntidade: IEntidade); virtual;
    procedure Clear; virtual;

    property Nome: string read GetNome;
    property Titulo: string read GetTitulo;
  end;

implementation

{ TEntidade }

procedure TEntidade.Clear;
begin

end;

procedure TEntidade.PegueDe(pOutraEntidade: IEntidade);
begin

end;

end.
