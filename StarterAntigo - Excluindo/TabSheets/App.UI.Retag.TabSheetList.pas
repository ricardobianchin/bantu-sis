unit App.UI.Retag.TabSheetList;

interface

uses System.Classes, App.Constants, Vcl.ComCtrls, Vcl.Forms,
  App.UI.Retag.TabSheetItem;

type
  ITabSheetList = interface(IInterfaceList)
    ['{53ACF15E-C9AD-4A2F-B24F-2AD42C80309F}']
    procedure PegarTabSheetItem(pTabSheetIndex: TTabSheetIndex;
      pTabSheet: TTabSheet; pFormClass: TFormClass; pForm: TForm);

    function FormClassToTTabSheetItem(pFormClass: TFormClass): ITabSheetItem;
  end;

implementation

end.
