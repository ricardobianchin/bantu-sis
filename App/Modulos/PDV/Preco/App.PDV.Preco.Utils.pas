unit App.PDV.Preco.Utils;

interface

type
  TProdBuscaTipo = (prodbusProdId, prodbusBarras, prodbusDescr);

function StrToProdBuscaTipo(pStrBusca: string): TProdBuscaTipo;

implementation

uses Sis.Types.strings_u, App.Constants;

function StrToProdBuscaTipo(pStrBusca: string): TProdBuscaTipo;
var
  bSoDig: Boolean;
  L: integer;
  bEhCodBarras: Boolean;
begin
  Result := TProdBuscaTipo.prodbusDescr;
  bSoDig := StrIsOnlyDigit(pStrBusca);
  if bSoDig then
  begin
    L := Length(pStrBusca);

    bEhCodBarras := L > PROD_ID_MAX_LEN;
    if bEhCodBarras then
    begin
      Result := TProdBuscaTipo.prodbusBarras;
      exit;
    end;

    Result := TProdBuscaTipo.prodbusProdId;
  end;
end;

end.
