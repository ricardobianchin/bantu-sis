unit App.DB.Term.EnviarDados_u;

interface

uses App.DB.Term.EnviarDados, Sis.Sis.Executavel_u, Sis.DB.DBTypes, Sis.Entities.Types;

type
  TTermEnviarDados = class(TExecutavel, ITermEnviarDados)
  private
    FServDBConnection, FTermDBConnection: IDBConnection;
    FTerminalId: TTerminalId;
  public
    constructor Create(pServ, pTerm: IDBConnection; pTerminalId: TTerminalId);
    function Execute: Boolean;
  end;


implementation

{ TTermEnviarDados }

uses App.DB.Term.EnviarTabela, App.DB.Term.EnviarDados.Factory_u;

constructor TTermEnviarDados.Create(pServ, pTerm: IDBConnection; pTerminalId: TTerminalId);
begin
  inherited Create;
  FServDBConnection := pServ;
  FTermDBConnection := pTerm;
  FTerminalId := pTerminalId;
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

    EnvTabTerminal(FServDBConnection, FTermDBConnection, FTerminalId).Execute;
    EnvTabPagamentoFormaTipo(FServDBConnection, FTermDBConnection).Execute;
    EnvTabPagamentoForma(FServDBConnection, FTermDBConnection).Execute;
    EnvTabLoja(FServDBConnection, FTermDBConnection).Execute;
    EnvTabPessoa(FServDBConnection, FTermDBConnection).Execute;
    EnvTabEndereco(FServDBConnection, FTermDBConnection).Execute;
    EnvTabFuncionario(FServDBConnection, FTermDBConnection).Execute;
    EnvTabLojaEhPessoa(FServDBConnection, FTermDBConnection).Execute;
    EnvTabUsuario(FServDBConnection, FTermDBConnection).Execute;
    EnvTabUsuarioPodeOpcaoSis(FServDBConnection, FTermDBConnection).Execute;
    EnvTabProd(FServDBConnection, FTermDBConnection).Execute;
    EnvTabProdBarras(FServDBConnection, FTermDBConnection).Execute;

  finally
    FServDBConnection.Fechar;
    FTermDBConnection.Fechar;
  end;

end;

end.
