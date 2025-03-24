unit Sis.UI.Select;

interface

type
  ISelect = interface(IInterface)
    ['{93C78604-820D-4723-868B-DE20F71221B6}']
    function Execute(pParams: string = ''): Boolean;

    function GetLastSelected: string;
    property LastSelected: string read GetLastSelected;
  end;

implementation

end.
