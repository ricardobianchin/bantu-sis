unit App.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls,Sis.UI.Constants,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls, System.Actions, Vcl.ActnList, Sis.Threads.StatusFrame_u;

type
  TGerAppForm = class(TBasForm)
    TitleBarPanel: TPanel;
    TitleToolBar: TToolBar;
    Button1: TButton;
    TitActionList: TActionList;
    FecharAction_GerAppForm: TAction;
    procedure TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FecharAction_GerAppFormExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  GerAppForm: TGerAppForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, System.DateUtils;

procedure TGerAppForm.Button1Click(Sender: TObject);
var
  o: TStatusFrame;
begin
  inherited;

  o := TStatusFrame.Create(Self, 'o1'+SecondOf(Now).ToString);
  o.Label1.Caption := o.Name;

end;

procedure TGerAppForm.FecharAction_GerAppFormExecute(Sender: TObject);
begin
  inherited;
  Hide;
end;

procedure TGerAppForm.FormCreate(Sender: TObject);
begin
  inherited;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  TitleToolBar.Color := COR_AZUL_TITLEBAR;

end;

procedure TGerAppForm.TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  inherited;
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

end.
