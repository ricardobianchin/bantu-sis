unit Sis.UI.Controls.TreeView.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TProcedureTreeNode = procedure(pTreeNode: TTreeNode) of object;

  TTreeViewFrame = class(TControlBasFrame)
    TitLabel: TLabel;
    CaminhoLabel: TLabel;
    TreeView1: TTreeView;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FProcExecNode: TProcedureTreeNode;
  public
    { Public declarations }

    procedure AtualizeCaminhoLabel;
    function GetPath(pTreeNode: TTreeNode): string;

    property ProcExecNode: TProcedureTreeNode read FProcExecNode write FProcExecNode;
  end;

//var
//  TreeViewFrame: TTreeViewFrame;

implementation

{$R *.dfm}

procedure TTreeViewFrame.AtualizeCaminhoLabel;
var
  sPath: string;
begin
  sPath := GetPath(TreeView1.Selected);
  if CaminhoLabel.Caption <> sPath then
    CaminhoLabel.Caption := sPath;
end;

function TTreeViewFrame.GetPath(pTreeNode: TTreeNode): string;
begin
  Result := '';
  while pTreeNode <> nil do
  begin
    if Result = '' then
      Result := pTreeNode.Text
    else
      Result := pTreeNode.Text + ' / ' + Result;
    pTreeNode := pTreeNode.Parent;
  end;
end;

procedure TTreeViewFrame.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  AtualizeCaminhoLabel;
end;

procedure TTreeViewFrame.TreeView1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #32 then
  begin
    if Assigned(FProcExecNode) then
      FProcExecNode(TreeView1.Selected);
  end;
end;

end.
