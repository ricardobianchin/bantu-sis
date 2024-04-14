unit App.Retag.Est.Prod.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Ent, Sis.UI.Frame.Bas.FiltroParams_u,
  App.Ent.Ed, App.Retag.Est.Factory;

type
  TProdDBI = class(TEntDBI)
  private
    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    procedure SetNovaId(pId: variant); override;
  public
    function Inserir(out pNovaId: variant): boolean; override;
    function Alterar: boolean; override;
    function Ler: boolean; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TProdDBI }

function TProdDBI.Alterar: boolean;
begin

end;

function TProdDBI.GetProdEnt: IProdEnt;
begin
  Result := EntEdCastToProdEnt(EntEd);
end;

function TProdDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT PROD_ID, DESCR, DESCR_RED, FABR_ID, FABR_NOME' +
  // 5           6         7        8         9            10
    ', TIPO_ID, TIPO_DESCR, UNID_ID, UNID_SIGLA, ICMS_ID, ICMS_DESCR_PERC' +

  // 11
    ', COD_BARRAS' +

    ', CUSTO, PRECO' +

    ', ATIVO, LOCALIZ, CAPAC_EMB, MARGEM' +

    ' FROM PROD_PA.LISTA_GET(' + ProdEnt.LojaId.ToString + ');';
  // SetClipboardText(Result);
end;

function TProdDBI.Inserir(out pNovaId: variant): boolean;
var
  sSql: string;
  sMens: string;
  bResultado: boolean;
  sBarras: string;
begin
  Result := False;

  sBarras := ProdEnt.ProdBarrasList.GetAsString(';');

  sSql := 'SELECT PROD_ID FROM PROD_PA.INSERT_INTO_PROD(' +
    QuotedStr(ProdEnt.Descr) + ',' + QuotedStr(ProdEnt.DescrRed)

    + ',' + ProdEnt.ProdFabrEnt.Id.ToString //
    + ',' + ProdEnt.ProdTipoEnt.Id.ToString //
    + ',' + ProdEnt.ProdUnidEnt.Id.ToString //
    + ',' + ProdEnt.ProdICMSEnt.Id.ToString //
  //
    + ',' + ProdNatuToSql(pnatuProduto) //
    + ',' + CurrencyToStrPonto(ProdEnt.CapacEmb) //

    + ',' + ProdEnt.LojaId.ToString //
    + ',' + ProdEnt.UsuarioId.ToString //
    + ',' + ProdEnt.MachineIdentId.ToString //

    + ',' + CurrencyToStrPonto(ProdEnt.CustoNovo) //
    + ', 1' // + 1 PROD_PRECO_TABELA_ID
    + ',' + CurrencyToStrPonto(ProdEnt.PrecoNovo) //

    + ',' + BooleanToStrSql(ProdEnt.Ativo) //
    + ',' + QuotedStr(ProdEnt.Localiz) //
    + ',' + CurrencyToStrPonto(ProdEnt.Margem) //

    + ',' + ProdEnt.ProdBalancaEnt.BalancaTipoStr //
    + ',' + QuotedStr(ProdEnt.ProdBalancaEnt.DptoCod) //
    + ',' + ProdEnt.ProdBalancaEnt.ValidadeDias.ToString //
    + ',' + QuotedStr(ProdEnt.ProdBalancaEnt.TextoEtiq) //

    + ',' + QuotedStr(sBarras) + ');'; //

{$IFDEF DEBUG}
  SetClipboardText(sSql);
{$ENDIF}
  bResultado := DBConnection.Abrir;
  if not bResultado then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;
  try
    pNovaId := DBConnection.GetValueInteger(sSql);
  finally
    DBConnection.Fechar;
    Result := True;
  end;
end;

function TProdDBI.Ler: boolean;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: variant;
  sResultado: string;
  iId: integer;
  sNome: string;
begin
  Result := False;

  sSql := 'SELECT ' + 'PROD_ID' + // 0
    ', DESCR' + // 1
    ', DESCR_RED' + // 2
    ', FABR_ID' + // 3
    ', TIPO_ID' + // 4
    ', UNID_ID' + // 5
    ', ICMS_ID' + // 6
    ', COD_BARRAS' + // 7
    ', CUSTO' + // 8
    ', PRECO' + // 9
    ', ATIVO' + // 10
    ', LOCALIZ' + // 11
    ', CAPAC_EMB' + // 12
    ', MARGEM' + // 13
    ', BAL_USO' + // 14
    ', BAL_DPTO' + // 15
    ', BAL_VALIDADE_DIAS' + // 16
    ', BAL_TEXTO_ETIQ' + // 17

    ' FROM PROD_PA.LISTA_GET(' + ProdEnt.LojaId.ToString + ')' +
    ' WHERE PROD_ID = ' + ProdEnt.Id.ToString + ';';

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.isempty;
    if not Result then
      exit;

    ProdEnt.Descr := q.Fields[1].AsString.Trim;
    ProdEnt.DescrRed := q.Fields[2].AsString.Trim;

    ProdEnt.ProdFabrEnt.Id := q.Fields[3].AsInteger;
    ProdEnt.ProdTipoEnt.Id := q.Fields[4].AsInteger;
    ProdEnt.ProdUnidEnt.Id := q.Fields[5].AsInteger;
    ProdEnt.ProdICMSEnt.Id := q.Fields[6].AsInteger;

    ProdEnt.CustoAtual := q.Fields[8].AsCurrency;
    ProdEnt.PrecoAtual := q.Fields[9].AsCurrency;

    ProdEnt.Ativo := q.Fields[10].AsBoolean;
    ProdEnt.Localiz := q.Fields[11].AsString.Trim;
    ProdEnt.CapacEmb := q.Fields[12].AsCurrency;
    ProdEnt.Margem := q.Fields[13].AsCurrency;

    ProdEnt.ProdBalancaEnt.BalancaTipo := TBalancaTipo(q.Fields[14].AsInteger);
    ProdEnt.ProdBalancaEnt.DptoCod := q.Fields[15].AsString.Trim;
    ProdEnt.ProdBalancaEnt.ValidadeDias := q.Fields[16].AsInteger;
    ProdEnt.ProdBalancaEnt.TextoEtiq := q.Fields[17].AsString.Trim;

    ProdEnt.ProdBarrasList.Clear;
    while not q.eof do
    begin
      ProdEnt.ProdBarrasList.PegarBarras(q.Fields[7].AsString.Trim, plFim);
      q.next;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TProdDBI.SetNovaId(pId: variant);
begin
  inherited;
  ProdEnt.Id := VarToInteger(pId);
end;

end.
