unit Sis.UI.Controls.TreeView.Preencher_u;

interface

uses VCL.Controls, Sis.UI.Controls.TreeView.Preencher, System.ImageList,
  VCL.ComCtrls;

type
  TTreeViewPreencher = class(TInterfacedObject, ITreeViewPreencher)
  private
    FTreeView: TTreeView;
    FImageList: TImageList;
  public
    procedure Preencher; virtual;
    constructor Create(pTreeView: TTreeView; pImageList: TImageList = nil);
  end;

implementation

{ TTreeViewPreencher }

constructor TTreeViewPreencher.Create(pTreeView: TTreeView;
  pImageList: TImageList);
begin
  FTreeView := pTreeView;
  FImageList := pImageList;
end;

procedure TTreeViewPreencher.Preencher;
begin
  FTreeView.Items.Clear;
end;

end.
