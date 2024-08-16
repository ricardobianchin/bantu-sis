unit Sis.UI.Controls.TreeView.DBI;

interface

uses Sis.DBI, Sis.DB.DBTypes;

type
  ITreeViewDBI = interface(IDBI)
    ['{FF988616-535D-4C48-A433-3336E7A28046}']
    function DBQueryCreate: IDBQuery;
  end;


implementation

end.
