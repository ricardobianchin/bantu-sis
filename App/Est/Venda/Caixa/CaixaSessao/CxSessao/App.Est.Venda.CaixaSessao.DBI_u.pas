unit App.Est.Venda.CaixaSessao.DBI_u;

interface

uses Sis.DBI_u, App.Est.Venda.CaixaSessao.DBI, Sis.DB.DBTypes, Sis.Usuario,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.Est.Venda.CaixaSessaoRecord_u, Sis.Entities.Terminal, Sis.Entidade,
  Sis.Entities.Types, Data.DB;

type
  /// <summary>
  /// TCaixaSessaoDBI é uma classe que implementa as funcionalidades de sessão de caixa.
  /// </summary>
  TCaixaSessaoDBI = class(TDBI, ICaixaSessaoDBI)
  private
    /// <summary>
    /// Identificação da loja.
    /// </summary>
    FLojaId: TLojaId;
    /// <summary>
    /// Identificação do terminal.
    /// </summary>
    FTerminalId: TTerminalId;
    /// <summary>
    /// Identificação da máquina.
    /// </summary>
    FMachineIdentId: smallint;
    /// <summary>
    /// Usuário logado no sistema.
    /// </summary>
    FLogUsuario: IUsuario;
    /// <summary>
    /// Mensagem associada à sessão de caixa.
    /// </summary>
    FMensagem: string;
    /// <summary>
    /// Obtém a mensagem associada à sessão de caixa.
    /// </summary>
    function GetMensagem: string;
  public
    /// <summary>
    /// Construtor da classe TCaixaSessaoDBI.
    /// </summary>
    /// <param name="pDBConnection">Conexão com o banco de dados.</param>
    /// <param name="pLogUsuario">Usuário logado no sistema.</param>
    /// <param name="pLojaId">Identificação da loja.</param>
    /// <param name="pTerminalId">Identificação do terminal.</param>
    /// <param name="pMachineIdentId">Identificação da máquina.</param>
    constructor Create(pDBConnection: IDBConnection; pLogUsuario: IUsuario;
      pLojaId: TLojaId; pTerminalId: TTerminalId; pMachineIdentId: smallint);
      reintroduce;
    /// <summary>
    /// Verifica se a sessão de caixa está aberta.
    /// </summary>
    /// <param name="pCaixaSessaoRec">Registro da sessão de caixa.</param>
    /// <returns>Retorna true se a sessão estiver aberta; caso contrário, false.</returns>
    function CaixaSessaoAbertoGet(var pCaixaSessaoRec: TCaixaSessaoRec): Boolean;
    /// <summary>
    /// Propriedade que obtém a mensagem associada à sessão de caixa.
    /// </summary>
    property Mensagem: string read GetMensagem;
  end;

implementation

uses Sis.Win.Utils_u;

{ TCaixaSessaoDBI }

function TCaixaSessaoDBI.CaixaSessaoAbertoGet(var pCaixaSessaoRec
  : TCaixaSessaoRec): Boolean;
var
  sSql: string;
  q: TDataSet;
begin
  pCaixaSessaoRec.Zerar;

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    sSql :=
      'SELECT'#13#10
      +'SESS_ID'#13#10 // 0
      +', PESSOA_ID'#13#10 // 1
      +', APELIDO'#13#10 // 2
      +', ABERTO_EM'#13#10 // 3
      +'FROM CAIXA_SESSAO_MANUT_PA.ABERTO_GET'#13#10
      ;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
    DBConnection.QueryDataSet(sSql, q);

    Result := Assigned(q);
    if not Result then
      exit;
    try
      Result := not q.IsEmpty;

      if not Result then
        exit;

      pCaixaSessaoRec.SessId := q.Fields[0].AsInteger;
      pCaixaSessaoRec.PessoaId := q.Fields[1].AsInteger;
      pCaixaSessaoRec.Apelido := q.Fields[2].AsString;
      pCaixaSessaoRec.AbertoEm := q.Fields[3].AsDateTime;
      pCaixaSessaoRec.Aberto := True;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
  {
    LojaId: TLojaId;
    TerminalId: TTerminalId;
    SessId: integer;
    LogId: Int64;
    PessoaId: integer;
    Apelido: string;
    Conferido: Boolean;

  }
end;

constructor TCaixaSessaoDBI.Create(pDBConnection: IDBConnection; pLogUsuario: IUsuario;
      pLojaId: TLojaId; pTerminalId: TTerminalId; pMachineIdentId: smallint);
begin
  inherited Create(pDBConnection);
  FLogUsuario := pLogUsuario;
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
  FMachineIdentId := pMachineIdentId;
end;

function TCaixaSessaoDBI.GetMensagem: string;
begin
  Result := FMensagem;
end;

end.
