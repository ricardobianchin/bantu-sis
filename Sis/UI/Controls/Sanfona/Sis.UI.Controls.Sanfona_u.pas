unit Sis.UI.Controls.Sanfona_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ExtCtrls,
  Sis.UI.Frame.Bas.Controls.SanfonaItem_u;

type

  TSanfonaFrame = class(TBasFrame)
    FundoPanel: TPanel;
    TopoPanel: TPanel;
    ToolBar1: TToolBar;
    TitLabel: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ScrollBox1: TScrollBox;
    TreeView1: TTreeView;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    // procedure ItemExpandirClick(Sender: TObject);
    // procedure ItemRetrairClick(Sender: TObject);
  procedure SanfonaItemAbriu(pSanfonaItem: TSanfonaItemBasFrame);
  public
    { Public declarations }
    procedure PegarItem(pSanfonaItem: TSanfonaItemBasFrame);
  end;

var
  SanfonaFrame: TSanfonaFrame;

implementation

{$R *.dfm}
{ TSanfonaFrame }

procedure TSanfonaFrame.PegarItem(pSanfonaItem: TSanfonaItemBasFrame);
var
  c: integer;
  UltimoControl: TControl;
begin
  pSanfonaItem.Parent := ScrollBox1;
  c := ScrollBox1.ControlCount;
  if c = 0 then
    exit;
  UltimoControl := ScrollBox1.Controls[c - 1];
  pSanfonaItem.Top := UltimoControl.Top + UltimoControl.Height + 3;
  pSanfonaItem.ProcNotificaAbriu := SanfonaItemAbriu;
  TreeView1.Items.AddObject(nil, pSanfonaItem.Nome, pSanfonaItem);
end;

procedure TSanfonaFrame.SanfonaItemAbriu(pSanfonaItem: TSanfonaItemBasFrame);
begin

end;

procedure TSanfonaFrame.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  SI: TSanfonaItemBasFrame;
begin
  inherited;
  SI := TSanfonaItemBasFrame(Node.Data);
  SI.Foque;
end;

end.
