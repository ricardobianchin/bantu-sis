unit App.Retag.Est.Prod.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Ent,
  App.Ent.Ed, App.Retag.Est.Factory;

type
  TProdDBI = class(TEntDBI)
  private
    function GetProdEnt: IProdEnt;
    property Ent: IProdEnt read GetProdEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    procedure SetVarArrayToId(pNovaId: Variant); override;
    function GetSqlInserirDoERetornaId: string; override;
    function GetSqlAlterarDo: string; override;
  public
    function Ler: boolean; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats,
  Sis.Types.Variants;

{ TProdDBI }

function TProdDBI.GetProdEnt: IProdEnt;
begin
  Result := EntEdCastToProdEnt(EntEd);
end;

function TProdDBI.GetSqlAlterarDo: string;
var
  sBarras: string;
begin
  sBarras := Ent.ProdBarrasList.GetAsString(';');

  Result := 'EXECUTE PROCEDURE PROD_PA.ALTERAR_DO(' //
    + Ent.Id.ToString //
    + ',' + QuotedStr(Ent.Descr) //
    + ',' + QuotedStr(Ent.DescrRed) //

    + ',' + Ent.ProdFabrEnt.Id.ToString //
    + ',' + Ent.ProdTipoEnt.Id.ToString //
    + ',' + Ent.ProdUnidEnt.Id.ToString //
    + ',' + Ent.ProdICMSEnt.Id.ToString //
  //
//    + ',' + ProdNatuToSql(pnatuProduto) //
    + ',' + CurrencyToStrPonto(Ent.CapacEmb) //
    + ',' + QuotedStr(Ent.NCM) //

    + ',' + Ent.LojaId.ToString //
    + ',' + Ent.UsuarioId.ToString //
    + ',' + Ent.MachineIdentId.ToString //

    + ',' + CurrencyToStrPonto(Ent.CustoNovo) //
//    + ', 1' // + 1 PROD_PRECO_TABELA_ID
    + ',' + CurrencyToStrPonto(Ent.PrecoNovo) //

    + ',' + BooleanToStrSql(Ent.Ativo) //
    + ',' + QuotedStr(Ent.Localiz) //
    + ',' + CurrencyToStrPonto(Ent.Margem) //

    + ',' + BooleanToStrSql(Ent.ProdBalancaEnt.BalancaExige) //
    + ',' + QuotedStr(Ent.ProdBalancaEnt.DptoCod) //
    + ',' + Ent.ProdBalancaEnt.ValidadeDias.ToString //
    + ',' + QuotedStr(Ent.ProdBalancaEnt.TextoEtiq) //

    + ',' + QuotedStr(sBarras) //
    + ');';
end;

function TProdDBI.GetSqlInserirDoERetornaId: string;
var
  sBarras: string;
begin
  sBarras := Ent.ProdBarrasList.GetAsString(';');

  Result := 'SELECT PROD_ID FROM PROD_PA.INSERIR_DO('//
    + QuotedStr(Ent.Descr) //
    + ',' + QuotedStr(Ent.DescrRed) //

    + ',' + Ent.ProdFabrEnt.Id.ToString //
    + ',' + Ent.ProdTipoEnt.Id.ToString //
    + ',' + Ent.ProdUnidEnt.Id.ToString //
    + ',' + Ent.ProdICMSEnt.Id.ToString //

    + ',' + CurrencyToStrPonto(Ent.CapacEmb) //
    + ',' + QuotedStr(Ent.NCM) //

    + ',' + Ent.LojaId.ToString //
    + ',' + Ent.UsuarioId.ToString //
    + ',' + Ent.MachineIdentId.ToString //

    + ',' + CurrencyToStrPonto(Ent.CustoNovo) //
//    + ', 1' // + 1 PROD_PRECO_TABELA_ID
    + ',' + CurrencyToStrPonto(Ent.PrecoNovo) //

    + ',' + BooleanToStrSql(Ent.Ativo) //
    + ',' + QuotedStr(Ent.Localiz) //
    + ',' + CurrencyToStrPonto(Ent.Margem) //

    + ',' + BooleanToStrSql(Ent.ProdBalancaEnt.BalancaExige) //
    + ',' + QuotedStr(Ent.ProdBalancaEnt.DptoCod) //
    + ',' + Ent.ProdBalancaEnt.ValidadeDias.ToString //
    + ',' + QuotedStr(Ent.ProdBalancaEnt.TextoEtiq) //

    + ',' + QuotedStr(sBarras) + ');'; //
end;

function TProdDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := 'SELECT PROD_ID, DESCR, DESCR_RED, FABR_ID, FABR_NOME' +
  // 5           6         7        8         9            10
    ', TIPO_ID, TIPO_DESCR, UNID_ID, UNID_SIGLA, ICMS_ID, ICMS_DESCR_PERC' +

  // 11
    ', COD_BARRAS' + //

    ', CUSTO, PRECO' + //

    ', ATIVO, LOCALIZ, CAPAC_EMB, MARGEM' +

    ' FROM PROD_PA.LISTA_GET(' //
    + Ent.LojaId.ToString //
    +', ' + QuotedStr(VarToString(pValues[0]))
    + ',' + BooleanToStrSql(pValues[1]) //
    + ',' + BooleanToStrSql(pValues[2]) //
    + ',' + BooleanToStrSql(pValues[3]) //
    + ',' + BooleanToStrSql(pValues[4]) //
    + ',' + BooleanToStrSql(pValues[5]) //

    + ');'; //
//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
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

  sSql := 'SELECT ' + //
    'PROD_ID' + // 0
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
    ', NCM' + // 13
    ', MARGEM' + // 14
    ', BALANCA_EXIGE' + // 15
    ', BAL_DPTO' + // 16
    ', BAL_VALIDADE_DIAS' + // 17
    ', BAL_TEXTO_ETIQ' + // 18

    ' FROM PROD_PA.LISTA_GET(' + Ent.LojaId.ToString + ')' + //
    ' WHERE PROD_ID = ' + Ent.Id.ToString + ';' //
    ;

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.isempty;
    if not Result then
      exit;

    Ent.Descr := q.Fields[1].AsString.Trim;
    Ent.DescrRed := q.Fields[2].AsString.Trim;

    Ent.ProdFabrEnt.Id := q.Fields[3].AsInteger;
    Ent.ProdTipoEnt.Id := q.Fields[4].AsInteger;
    Ent.ProdUnidEnt.Id := q.Fields[5].AsInteger;
    Ent.ProdICMSEnt.Id := q.Fields[6].AsInteger;

    Ent.CustoAtual := q.Fields[8].AsCurrency;
    Ent.PrecoAtual := q.Fields[9].AsCurrency;

    Ent.Ativo := q.Fields[10].AsBoolean;
    Ent.Localiz := q.Fields[11].AsString.Trim;
    Ent.CapacEmb := q.Fields[12].AsCurrency;

    Ent.Ncm := Trim(q.Fields[13].AsString);

    Ent.Margem := q.Fields[14].AsCurrency;

    Ent.ProdBalancaEnt.BalancaExige := q.Fields[15].AsBoolean;
    Ent.ProdBalancaEnt.DptoCod := q.Fields[16].AsString.Trim;
    Ent.ProdBalancaEnt.ValidadeDias := q.Fields[17].AsInteger;
    Ent.ProdBalancaEnt.TextoEtiq := q.Fields[18].AsString.Trim;

    Ent.ProdBarrasList.Clear;
    while not q.eof do
    begin
      Ent.ProdBarrasList.PegarBarras(q.Fields[7].AsString.Trim, plFim);
      q.next;
    end;
  finally
    q.Free;
    DBConnection.Fechar;
  end;
end;

procedure TProdDBI.SetVarArrayToId(pNovaId: Variant);
begin
//  inherited;
  Ent.Id := VarToInteger(pNovaId[0]);
end;

end.
