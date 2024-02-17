unit App.UI.Retag.TabSheetItem_u;

interface

uses Vcl.ComCtrls, App.Constants, Vcl.Forms, App.UI.Retag.TabSheetItem;

type
  TTabSheetItem = class(TInterfacedObject, ITabSheetItem)
  private
    FTabSheetIndex: TTabSheetIndex;
    FTabSheet: TTabSheet;
    FFormClass: TFormClass;
    FForm: TForm;

    function GetTabSheetIndex: TTabSheetIndex;
    function GetTabSheet: TTabSheet;
    function GetFormClass: TFormClass;
    function GetForm: TForm;

  public
    property TabSheetIndex: TTabSheetIndex read GetTabSheetIndex;
    property TabSheet: TTabSheet read GetTabSheet;
    property FormClass: TFormClass read GetFormClass;
    property Form: TForm read GetForm;

    constructor Create(pTabSheetIndex: TTabSheetIndex; pTabSheet: TTabSheet;
      pFormClass: TFormClass; pForm: TForm);
    function IsFormClass(pFormClass: TFormClass): boolean;
  end;

implementation

{ TTabSheetItem }

constructor TTabSheetItem.Create(pTabSheetIndex: TTabSheetIndex;
  pTabSheet: TTabSheet; pFormClass: TFormClass; pForm: TForm);
begin
  FTabSheetIndex := pTabSheetIndex;
  FTabSheet := pTabSheet;
  FFormClass := pFormClass;
  FForm := pForm;
end;

function TTabSheetItem.GetForm: TForm;
begin
  Result := FForm;
end;

function TTabSheetItem.GetFormClass: TFormClass;
begin
  Result := FFormClass;
end;

function TTabSheetItem.GetTabSheet: TTabSheet;
begin
  Result := FTabSheet;
end;

function TTabSheetItem.GetTabSheetIndex: TTabSheetIndex;
begin
  Result := FTabSheetIndex;
end;

function TTabSheetItem.IsFormClass(pFormClass: TFormClass): boolean;
begin
  Result := FormClass = pFormClass;
end;

end.
