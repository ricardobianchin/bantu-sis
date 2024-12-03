unit App.Retag.Est.Prod.ICMS.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.ICMS.Ent, App.Ent.Ed;

type
  TProdICMSDBI = class(TEntDBI)
  private
    function GetProdICMSEnt: IProdICMSEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGaranteRegERetornaId: string; override;
    procedure SetVarArrayToId(pNovaId: Variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats,
  App.Retag.Est.Factory;

{ TProdICMSDBI }

function TProdICMSDBI.GetPackageName: string;
begin
  Result := 'ICMS_PA';
end;

function TProdICMSDBI.GetProdICMSEnt: IProdICMSEnt;
begin
  Result := EntEdCastToProdICMSEnt(EntEd);
end;

function TProdICMSDBI.GetSqlGaranteRegERetornaId: string;
var
  sFormat: string;
  sId, sSigla, sDescr, sPerc, sAtivo: string;
begin
  sId := GetProdICMSEnt.Id.ToString;
  sSigla := QuotedStr(GetProdICMSEnt.Sigla);
  sDescr := QuotedStr(GetProdICMSEnt.Descr);
  sPerc := CurrencyToStrPonto(GetProdICMSEnt.Perc);
  sAtivo := BooleanToStrSQL(GetProdICMSEnt.Ativo);

  sFormat := 'SELECT ID_GRAVADO FROM ICMS_PA.GARANTIR(%s,%s,%s,%s,%s);';
  Result := Format(sFormat, [sId, sSigla, sDescr, sPerc, sAtivo]);
end;

function TProdICMSDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  cPerc: currency;
  sPerc: string;
begin
  cPerc := vartocurrency(pValues[0]);
  sPerc := floatToStrponto(cPerc);
  sFormat := 'SELECT ICMS_ID FROM ICMS_PA.BYPERC_GET(%s);';
  Result := Format(sFormat, [sPerc]);
end;

function TProdICMSDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := 'SELECT ICMS_ID, SIGLA, DESCR, PERC, ATIVO FROM ICMS_PA.LISTA_GET;';
end;

procedure TProdICMSDBI.SetVarArrayToId(pNovaId: Variant);
begin
  inherited;
  GetProdICMSEnt.Id := VarToInteger(pNovaId[0]);
end;

end.
