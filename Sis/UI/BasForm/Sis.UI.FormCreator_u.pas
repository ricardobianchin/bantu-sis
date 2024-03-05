unit Sis.UI.FormCreator_u;

interface

uses Sis.UI.FormCreator, VCL.Forms, System.Classes;

type
  TFormCreator = class(TInterfacedObject, IFormCreator)
  private
    FFormClass: TFormClass;
    function GetFormClass: TFormClass;
  protected
    property FormClass: TFormClass read GetFormClass;
  public
    function FormCreate(AOwner: TComponent): TForm; virtual;
    constructor Create(pFormClass: TFormClass);
  end;


implementation

{ TFormCreator }

constructor TFormCreator.Create(pFormClass: TFormClass);
begin
  FFormClass := pFormClass;
end;

function TFormCreator.FormCreate(AOwner: TComponent): TForm;
begin
  Result := FFormClass.Create(AOwner);
end;

function TFormCreator.GetFormClass: TFormClass;
begin
  Result := FFormClass;
end;

end.
