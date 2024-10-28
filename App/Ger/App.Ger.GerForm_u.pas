unit App.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.UI.Constants, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Sis.UI.Frame.Bas.Status_u,
  System.Generics.Collections;

type
  TGerAppForm = class(TBasForm)
    TitleBarPanel: TPanel;
    TitleToolBar: TToolBar;
    Button1: TButton;
    TitActionList: TActionList;
    FecharAction_GerAppForm: TAction;

    procedure TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FecharAction_GerAppFormExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFramesList: TList<TStatusFrame>;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

  // var
  // GerAppForm: TGerAppForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, System.DateUtils;

constructor TGerAppForm.Create(AOwner: TComponent);
begin
  inherited;
  FFramesList := TList<TStatusFrame>.Create;
end;

destructor TGerAppForm.Destroy;
begin
  FFramesList.Free;
  inherited;
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

procedure TGerAppForm.TitleBarPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
