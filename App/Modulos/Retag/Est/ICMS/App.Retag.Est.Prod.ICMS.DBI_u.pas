unit App.Retag.Est.Prod.ICMS.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.ICMS.Ent, Sis.UI.Frame.Bas.FiltroParams_u, App.Retag.Est.Prod.ICMS.DBI;

type
  TProdICMSDBI = class(TEntDBI, IProdICMSDBI)
  private
    FProdICMSEnt: IProdICMSEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pIds: variant); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntEd: IProdICMSEnt);
    function AtivoSet(pIcmsId: smallint; pValor: boolean): boolean;
  end;

implementation

uses System.SysUtils, App.Retag.Est.Prod.ICMS.Ent_u, Sis.Types.strings_u,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TProdICMSDBI }

function TProdICMSDBI.AtivoSet(pIcmsId: smallint; pValor: boolean): boolean;
var
  sFormat: string;
  sSql: string;
  sId, sVal: string;
begin
  sId := pIcmsId.ToString;
  sVal := BooleanToSQL(pValor);
  sFormat := 'EXECUTE PROCEDURE ICMS_PA.ATIVO_SET(%s, %s);';
  sSql := Format(sFormat, [sid, sval]);

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    DBConnection.ExecuteSQL(sSql);
  finally
    DBConnection.Fechar;
  end;
end;

constructor TProdICMSDBI.Create(pDBConnection: IDBConnection;
  pEntEd: IProdICMSEnt);
begin
  inherited Create(pDBConnection);
  FProdICMSEnt := TProdICMSEnt(pEntEd);
end;

function TProdICMSDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
  sId, sSigla, sDescr, sPerc, sAtivo: string;
begin
  sId := FProdICMSEnt.Id.ToString;
  sSigla := QuotedStr(FProdICMSEnt.Sigla);
  sDescr := QuotedStr(FProdICMSEnt.Descr);
  sPerc := CurrencyToStrPonto(FProdICMSEnt.Perc);
  sAtivo := BooleanToSQL(FProdICMSEnt.Ativo);

  sFormat := 'SELECT ICMS_ID_GRAVADO' +
    ' FROM ICMS_PA.ICMS_GARANTIR(%s,%s,%s,%s,%s);';
  Result := Format(sFormat, [sId, sSigla, sDescr, sPerc, sAtivo]);
end;

function TProdICMSDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  cPerc: currency;
  sPerc: string;
begin
  cPerc := vartocurrency(pValues);
  sPerc := floatToStrponto(pValues);
  sFormat := 'SELECT ICMS_ID FROM ICMS_PA.BYPERC_GET(%s);';
  Result := Format(sFormat, [sPerc]);
end;

function TProdICMSDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT ICMS_ID, SIGLA, DESCR, PERC, ATIVO FROM ICMS_PA.LISTA_GET;';
end;

procedure TProdICMSDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdICMSEnt.Id := VarToInteger(pIds);
end;

end.
