unit Sis.UI.Controls.TreeView.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TTreeViewFrame = class(TControlBasFrame)
    TitLabel: TLabel;
    CaminhoLabel: TLabel;
    TreeView1: TTreeView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  TreeViewFrame: TTreeViewFrame;

implementation

{$R *.dfm}

end.
