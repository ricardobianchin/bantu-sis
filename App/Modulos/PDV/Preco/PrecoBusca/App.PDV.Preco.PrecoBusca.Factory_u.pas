unit App.PDV.Preco.PrecoBusca.Factory_u;

interface

uses Sis.DBI;

function BuscaPrecoPerg(pDBI: IDBI): Boolean;

implementation

uses App.UI.Form.PDV.Preco.Busca_u, System.SysUtils;

function BuscaPrecoPerg(pDBI: IDBI): Boolean;
var
  oForm: TPrecoBuscaForm;
begin
  oForm := TPrecoBuscaForm.Create(nil, pDBI);

  try
    Result := oForm.Perg;
  finally
    FreeAndNil(oForm);
  end;
end;

end.
