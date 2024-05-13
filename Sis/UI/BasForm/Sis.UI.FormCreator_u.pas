unit Sis.UI.FormCreator_u;

interface

uses Sis.UI.FormCreator, VCL.Forms, System.Classes, Sis.Types;

type
  TFormCreator = class(TInterfacedObject, IFormCreator)
  private
    FFormClass: TFormClass;
    FTitulo: string;
    function GetFormClass: TFormClass;
    function GetTitulo: string;
  protected
    property FormClass: TFormClass read GetFormClass;
    function GetFormClassName: string;
  public
    constructor Create(pFormClass: TFormClass; pTitulo: string);
    property Titulo: string read GetTitulo;
    property FormClassName: string read GetFormClassName;
    function FormCreate(AOwner: TComponent): TForm; virtual;
    function FormCreateSelect(AOwner: TComponent; pIdPos: integer): TForm; virtual;
    function PergSelect(var pSelectItem: TSelectItem): boolean; virtual; abstract;
  end;


implementation

{ TFormCreator }

constructor TFormCreator.Create(pFormClass: TFormClass; pTitulo: string);
begin
  FFormClass := pFormClass;
  FTitulo := pTitulo;
end;

function TFormCreator.FormCreate(AOwner: TComponent): TForm;
begin
  Result := FFormClass.Create(AOwner);
end;

function TFormCreator.FormCreateSelect(AOwner: TComponent; pIdPos: integer): TForm;
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

function TFormCreator.GetTitulo: string;
begin
  Result := FTitulo;
end;

end.
