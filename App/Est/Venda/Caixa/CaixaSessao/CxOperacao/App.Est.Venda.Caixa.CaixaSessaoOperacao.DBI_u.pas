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

uses System.SysUtils, App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.Types.Floats,
  Sis.Win.Utils_u;

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
var
  Ent: ICxOperacaoEnt;
begin
  Ent := FCxOperacaoEnt;

  Result := 'SELECT '#13#10

    + 'SESS_ID_RET'#13#10 //
    + ', OPER_ORDEM_RET'#13#10 //
    + ', OPER_LOG_ID_RET'#13#10 //
    + ', OPER_TIPO_ORDEM_RET'#13#10 //

    + 'FROM CAIXA_SESSAO_MANUT_PA.CAIXA_SESSAO_OPERACAO_INSERIR_DO'#13#10 //

    + '('#13#10 //

    + '  ' + Ent.CaixaSessao.LojaId.ToString //
    + ' -- LOJA_ID ID_SHORT_DOM NOT NULL'#13#10 //

    + '  , ' + Ent.CaixaSessao.TerminalId.ToString //
    + ' -- TERMINAL_ID ID_SHORT_DOM'#13#10 //

    + '  , ' + Ent.CaixaSessao.Id.ToString //
    + ' -- SESS_ID ID_DOM'#13#10 //

    + '  , ' + Ent.OperOrdem.ToString //
    + ' -- OPER_ORDEM SMALLINT'#13#10 //

    + '  , ' + Ent.CxOperacaoTipo.Id.ToSqlConstant //
    + ' -- OPER_TIPO_ID ID_CHAR_DOM'#13#10 //

    + '  , ' + Ent.LogId.ToString //
    + ' -- OPER_LOG_ID BIGINT'#13#10 //

    + '  , ' + Ent.OperTipoOrdem.ToString //
    + ' -- OPER_TIPO_ORDEM SMALLINT'#13#10 //

    + '  , ' + CurrencyToStrPonto(Ent.Valor) //
    + ' -- VALOR PRECO_DOM Not Null'#13#10 //

    + '  , ' + QuotedStr(Ent.obs) //
    + ' -- OBS OBS_DOM'#13#10 //

    + '  , ' + Ent.CaixaSessao.LogUsuario.Id.ToString //
    + ' -- LOG_PESSOA_ID ID_DOM'#13#10 //

    + '  , ' + Ent.CaixaSessao.MachineIdentId.ToString //
    + ' -- MACHINE_ID ID_SHORT_'#13#10 //

    + '  , ' + QuotedStr(Ent.CxValorList.AsList) //
    + ' -- PAGAMENTO_LIST VARCHAR(300)'#13#10 //

    + '  , ' + QuotedStr(Ent.CxValorList.NumerarioAsList) //
    + ' -- NUMERARIO_LIST VARCHAR(300)'#13#10 //

    + ');' //
    ;

//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
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
