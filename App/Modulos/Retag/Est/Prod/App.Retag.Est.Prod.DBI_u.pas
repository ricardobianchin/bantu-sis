unit App.Retag.Est.Prod.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Ent, Sis.UI.Frame.Bas.FiltroParams_u,
  App.Retag.Est.Prod.DBI;

type
  TProdDBI = class(TEntDBI, IProdDBI)
  private
    FProdEnt: IProdEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pIds: variant); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntEd: IProdEnt);
  end;

implementation

uses System.SysUtils, App.Retag.Est.Prod.Ent_u, Sis.Types.strings_u,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TProdDBI }

constructor TProdDBI.Create(pDBConnection: IDBConnection; pEntEd: IProdEnt);
begin
  inherited Create(pDBConnection);
  FProdEnt := TProdEnt(pEntEd);
end;

function TProdDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
  sId, sDescr, sDescrRed, sFabrId, sFabrNome: string;
begin
  sId := FProdEnt.Id.ToString;
  sDescr := QuotedStr(FProdEnt.Descr);
  sDescrRed := QuotedStr(FProdEnt.DescrRed);
  sFabrId := FProdEnt.FabrId.ToString;
  sFabrNome := QuotedStr(FProdEnt.FabrNome);

  sFormat := 'SELECT ID_GRAVADO FROM PROD_PA.GARANTIR(%s,%s,%s,%s,%s);';
  Result := Format(sFormat, [sId, sDescr, sDescrRed, sFabrId, sFabrNome]);
end;

function TProdDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sDescr, sDescrRed, sFabrId: string;
begin
  sDescr := QuotedStr(VarToString(pValues[0]));
  sDescrRed := QuotedStr(VarToString(pValues[1]));
  sFabrId := StrToIntStr(VarToString(pValues[2]));
  sFormat := 'SELECT PROD_ID FROM PROD_PA.EXISTENTES_GET(%s, %s, %s);';
  Result := Format(sFormat, [sDescr, sDescrRed, sFabrId]);
end;

function TProdDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT PROD_ID, DESCR, DESCR_RED, FABR_ID, FABR_NOME'
    + ' FROM PROD_PA.LISTA_GET;';
end;

procedure TProdDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdEnt.Id := VarToInteger(pIds);
end;

end.
