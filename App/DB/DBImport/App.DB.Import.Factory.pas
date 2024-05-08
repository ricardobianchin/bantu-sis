unit App.DB.Import.Factory;

interface

uses Sis.UI.IO.Input.Str;

function ImportBarEdFormCreate: IInputStr;

implementation

uses App.DB.Import.Input.Barras_u;

function ImportBarEdFormCreate: IInputStr;
begin
  Result := TImportInputBarras.Create;
end;

end.
