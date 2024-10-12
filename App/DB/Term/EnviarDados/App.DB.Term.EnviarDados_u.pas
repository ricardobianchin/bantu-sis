unit App.DB.Term.EnviarDados_u;

interface

uses App.DB.Term.EnviarDados, Sis.Sis.Executavel_u, Sis.DB.DBTypes;

type
  TTermEnviarDados = class(TExecutavel, ITermEnviarDados)
  private
    FServDBConnection, FTermDBConnection: IDBConnection;
  public
    constructor Create(pServ, pTerm: IDBConnection);
    function Execute: Boolean;
  end;


implementation

{ TTermEnviarDados }

uses App.DB.Term.EnviarTabela, App.DB.Term.EnviarDados.Factory_u;

constructor TTermEnviarDados.Create(pServ, pTerm: IDBConnection);
begin
  inherited Create;
  FServDBConnection := pServ;
  FTermDBConnection := pTerm;

end;

function TTermEnviarDados.Execute: Boolean;
//var
//  oEnviarTabela: IEnviarTabela;
begin
  Result := true;
  FServDBConnection.Abrir;
  FTermDBConnection.Abrir;

  try
//    oEnviarTabela := EnvTabTerminal(FServDBConnection, FTermDBConnection);
//    oEnviarTabela.Execute;

    EnvTabTerminal(FServDBConnection, FTermDBConnection).Execute;
    EnvTabPagamentoFormaTipo(FServDBConnection, FTermDBConnection).Execute;
    EnvTabPagamentoForma(FServDBConnection, FTermDBConnection).Execute;

  finally
    FServDBConnection.Fechar;
    FTermDBConnection.Fechar;
  end;

end;

end.
