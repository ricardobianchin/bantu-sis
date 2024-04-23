unit AppShop.Import.Origem.PLUBase_u;

interface

uses App.DB.Import.Origem;

type
  TDBImportOrigemPLUBase = class(TInterfacedObject, IDBImportOrigem)
  private
    FNomeArq: string;
  public
    function PodeImportar: boolean;
  end;

implementation

{ TDBImportOrigemPLUBase }

uses Sis.Types.strings_u, System.SysUtils;

function TDBImportOrigemPLUBase.PodeImportar: boolean;
begin
//  FNomeArq := VarToString(Value);

//  Result := FileExists(FNomeArq);
//  Output.Exibir('Arquivo PLUBase: ' + FNomeArq);
//  if not Result then
//  begin
//    Output.ExibirPausa('Erro: Arquivo não encontrado: ['+FNomeArq+']');
//    exit;
//  end;

end;

end.
