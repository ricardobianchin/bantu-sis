unit App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Classes,
  System.Variants, Sis.Types.Integers, App.Ent.Ed, FireDAC.Comp.Client,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI, Sis.Entities.Types,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, App.Ent.DBI_u;

type
  TCxOperacaoDBI = class(TEntDBI, ICxOperacaoDBI)
  private
    FCxOperacaoEnt: ICxOperacaoEnt;
    FUsuarioId: integer;
  protected
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;
  public
    procedure FecharPodeGet(out pPode: boolean; out pMensagem: string);

    procedure PreencherPagamentoFormaDataSet(pDMemTable1: TFDMemTable);

    procedure PDVCarregarDataSet(pDMemTable1: TFDMemTable);
    procedure PreencherDespTipoSL(pSL: TStrings);

    constructor Create(pDBConnection: IDBConnection;
      pCxOperacaoEnt: ICxOperacaoEnt; pUsuarioId: integer); reintroduce;
  end;

implementation

uses System.SysUtils, App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.Types.Floats,
  Sis.Win.Utils_u, Sis.DB.Factory, Sis.Types.Dates, Sis.Types.Bool_u, Sis.DB.DataSet.Utils;

{ TCxOperacaoDBI }

constructor TCxOperacaoDBI.Create(pDBConnection: IDBConnection;
  pCxOperacaoEnt: ICxOperacaoEnt; pUsuarioId: integer);
begin
  inherited Create(pDBConnection, pCxOperacaoEnt);
  FCxOperacaoEnt := pCxOperacaoEnt;
  FUsuarioId := pUsuarioId;
end;

procedure TCxOperacaoDBI.FecharPodeGet(out pPode: boolean;
  out pMensagem: string);
const
  aMensagens: array [0 .. 3] of string = ('Mensagem não definida',
    'Pode fechar o caixa', 'Não há Caixa aberto',
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
      pMensagem := 'Operação ''Fechar o Caixa'' não pode ser executada. ' +
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

procedure TCxOperacaoDBI.PreencherDespTipoSL(pSL: TStrings);
var
  oDBQuery: IDBQuery;
  sSql: string;
begin
  pSL.Clear;
  DBConnection.Abrir;
  try
    sSql := //
      'SELECT DESPESA_TIPO_ID, DESCR'#13#10 //
      + 'FROM DESPESA_TIPO'#13#10 //
      + 'ORDER BY DESCR'#13#10 //
      ;

    oDBQuery := DBQueryCreate('CxOperaca.desptipo.lista.get.q', DBConnection,
      sSql, nil, nil);
    try
      oDBQuery.Abrir;
      while not oDBQuery.DataSet.Eof do
      begin
        pSL.AddObject(oDBQuery.DataSet.Fields[1].AsString,
          Pointer(oDBQuery.DataSet.Fields[0].AsInteger));
        oDBQuery.DataSet.Next;
      end;
    finally
      oDBQuery.Fechar;
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
