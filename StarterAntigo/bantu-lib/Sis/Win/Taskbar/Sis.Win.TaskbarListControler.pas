unit Sis.Win.TaskbarListControler;

interface

type
  ITaskbarListControler = interface
    ['{DD85FE01-3410-4419-B22F-583A9CF7D006}']
    procedure Activate(hwnd: THandle);
    procedure Add(hwnd: THandle);
    procedure Delete(hwnd: THandle);
  end;

implementation

end.
