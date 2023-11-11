unit Sis.Win.TaskbarList;

interface

uses
  ComObj, ShlObj;

type
  ITaskbarList = interface
    [SID_ITaskbarList]
    // será usado em CreateComObject(CLSID_TaskbarList)
//    ['{F36CD240-B803-43F4-9E26-868EED33C076}']
    function HrInit: HResult; stdcall;
    function AddTab(hwnd: Cardinal): HResult; stdcall;
    function DeleteTab(hwnd: Cardinal): HResult; stdcall;
    function ActivateTab(hwnd: Cardinal): HResult; stdcall;
    function SetActiveAlt(hwnd: Cardinal): HResult; stdcall;
  end;

implementation

end.
