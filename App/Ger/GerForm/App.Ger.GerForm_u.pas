unit App.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.UI.Constants, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Sis.UI.Frame.Bas.Status_u,
  System.Generics.Collections, App.Ger.GerForm.DBI;

type
  TGerAppForm = class(TBasForm)
    TitleBarPanel: TPanel;
    TitleToolBar: TToolBar;
    TitActionList: TActionList;
    FecharAction_GerAppForm: TAction;
    BasePanel: TPanel;
    SempreVisivelCheckBox: TCheckBox;
    AutoOpenCheckBox: TCheckBox;
    StatusFrameScrollBox: TScrollBox;
    StatusFlowPanel: TFlowPanel;

    procedure TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FecharAction_GerAppFormExecute(Sender: TObject);
    procedure SempreVisivelCheckBoxClick(Sender: TObject);
    procedure AutoOpenCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    FFramesList: TList<TStatusFrame>;
    FAutoOpen: Boolean;
    FSempreVisivel: Boolean;
    FProcessaControles: Boolean;
    FGerFormDBI: IGerFormDBI;

    procedure CarregConfig;

    procedure SetSempreVisivel(Value: Boolean);
    procedure SetAutoOpen(Value: Boolean);

  public
    { Public declarations }
    property AutoOpen: Boolean read FAutoOpen write SetAutoOpen;
    property SempreVisivel: Boolean read FSempreVisivel write SetSempreVisivel;

    constructor Create(AOwner: TComponent; pGerFormDBI: IGerFormDBI);
      reintroduce;
    destructor Destroy; override;

    procedure EspereTerminar;
    function StatusFrameCreate: TStatusFrame;
  end;

  // var
  // GerAppForm: TGerAppForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, System.DateUtils, Sis.Types.Bool_u;

procedure TGerAppForm.AutoOpenCheckBoxClick(Sender: TObject);
begin
  inherited;
  if not FProcessaControles then
    exit;

  AutoOpen := AutoOpenCheckBox.Checked;
end;

procedure TGerAppForm.CarregConfig;
var
  bSempreVisivel, bAutoOpen: Boolean;
begin
  FGerFormDBI.PegarConfigs(bSempreVisivel, bAutoOpen);

  if bSempreVisivel then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;

  SempreVisivelCheckBox.Checked := bSempreVisivel;
  AutoOpenCheckBox.Checked := bAutoOpen;
end;

procedure TGerAppForm.SempreVisivelCheckBoxClick(Sender: TObject);
begin
  inherited;
  if not FProcessaControles then
    exit;

  SempreVisivel := SempreVisivelCheckBox.Checked;
end;

constructor TGerAppForm.Create(AOwner: TComponent; pGerFormDBI: IGerFormDBI);
begin
  inherited Create(AOwner);
  FProcessaControles := False;
  FFramesList := TList<TStatusFrame>.Create;
  FGerFormDBI := pGerFormDBI;
  CarregConfig;
  FProcessaControles := True;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  TitleToolBar.Color := COR_AZUL_TITLEBAR;
end;

destructor TGerAppForm.Destroy;
begin
  FFramesList.Free;
  inherited;
end;

procedure TGerAppForm.EspereTerminar;
begin

end;

procedure TGerAppForm.FecharAction_GerAppFormExecute(Sender: TObject);
begin
  // inherited;
  Hide;
end;

function TGerAppForm.StatusFrameCreate: TStatusFrame;
var
  sName: string;
begin
  sName := 'StatusFrame' + (StatusFrameScrollBox.ControlCount+1).ToString;

  Result := TStatusFrame.Create(StatusFlowPanel);
  Result.Name := sName;
  Result.Parent := StatusFlowPanel;

  FFramesList.Add(Result);
end;

procedure TGerAppForm.SetAutoOpen(Value: Boolean);
begin
  FAutoOpen := Value;
  FGerFormDBI.AutoOpenGravar(FAutoOpen);
end;

procedure TGerAppForm.SetSempreVisivel(Value: Boolean);
begin
  FSempreVisivel := Value;

  if FSempreVisivel then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
  FGerFormDBI.SempreVisivelGravar(FSempreVisivel);
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
