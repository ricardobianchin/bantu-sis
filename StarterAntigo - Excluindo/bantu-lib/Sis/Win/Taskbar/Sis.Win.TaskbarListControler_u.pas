unit Sis.Win.TaskbarListControler_u;

interface

uses
  Sis.Win.TaskbarList, ComObj, ShlObj, Sis.Win.TaskbarListControler;

type
  TTaskbarListControler = class(TInterfacedObject, ITaskbarListControler)
  private
    FTaskbarList: ITaskbarList;
  public
    constructor Create;

    procedure Activate(hwnd: THandle);
    procedure Add(hwnd: THandle);
    procedure Delete(hwnd: THandle);
  end;

implementation

constructor TTaskbarListControler.Create;
begin
//  inherited Create;
  FTaskbarList := CreateComObject(CLSID_TaskbarList) as ITaskbarList;
  FTaskbarList.HrInit;
end;

procedure TTaskbarListControler.Activate(hwnd: THandle);
begin
  FTaskbarList.ActivateTab(hwnd);
end;

procedure TTaskbarListControler.Add(hwnd: THandle);
begin
  FTaskbarList.AddTab(hwnd);
end;

procedure TTaskbarListControler.Delete(hwnd: THandle);
begin
  FTaskbarList.DeleteTab(hwnd);
end;

end.

