unit Sis.UI.Frame.Bas.Controls.SanfonaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  Sis.UI.IO.Output;

type
  TSanfonaItemBasFrame = class;
  TProcSanfonaItemOfObject = procedure(pSanfonaItem: TSanfonaItemBasFrame) of object;

  TSanfonaItemBasFrame = class(TBasFrame)
    FundoPanel: TPanel;
    TopoPanel: TPanel;
    TitLabel: TLabel;
    ToolBar1: TToolBar;
    MeioPanel: TPanel;
    ActionList1: TActionList;
    ExpandirAction: TAction;
    RetrairAction: TAction;
    RetrairToolButton: TToolButton;
    ExpandirToolButton: TToolButton;
    procedure ExpandirActionExecute(Sender: TObject);
    procedure RetrairActionExecute(Sender: TObject);
  private
    FUltimoHeight: integer;
    FErroOutput: IOutput;
    function GetAberto: boolean;
    procedure SetAberto(const Value: boolean);
  protected
    { Private declarations }
    function GetNome: string; virtual; abstract;
  public
    { Public declarations }
    ProcItemAbriuNotify: TProcSanfonaItemOfObject;

    property Aberto: boolean read GetAberto write SetAberto;
    property Nome: string read GetNome;
    procedure Foque;
    property ErroOutput: IOutput read FErroOutput write FErroOutput;

    constructor Create(AOwner: TComponent); reintroduce;
  end;

var
  SanfonaItemBasFrame: TSanfonaItemBasFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.ImgDM;

{ TSanfonaItemBasFrame }

constructor TSanfonaItemBasFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ActionList1.Images := SisImgDataModule.ImageList_9_9;
  ToolBar1.Images := SisImgDataModule.ImageList_9_9;
  TitLabel.Caption := Nome;
  FundoPanel.Color := RGB(206, 222, 236);
  MeioPanel.Color := RGB(231, 239, 245);
end;

procedure TSanfonaItemBasFrame.ExpandirActionExecute(Sender: TObject);
begin
  inherited;
  SetAberto(True);
end;

procedure TSanfonaItemBasFrame.Foque;
var
  wc: TWinControl;
begin
  if not Aberto then
  begin
    SetAberto(True);
  end;
  wc := PrimeiroWinControlVisivel(MeioPanel);
  if not Assigned(wc) then
    exit;
  wc.SetFocus;
end;

function TSanfonaItemBasFrame.GetAberto: boolean;
begin
  Result := MeioPanel.Visible;
end;

procedure TSanfonaItemBasFrame.RetrairActionExecute(Sender: TObject);
begin
  inherited;
  SetAberto(False);
end;

procedure TSanfonaItemBasFrame.SetAberto(const Value: boolean);
begin
  RetrairAction.Visible := Value;
  ExpandirAction.Visible := not Value;
  if Value then
  begin
    MeioPanel.Visible := True;
    MeioPanel.Height := FUltimoHeight;
//    Height := TopoPanel.Height + MeioPanel.Height + 2;
    //ProcItemAbriuNotify(Self)
  end
  else
  begin
//    Height := TopoPanel.Height + 2;
    FUltimoHeight := MeioPanel.Height;
    MeioPanel.Visible := False;
  end;
end;

end.
