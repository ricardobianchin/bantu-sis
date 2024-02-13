unit Sis.Entidade_u;

interface

uses Sis.Entidade;

type
  TEntidade = class(TInterfacedObject, IEntidade)
  public
    function EhIgualA(pOutraEntidade: IEntidade): boolean; virtual; abstract;
    procedure PegueDe(pOutraEntidade: IEntidade); virtual;
    procedure Clear; virtual;
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
