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
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u,
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
    ' FROM PROD_PA.LISTA_GET;';
end;

function TProdDBI.InsertInto: integer;
var
  sSql: string;
  sMens: string;
  bResultado: Boolean;
begin
  Result := 0;

  sSql := 'SELECT PROD_ID FROM PROD_PA.INSERT_INTO_PROD('
    + QuotedStr(FProdEnt.Descr)
    +','+ QuotedStr(FProdEnt.DescrRed)

    +','+ FProdEnt.ProdFabrEnt.Id.ToString
    +','+ FProdEnt.ProdTipoEnt.Id.ToString
    +','+ FProdEnt.ProdUnidEnt.Id.ToString
    +','+ FProdEnt.ProdICMSEnt.Id.ToString

    +','+ CurrencyToStrPonto(FProdEnt.CapacEmb)
    +','+ FProdEnt.Loja.Id.ToString
    +','+ BooleanToStrSql( FProdEnt.Ativo)
    +','+ QuotedStr(FProdEnt.Localiz)
    +','+ FProdEnt.ProdBalancaEnt.BalancaTipoStr
    +','+ QuotedStr(FProdEnt.ProdBalancaEnt.DptoCod.ToString)
    +','+ FProdEnt.ProdBalancaEnt.ValidadeDias.ToString
    +','+ QuotedStr(FProdEnt.ProdBalancaEnt.TextoEtiq)
    +','+ QuotedStr(FProdEnt.ProdBarrasList.AsStringCSV)
    +');';

  SetClipboardText(sSql);

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

procedure TProdDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdEnt.Id := VarToInteger(pIds);
end;

end.
