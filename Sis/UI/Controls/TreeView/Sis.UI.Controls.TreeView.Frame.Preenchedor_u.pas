unit Sis.UI.Controls.TreeView.Frame.Preenchedor_u;

interface

uses Sis.UI.Controls.TreeView.Frame.Preenchedor, VCL.Controls,
  Sis.UI.Controls.TreeView.Frame_u, Vcl.ComCtrls;

type
  TTreeViewPreenchedor = class(TInterfacedObject, ITreeViewPreenchedor)
  private
    FTreeViewFrame: TTreeViewFrame;
    FImageList: TImageList;
    FFiltroId: integer;
  protected
    property TreeViewFrame: TTreeViewFrame read FTreeViewFrame;
    property ImageList: TImageList read FImageList;
    property FiltroId: integer read FFiltroId;
    procedure ExecNode(pTreeNode: TTreeNode); virtual;
  public
    procedure PreenchaTreeView(pFiltroId: integer; pNovoTitulo: string); virtual;
    procedure PreenchaTitulo(pTitulo: string);
    constructor Create(pTreeViewFrame: TTreeViewFrame; pTitulo: string = '';
      pImageList: TImageList = nil);
  end;

implementation

{ TTreeViewPreenchedor }

constructor TTreeViewPreenchedor.Create(pTreeViewFrame: TTreeViewFrame; pTitulo: string = '';
      pImageList: TImageList = nil);
begin
  FTreeViewFrame := pTreeViewFrame;
  FImageList := pImageList;
  FTreeViewFrame.TreeView1.Images := FImageList;
  FTreeViewFrame.ProcExecNode := ExecNode;
  PreenchaTitulo(pTitulo);
end;

procedure TTreeViewPreenchedor.ExecNode(pTreeNode: TTreeNode);
begin

end;

procedure TTreeViewPreenchedor.PreenchaTitulo(pTitulo: string);
var
  sC: string;
begin
  if pTitulo = '' then
    exit;

  sC := FTreeViewFrame.TitLabel.Caption;
  if pTitulo <> sC then
    FTreeViewFrame.TitLabel.Caption := pTitulo;
end;

procedure TTreeViewPreenchedor.PreenchaTreeView(pFiltroId: integer; pNovoTitulo: string);
begin
  FFiltroId := pFiltroId;
  PreenchaTitulo(pNovoTitulo);
end;

end.
