unit Sis.UI.Controls.TreeView.Preencher_u;

interface

uses VCL.Controls, Sis.UI.Controls.TreeView.Preencher, System.ImageList,
  VCL.ComCtrls, Sis.UI.Controls.TreeView.DBI;

type
  TTreeViewPreencher = class(TInterfacedObject, ITreeViewPreencher)
  private
    FTreeView: TTreeView;
    FImageList: TImageList;
    FTreeViewDBI: ITreeViewDBI;
  public
    procedure Preencher; virtual;
    constructor Create(pTreeView: TTreeView; pImageList: TImageList = nil;
      pTreeViewDBI: ITreeViewDBI = nil);
  end;

implementation

{ TTreeViewPreencher }

constructor TTreeViewPreencher.Create(pTreeView: TTreeView;
  pImageList: TImageList; pTreeViewDBI: ITreeViewDBI);
begin
  FTreeView := pTreeView;
  FImageList := pImageList;
  FTreeViewDBI := pTreeViewDBI;
end;

procedure TTreeViewPreencher.Preencher;
begin
  FTreeView.Items.Clear;
end;

end.
