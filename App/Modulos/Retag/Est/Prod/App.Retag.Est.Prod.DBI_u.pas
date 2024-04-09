unit App.Retag.Est.Prod.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Ent, Sis.UI.Frame.Bas.FiltroParams_u,
  App.Retag.Est.Prod.DBI, App.Ent.Ed, App.Retag.Est.Factory;

type
  TProdDBI = class(TEntDBI, IProdDBI)
  private
    FProdEnt: IProdEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    procedure SetNovaId(pIds: variant); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntEd: IEntEd);
    function InsertInto: integer;
    function Ler: boolean; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TProdDBI }

constructor TProdDBI.Create(pDBConnection: IDBConnection; pEntEd: IEntEd);
begin
  inherited Create(pDBConnection);
  FProdEnt := EntEdCastToProdEnt(pEntEd);
end;

function TProdDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT PROD_ID, DESCR, DESCR_RED, FABR_ID, FABR_NOME' +
    //   5           6         7        8         9            10
    ', TIPO_ID, TIPO_DESCR, UNID_ID, UNID_SIGLA, ICMS_ID, ICMS_DESCR_PERC' +

   //    11
    ', COD_BARRAS' +

    ', CUSTO, PRECO' +

    ', ATIVO, LOCALIZ, CAPAC_EMB, MARGEM' +

    ' FROM PROD_PA.LISTA_GET(' + FProdEnt.LojaId.ToString + ');';
  //SetClipboardText(Result);
end;

function TProdDBI.InsertInto: integer;
var
  sSql: string;
  sMens: string;
  bResultado: Boolean;
  sBarras: string;
begin
  Result := 0;

  sBarras := FProdEnt.ProdBarrasList.GetAsString(';');

  sSql := 'SELECT PROD_ID FROM PROD_PA.INSERT_INTO_PROD(' +
    QuotedStr(FProdEnt.Descr) + ',' + QuotedStr(FProdEnt.DescrRed)

    + ',' + FProdEnt.ProdFabrEnt.Id.ToString + ',' +
    FProdEnt.ProdTipoEnt.Id.ToString + ',' + FProdEnt.ProdUnidEnt.Id.ToString +
    ',' + FProdEnt.ProdICMSEnt.Id.ToString

    + ',' + ProdNatuToSql(pnatuProduto)

    + ',' + CurrencyToStrPonto(FProdEnt.CapacEmb)

    + ',' + FProdEnt.LojaId.ToString + ',' + FProdEnt.UsuarioId.ToString + ',' +
    FProdEnt.MachineIdentId.ToString

    + ',' + CurrencyToStrPonto(FProdEnt.CustoNovo)

    + ', 1' // + 1 PROD_PRECO_TABELA_ID

    + ',' + CurrencyToStrPonto(FProdEnt.PrecoNovo)

    + ',' + BooleanToStrSql(FProdEnt.Ativo) + ',' + QuotedStr(FProdEnt.Localiz)

    + ',' + CurrencyToStrPonto(FProdEnt.Margem)

    + ',' + FProdEnt.ProdBalancaEnt.BalancaTipoStr + ',' +
    QuotedStr(FProdEnt.ProdBalancaEnt.DptoCod) + ',' +
    FProdEnt.ProdBalancaEnt.ValidadeDias.ToString + ',' +
    QuotedStr(FProdEnt.ProdBalancaEnt.TextoEtiq)

    + ',' + QuotedStr(sBarras) + ');';

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
    Result := DBConnection.GetValueInteger(sSql);
  finally
    DBConnection.Fechar;
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

  sSql :=
    'SELECT ' +
    'PROD_ID' +//0
    ', DESCR' +//1
    ', DESCR_RED' +//2
    ', FABR_ID' +//3
    ', TIPO_ID' +//4
    ', UNID_ID' +//5
    ', ICMS_ID' +//6
    ', COD_BARRAS' +//7
    ', CUSTO' +//8
    ', PRECO' +//9
    ', ATIVO' +//10
    ', LOCALIZ' +//11
    ', CAPAC_EMB' +//12
    ', MARGEM' +//13
    ', BAL_USO' +//14
    ', BAL_DPTO' +//15
    ', BAL_VALIDADE_DIAS' +//16
    ', BAL_TEXTO_ETIQ' +//17

    ' FROM PROD_PA.LISTA_GET(' + FProdEnt.LojaId.ToString +')' +
    ' WHERE PROD_ID = ' + FProdEnt.Id.ToString
    +';';

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.isempty;
    if not Result then
      exit;

    FProdEnt.Descr := Q.Fields[1].AsString.Trim;
    FProdEnt.DescrRed := Q.Fields[2].AsString.Trim;

    FProdEnt.ProdFabrEnt.Id := Q.Fields[3].AsInteger;
    FProdEnt.ProdTipoEnt.Id := Q.Fields[4].AsInteger;
    FProdEnt.ProdUnidEnt.Id := Q.Fields[5].AsInteger;
    FProdEnt.ProdICMSEnt.Id := Q.Fields[6].AsInteger;

    FProdEnt.CustoAtual := Q.Fields[8].AsCurrency;
    FProdEnt.PrecoAtual := Q.Fields[9].AsCurrency;

    FProdEnt.Ativo := Q.Fields[10].AsBoolean;
    FProdEnt.Localiz := Q.Fields[11].AsString.Trim;
    FProdEnt.CapacEmb := Q.Fields[12].AsCurrency;
    FProdEnt.Margem := Q.Fields[13].AsCurrency;

    FProdEnt.ProdBalancaEnt.BalancaTipo := TBalancaTipo(Q.Fields[14].AsInteger);
    FProdEnt.ProdBalancaEnt.DptoCod :=  Q.Fields[15].AsString.Trim;
    FProdEnt.ProdBalancaEnt.ValidadeDias := Q.Fields[16].AsInteger;
    FProdEnt.ProdBalancaEnt.TextoEtiq :=  Q.Fields[17].AsString.Trim;

    FProdEnt.ProdBarrasList.Clear;
    while not q.eof do
    begin
      FProdEnt.ProdBarrasList.PegarBarras(Q.Fields[7].AsString.Trim, plFim);
      q.next;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TProdDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdEnt.Id := VarToInteger(pIds);
end;

end.
