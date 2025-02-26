unit App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Classes,
  System.Variants, Sis.Types.Integers,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, App.Ent.DBI_u,
  Sis.Entities.Types, FireDAC.Comp.Client;

type
  TCxOperacaoDBI = class(TEntDBI, ICxOperacaoDBI)
  private
    FCxOperacaoEnt: ICxOperacaoEnt;
    function GetSqlGar: string;
  protected
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;
  public
    function Garantir: boolean;
    procedure FecharPodeGet(out pPode: boolean; out pMensagem: string);
    constructor Create(pDBConnection: IDBConnection;
      pCxOperacaoEnt: ICxOperacaoEnt);
    procedure PreencherPagamentoFormaDataSet(pDMemTable1: TFDMemTable);
    procedure PDVCarregarDataSet(pDMemTable1: TFDMemTable);
  end;

implementation

uses System.SysUtils, App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.Types.Floats,
  Sis.Win.Utils_u, Sis.DB.Factory, Sis.Types.Dates;

{ TCxOperacaoDBI }

constructor TCxOperacaoDBI.Create(pDBConnection: IDBConnection;
  pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pDBConnection, pCxOperacaoEnt);
  FCxOperacaoEnt := pCxOperacaoEnt;
end;

procedure TCxOperacaoDBI.FecharPodeGet(out pPode: boolean;
  out pMensagem: string);
const
  aMensagens: array [0 .. 3] of string = ('Mensagem não definida',
    'Pode fechar o caixa', 'Não há Sessão de Caixa aberta',
    'Há uma venda não finalizada');
var
  sSql: string;
  oDBQuery: IDBQuery;
begin
  sSql := 'SELECT PODE, MENSAGEM_ID'#13#10 //
    + 'FROM CAIXA_SESSAO_PDV_PA.FECHAR_PODE_GET;'#13#10 //
    ;

  DBConnection.Abrir;
  try
    oDBQuery := DBQueryCreate('cxoper.fecharpode.q', DBConnection, sSql,
      nil, nil);
    oDBQuery.Abrir;
    try
      pPode := oDBQuery.Fields[0].AsBoolean;
      pMensagem := 'Operação ''Fechar Sessão'' não pode ser executada. ' +
        aMensagens[oDBQuery.Fields[1].AsInteger];
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

function TCxOperacaoDBI.GetFieldNamesListaGet: string;
begin
  Result := '';
end;

function TCxOperacaoDBI.GetFieldValuesGravar: string;
begin
  Result := '';
end;

function TCxOperacaoDBI.GetSqlGar: string;
var
  Ent: ICxOperacaoEnt;
begin
  Ent := FCxOperacaoEnt;

  Result := 'SELECT'#13#10

    + 'SESS_ID_RET'#13#10 // 0
    + ', OPER_ORDEM_RET'#13#10 // 1
    + ', OPER_LOG_ID_RET'#13#10 // 2
    + ', OPER_TIPO_ORDEM_RET'#13#10 // 3
    + ', LOG_DTH'#13#10 // 4

    + 'FROM CAIXA_SESSAO_MANUT_PA.CAIXA_SESSAO_OPERACAO_INSERIR_DO'#13#10 //

    + '('#13#10 //

    + '  ' + Ent.CaixaSessao.LojaId.ToString //
    + '  , ' + Ent.CaixaSessao.TerminalId.ToString //
    + '  , ' + Ent.CaixaSessao.Id.ToString //
    + '  , null'// + Ent.OperOrdem.ToString //
    + '  , ' + Ent.CxOperacaoTipo.Id.ToSqlConstant //
    + '  , ' + Ent.LogId.ToString //
    + '  , null'// + Ent.OperTipoOrdem.ToString //
    + '  , ' + CurrencyToStrPonto(Ent.Valor) //
    + '  , ' + QuotedStr(Ent.obs) //

    + '  , ' + Ent.CaixaSessao.LogUsuario.Id.ToString //
    + '  , ' + Ent.CaixaSessao.MachineIdentId.ToString //
    + '  , ' + QuotedStr(Ent.CxValorList.AsList) //
    + '  , ' + QuotedStr(Ent.CxValorList.NumerarioAsList) //
    + ');' //
    ;

//   {$IFDEF DEBUG}
//   CopyTextToClipboard(Result);
//   {$ENDIF}
end;

function TCxOperacaoDBI.Garantir: boolean;
var
  sSql: string;
  sDt: string;
  q: TDataSet;
begin
  Result := False;
  sSql := GetSqlGar;

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    DBConnection.QueryDataSet(sSql, q);

    Result := Assigned(q);
    if not Result then
      exit;
    try
      FCxOperacaoEnt.CaixaSessao.Id := q.Fields[0].AsInteger;
      FCxOperacaoEnt.OperOrdem := q.Fields[1].AsInteger;
      FCxOperacaoEnt.LogId := q.Fields[2].AsLargeInt;
      FCxOperacaoEnt.OperTipoOrdem := q.Fields[3].AsInteger;
      sDt := q.Fields[4].AsString;
      FCxOperacaoEnt.CriadoEm := TimeStampStrToDateTime(sDt);
    finally
      q.Free;
    end;

  finally
    DBConnection.Fechar;
  end;
end;

procedure TCxOperacaoDBI.PDVCarregarDataSet(pDMemTable1: TFDMemTable);
var
  oDBQuery: IDBQuery;
  sSql: string;
begin
  DBConnection.Abrir;
  try
    sSql := //
      'SELECT FORMA_ID, DESCR'#13#10 //
      + 'FROM CAIXA_SESSAO_PDV_PA.FECH_TELA_PAGFORMA_LISTA_GET;' //
      ;

    oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
      sSql, nil, nil);
    pDMemTable1.DisableControls;
    pDMemTable1.EmptyDataSet;
    pDMemTable1.BeginBatch;
    try
      oDBQuery.Abrir;
      while not oDBQuery.DataSet.Eof do
      begin
        pDMemTable1.Append;
        pDMemTable1.Fields[0].AsInteger := oDBQuery.DataSet.Fields[0].AsInteger;
        pDMemTable1.Fields[1].AsString := oDBQuery.DataSet.Fields[1].AsString;
        pDMemTable1.Post;
        oDBQuery.DataSet.Next;
      end;
    finally
      oDBQuery.Fechar;
      pDMemTable1.First;
      pDMemTable1.EndBatch;
      pDMemTable1.EnableControls;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TCxOperacaoDBI.PreencherPagamentoFormaDataSet
  (pDMemTable1: TFDMemTable);
var
  oDBQuery: IDBQuery;
  sSql: string;
begin
  DBConnection.Abrir;
  try
    sSql := //
      'SELECT FORMA_ID, DESCR'#13#10 //
      + 'FROM CAIXA_SESSAO_PDV_PA.FECH_TELA_PAGFORMA_LISTA_GET;' //
      ;

    oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
      sSql, nil, nil);
    pDMemTable1.DisableControls;
    pDMemTable1.EmptyDataSet;
    pDMemTable1.BeginBatch;
    try
      oDBQuery.Abrir;
      while not oDBQuery.DataSet.Eof do
      begin
        pDMemTable1.Append;
        pDMemTable1.Fields[0].AsInteger := oDBQuery.DataSet.Fields[0].AsInteger;
        pDMemTable1.Fields[1].AsString := oDBQuery.DataSet.Fields[1].AsString;
        pDMemTable1.Post;
        oDBQuery.DataSet.Next;
      end;
    finally
      oDBQuery.Fechar;
      pDMemTable1.First;
      pDMemTable1.EndBatch;
      pDMemTable1.EnableControls;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

end.
