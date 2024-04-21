unit App.DB.Import_u;

interface

uses Sis.DB.Import_u;

type
  TAppImport = class(TDBImport)
  private
  public
    function Execute: Boolean; override;
  end;

implementation

{ TAppImport }

function TAppImport.Execute: Boolean;
begin
  Result := Inherited;
  if not Result then
    exit;
end;

end.
