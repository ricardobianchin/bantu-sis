unit App.DB.Term.EnviarTabela_u;

interface

uses Sis.Sis.Executavel_u, Sis.DB.DBTypes, App.DB.Term.EnviarTabela;

type
  TEnviarTabela = class(TExecutavel, IEnviarTabela)
  private
    FServDBConnection, FTermDBConnection: IDBConnection;
  public
    constructor Create(pServ, pTerm: IDBConnection);
    function Execute: Boolean;
  end;

implementation

{ TEnviarTabela }

constructor TEnviarTabela.Create(pServ, pTerm: IDBConnection);
begin
  inherited Create;
  FServDBConnection := pServ;
  FTermDBConnection := pTerm;
end;

function TEnviarTabela.Execute: Boolean;
begin

end;

end.
