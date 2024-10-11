unit App.DB.Term.EnviarTabela.Terminal_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u;

type
  TEnviarTabelaTerminal = class(TEnviarTabela)
  private
    FServDBConnection, FTermDBConnection: IDBConnection;
  public
  end;

implementation

end.
