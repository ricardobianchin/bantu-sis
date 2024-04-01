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

begin
//  siscon
  Result := 0;
  {
  sSql := 'SELECT PROD_ID FROM PROD_PA.INSERT_INTO_PROD('
   + QuotedStr(FProdEnt.Descr) + ','
   + QuotedStr(FProdEnt.DescrRed) + ','
   + FProdEnt.ProdFabrEnt.Id.ToString + ','
   + FProdEnt.ProdTipoEnt.Id.ToString + ','
   + FProdEnt.ProdUnidEnt.Id.ToString + ','
   + FProdEnt.ProdICMSEnt.Id.ToString + ','
   + CurrencyToStrPonto(FProdEnt.CapacEmb) + ','
 }{

1.2, --CAPAC_EMB         INPUT NUMERIC(8, 3)
1, --LOJA_ID           INPUT (ID_SHORT_DOM) SMALLINT
TRUE, --ATIVO             INPUT BOOLEAN
'LO', --LOCALIZ           INPUT (NOME_CURTO_DOM) VARCHAR(15) CHARACTER SET WIN1252
2, --BAL_USO           INPUT SMALLINT
'001', --BAL_DPTO          INPUT CHAR(3) CHARACTER SET WIN1252
27, --BAL_VALIDADE_DIAS INPUT SMALLINT
'TEXTO',--BAL_TEXTO_ETIQ    INPUT VARCHAR(400) CHARACTER SET WIN1252
'78911111;78922222;78933333'
);


EXECUTE PROCEDURE PROD_PA.INSERT_INTO_PROD  (
'AA',--DESCR             INPUT (PROD_DESCR_DOM) VARCHAR(120) CHARACTER SET WIN1252
'A', --DESCR_RED         INPUT (PROD_DESCR_RED_DOM) VARCHAR(29) CHARACTER SET WIN1252
1, --FABR_ID           INPUT (ID_SHORT_NOTN_DOM) SMALLINT
1, --PROD_TIPO_ID      INPUT (ID_SHORT_NOTN_DOM) SMALLINT
1, --UNID_ID           INPUT (ID_SHORT_NOTN_DOM) SMALLINT
1, --ICMS_ID           INPUT (ID_SHORT_NOTN_DOM) SMALLINT
1.2, --CAPAC_EMB         INPUT NUMERIC(8, 3)
1, --LOJA_ID           INPUT (ID_SHORT_DOM) SMALLINT
TRUE, --ATIVO             INPUT BOOLEAN
'LO', --LOCALIZ           INPUT (NOME_CURTO_DOM) VARCHAR(15) CHARACTER SET WIN1252
2, --BAL_USO           INPUT SMALLINT
'001', --BAL_DPTO          INPUT CHAR(3) CHARACTER SET WIN1252
27, --BAL_VALIDADE_DIAS INPUT SMALLINT
'TEXTO',--BAL_TEXTO_ETIQ    INPUT VARCHAR(400) CHARACTER SET WIN1252
'78911111;78922222;78933333'
);



}

end;

procedure TProdDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdEnt.Id := VarToInteger(pIds);
end;

end.
