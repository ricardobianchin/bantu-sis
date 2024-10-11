unit App.DB.Term.EnviarTabela_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela, Data.DB;

type
  TEnviarTabela = class(TInterfacedObject, IEnviarTabela)
  private
  protected
  public
    function Execute: Boolean; virtual;
  end;

implementation

{ TEnviarTabela }

function TEnviarTabela.Execute: Boolean;
begin
  Result := True;
end;

end.
