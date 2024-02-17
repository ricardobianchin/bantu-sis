unit App.UI.Retag.TabSheetList_u;

interface

uses System.Classes, Vcl.ComCtrls, App.Constants, Vcl.Forms,
  App.UI.Retag.TabSheetList, App.UI.Retag.TabSheetItem;

type
  TTabSheetList = class(TInterfaceList, ITabSheetList)
  private
    function GetTabSheetItem(Index: integer): ITabSheetItem;
  public
    property TabSheetItem[Index: integer]: ITabSheetItem
      read GetTabSheetItem; default;

    procedure PegarTabSheetItem(pTabSheetIndex: TTabSheetIndex;
      pTabSheet: TTabSheet; pFormClass: TFormClass; pForm: TForm);

    function FormClassToTTabSheetItem(pFormClass: TFormClass): ITabSheetItem;
  end;

implementation

{ TTabSheetList }

uses App.UI.Retag.TabSheet.Factory_u;

function TTabSheetList.FormClassToTTabSheetItem(
  pFormClass: TFormClass): ITabSheetItem;
var
  I: integer;
  oTabSheetItem: ITabSheetItem;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    oTabSheetItem := GetTabSheetItem(I);
    if oTabSheetItem.IsFormClass(pFormClass) then
    begin
      Result := oTabSheetItem;
      break;
    end;
  end;
end;

function TTabSheetList.GetTabSheetItem(Index: integer): ITabSheetItem;
begin
  Result := ITabSheetItem(Items[Index]);
end;

procedure TTabSheetList.PegarTabSheetItem(pTabSheetIndex: TTabSheetIndex;
  pTabSheet: TTabSheet; pFormClass: TFormClass; pForm: TForm);
var
  oItem: ITabSheetItem;
begin
  oItem := TabSheetItemCreate(pTabSheetIndex, pTabSheet, pFormClass, pForm);
  Add(oItem);
end;

end.
