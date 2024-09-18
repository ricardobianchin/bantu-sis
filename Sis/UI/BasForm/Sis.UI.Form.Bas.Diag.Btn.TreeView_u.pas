unit Sis.UI.Form.Bas.Diag.Btn.TreeView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, System.Generics.Collections;

type
  TTreeViewDiagBasForm = class(TDiagBtnBasForm)
    TreeView1: TTreeView;
    TituloLabel: TLabel;
    CaminhoLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FNodeList: TList<TTreeNode>;
  protected
    property NodeList: TList<TTreeNode> read FNodeList;
    procedure PreencherTreeView; virtual;
    function GetPath(pTreeNode: TTreeNode): string;
    procedure AtualizeCaminho;

    function AddChildNode(Parent: TTreeNode; const S: string; Ptr: TCustomData): TTreeNode;

  public
    { Public declarations }

    constructor Create(AOwner: TComponent; pCaption: TCaption;
      pTitulo: TCaption); reintroduce; virtual;
    destructor Destroy; override;

  end;

var
  TreeViewDiagBasForm: TTreeViewDiagBasForm;

implementation

{$R *.dfm}

function TTreeViewDiagBasForm.AddChildNode(Parent: TTreeNode; const S: string;
  Ptr: TCustomData): TTreeNode;
begin
  Result := TreeView1.Items.AddChildObject(Parent, S, Ptr);
  NodeList.Add(Result);
end;

procedure TTreeViewDiagBasForm.AtualizeCaminho;
var
  sPath: string;
  oNodeSelecionado: TTreeNode;
begin
  oNodeSelecionado := TreeView1.Selected;

  sPath := GetPath(oNodeSelecionado);
  if CaminhoLabel.Caption <> sPath then
    CaminhoLabel.Caption := 'Caminho: ' + sPath;
end;

constructor TTreeViewDiagBasForm.Create(AOwner: TComponent; pCaption: TCaption;
  pTitulo: TCaption);
begin
  inherited Create(AOwner);
  FNodeList := TList<TTreeNode>.Create;
  Caption := pCaption;
  TituloLabel.Caption := pTitulo;
  TreeView1.Align := alClient;
  Height := (Screen.Height * 8) div 10;
end;

destructor TTreeViewDiagBasForm.Destroy;
begin
  TreeView1.Free;
  inherited;
end;

function TTreeViewDiagBasForm.GetPath(pTreeNode: TTreeNode): string;
begin
  Result := '';

  while Assigned(pTreeNode) do
  begin
    if Result = '' then
      Result := pTreeNode.Text
    else
      Result := pTreeNode.Text + ' / ' + Result;
    pTreeNode := pTreeNode.Parent;
  end;
end;

procedure TTreeViewDiagBasForm.PreencherTreeView;
begin

end;

procedure TTreeViewDiagBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  PreencherTreeView;
  TreeView1.SetFocus;
end;

end.
