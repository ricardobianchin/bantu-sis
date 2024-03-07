unit Sis.UI.FormCreator_u;

interface

uses Sis.UI.FormCreator, VCL.Forms, System.Classes, Sis.Types.Utils_u;

type
  TFormCreator = class(TInterfacedObject, IFormCreator)
  private
    FFormClass: TFormClass;
    function GetFormClass: TFormClass;
  protected
    property FormClass: TFormClass read GetFormClass;
    function GetTitulo: string; virtual; abstract;
    function GetFormClassName: string;
  public
    constructor Create(pFormClass: TFormClass);
    property Titulo: string read GetTitulo;
    property FormClassName: string read GetFormClassName;
    function FormCreate(AOwner: TComponent): TForm; virtual;
    function FormCreateSelect(AOwner: TComponent): TForm; virtual;
    function PergSelect(var pSelectItem: TSelectItem): boolean; virtual; abstract;
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

function TFormCreator.FormCreateSelect(AOwner: TComponent): TForm;
begin
  Result := nil;
end;

function TFormCreator.GetFormClass: TFormClass;
begin
  Result := FFormClass;
end;

function TFormCreator.GetFormClassName: string;
begin
  Result := FFormClass.ClassName;
end;

end.
