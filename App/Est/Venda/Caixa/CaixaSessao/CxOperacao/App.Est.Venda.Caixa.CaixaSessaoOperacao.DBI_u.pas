unit App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Classes,
  System.Variants, Sis.Types.Integers,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, App.Ent.DBI_u,
  Sis.Entities.Types;

type
  TCxOperacaoDBI = class(TEntDBI, ICxOperacaoDBI)
  private
    FCxOperacaoEnt: ICxOperacaoEnt;
  protected
    function GetSqlInserirDoERetornaId: string; override;

    procedure SetVarArrayToId(pNovaId: variant); override;
    procedure RegAtualToEnt(Q: TDataSet); virtual;
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;
  public
    function Ler: boolean; override;
    constructor Create(pDBConnection: IDBConnection;
      pCxOperacaoEnt: ICxOperacaoEnt);
  end;

implementation

uses System.SysUtils, App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.Types.Floats;

{ TCxOperacaoDBI }

constructor TCxOperacaoDBI.Create(pDBConnection: IDBConnection;
  pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pDBConnection, pCxOperacaoEnt);
  FCxOperacaoEnt := pCxOperacaoEnt;
end;

function TCxOperacaoDBI.GetFieldNamesListaGet: string;
begin

end;

function TCxOperacaoDBI.GetFieldValuesGravar: string;
begin

end;

function TCxOperacaoDBI.GetSqlInserirDoERetornaId: string;
begin
  Result := 'SELECT '#13#10 + 'SESS_ID_RET'#13#10 + ', OPER_ORDEM_RET'#13#10 +
    ', OPER_LOG_ID_RET'#13#10 + ', OPER_TIPO_ORDEM_RET'#13#10 +
    'FROM CAIXA_SESSAO_OPERACAO_INSERIR_DO'#13#10 + '('#13#10 + '  ' +
    FCxOperacaoEnt.LojaId.ToString // LOJA_ID ID_SHORT_DOM NOT NULL
    + '  , ' + FCxOperacaoEnt.TerminalId.ToString // TERMINAL_ID ID_SHORT_DOM NOT NULL
    + '  , ' + FCxOperacaoEnt.CaixaSessao.Id.ToString // SESS_ID ID_DOM
    + '  , ' + FCxOperacaoEnt.OperOrdem.ToString // OPER_ORDEM SMALLINT
    + '  , ' + FCxOperacaoEnt.CxOperacaoTipo.Id.ToSqlConstant // OPER_TIPO_ID ID_CHAR_DOM Not Null
    + '  , ' + FCxOperacaoEnt.LogId.ToString // OPER_LOG_ID BIGINT
    + '  , ' + FCxOperacaoEnt.OperTipoOrdem.ToString // OPER_TIPO_ORDEM SMALLINT
    + '  , ' + CurrencyToStrPonto(FCxOperacaoEnt.Valor) // VALOR PRECO_DOM Not Null
    + '  , ' + QuotedStr(FCxOperacaoEnt.obs) // OBS OBS_DOM
    + '  , ' + FCxOperacaoEnt.CaixaSessao.LogUsuario.Id.ToString // LOG_PESSOA_ID ID_DOM
    + '  , ' + FCxOperacaoEnt.CaixaSessao.MachineIdentId.ToString // MACHINE_ID ID_SHORT_DOM
    + '  , ' + QuotedStr('1,' + CurrencyToStrPonto(FCxOperacaoEnt.Valor)) // PAGAMENTO_LIST VARCHAR(300)
    + '  , ' + '''' // NUMERARIO_LIST VARCHAR(300)
    + ');' //
    ;
end;

function TCxOperacaoDBI.Ler: boolean;
begin

end;

procedure TCxOperacaoDBI.RegAtualToEnt(Q: TDataSet);
begin

end;

procedure TCxOperacaoDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;

end;

end.
