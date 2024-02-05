unit App.UI.Retag.TabSheetItem;

interface

uses Vcl.ComCtrls, App.Constants, Vcl.Forms;

type
  ITabSheetItem = interface(IInterface)
    ['{AE7B0DAF-7F68-4DE2-AF40-8E3B08D57930}']
    function GetTabSheetIndex: TTabSheetIndex;
    function GetTabSheet: TTabSheet;
    function GetFormClass: TFormClass;
    function GetForm: TForm;

    property TabSheetIndex: TTabSheetIndex read GetTabSheetIndex;
    property TabSheet: TTabSheet read GetTabSheet;
    property FormClass: TFormClass read GetFormClass;
    property Form: TForm read GetForm;

    function IsFormClass(pFormClass: TFormClass): boolean;
  end;

implementation

end.
