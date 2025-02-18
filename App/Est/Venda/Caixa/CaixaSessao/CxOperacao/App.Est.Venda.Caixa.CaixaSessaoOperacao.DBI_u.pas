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
    procedure FecharPodeGet(out pPode: boolean; pMensagem: string);
    constructor Create(pDBConnection: IDBConnection;
      pCxOperacaoEnt: ICxOperacaoEnt);
  end;

implementation

uses System.SysUtils, App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.Types.Floats,
  Sis.Win.Utils_u, Sis.DB.Factory;

{ TCxOperacaoDBI }

constructor TCxOperacaoDBI.Create(pDBConnection: IDBConnection;
  pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pDBConnection, pCxOperacaoEnt);
  FCxOperacaoEnt := pCxOperacaoEnt;
end;

procedure TCxOperacaoDBI.FecharPodeGet(out pPode: boolean; pMensagem: string);
var
  sSql: string;
  oDBQuery: IDBQuery;
begin
  sSql := 'SELECT PODE, MENSAGEM'#13#10 //
    + 'FROM CAIXA_SESSAO_MANUT_PA.FECHAR_PODE_GET;'#13#10 //
    ;

  DBConnection.Abrir;
  try
    oDBQuery := DBQueryCreate('cxoper.fecharpode.q', DBConnection, sSql,
      nil, nil);
    oDBQuery.Abrir;
    try
      pPode := oDBQuery.Fields[0].AsBoolean;
      pMensagem := oDBQuery.Fields[1].AsString;
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
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
    + '  , ' + Ent.CaixaSessao.TerminalId.ToString //
    + '  , ' + Ent.CaixaSessao.Id.ToString //
    + '  , ' + Ent.OperOrdem.ToString //
    + '  , ' + Ent.CxOperacaoTipo.Id.ToSqlConstant //
    + '  , ' + Ent.LogId.ToString //
    + '  , ' + Ent.OperTipoOrdem.ToString //
    + '  , ' + CurrencyToStrPonto(Ent.Valor) //
    + '  , ' + QuotedStr(Ent.obs) //

    + '  , ' + Ent.CaixaSessao.LogUsuario.Id.ToString //
    + '  , ' + Ent.CaixaSessao.MachineIdentId.ToString //
    + '  , ' + QuotedStr(Ent.CxValorList.AsList) //
    + '  , ' + QuotedStr(Ent.CxValorList.NumerarioAsList) //
    + ');' //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
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
