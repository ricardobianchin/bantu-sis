unit App.UI.Retag.TabSheet.Factory_u;

interface

uses App.UI.Retag.TabSheetList, App.UI.Retag.TabSheetItem, Vcl.ComCtrls,
  Vcl.Forms, App.Constants;

function TabSheetListCreate: ITabSheetList;
function TabSheetItemCreate(pTabSheetIndex: TTabSheetIndex;
  pTabSheet: TTabSheet; pFormClass: TFormClass; pForm: TForm): ITabSheetItem;

implementation

uses App.UI.Retag.TabSheetList_u, App.UI.Retag.TabSheetItem_u;

function TabSheetListCreate: ITabSheetList;
begin
  Result := TTabSheetList.Create;
end;

function TabSheetItemCreate(pTabSheetIndex: TTabSheetIndex;
  pTabSheet: TTabSheet; pFormClass: TFormClass; pForm: TForm): ITabSheetItem;
begin
  Result := TTabSheetItem.Create(pTabSheetIndex, pTabSheet, pFormClass, pForm);
end;

end.
