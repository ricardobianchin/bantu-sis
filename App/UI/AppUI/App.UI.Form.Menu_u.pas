unit App.UI.Form.Menu_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Menu_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin;

type
  TAppMenuForm = class(TMenuForm)
    StatusPanel: TPanel;
    AjudaPanel: TPanel;
    AjudaLabel_PrecoBuscaForm: TLabel;
    TitleBarPanel: TPanel;
    TitleBarCaptionLabel: TLabel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AppMenuForm: TAppMenuForm;

implementation

{$R *.dfm}

end.
