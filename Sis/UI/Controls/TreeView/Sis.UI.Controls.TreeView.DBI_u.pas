unit Sis.UI.Controls.TreeView.DBI_u;

interface

uses Sis.DBI_u, Sis.UI.Controls.TreeView.DBI, Sis.DB.DBTypes;

type
  TTreeViewDBI = class(TDBI, ITreeViewDBI)
  private
  public
//    constructor Create(pDBConnection: IDBConnection);
    function DBQueryCreate: IDBQuery; virtual; abstract;
  end;

implementation

end.
