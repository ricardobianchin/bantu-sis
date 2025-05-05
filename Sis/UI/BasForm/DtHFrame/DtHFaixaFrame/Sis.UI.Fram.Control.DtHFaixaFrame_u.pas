unit Sis.UI.Fram.Control.DtHFaixaFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.Control_u, Sis.UI.Frame.COntrol.DateTime_u, Vcl.ComCtrls,
  Vcl.ToolWin;

type
  TDtHFaixaFrame = class(TControlBasFrame)
    ToolBar1: TToolBar;
    MesAntToolButton: TToolButton;
    MesAtuToolButton: TToolButton;
    HojeToolButton: TToolButton;
    Dias30ToolButton: TToolButton;
    procedure MesAntToolButtonClick(Sender: TObject);
    procedure MesAtuToolButtonClick(Sender: TObject);
    procedure HojeToolButtonClick(Sender: TObject);
    procedure Dias30ToolButtonClick(Sender: TObject);
  private
    { Private declarations }
    DtIniFrame: TDateTimeFrame;
    DtFinFrame: TDateTimeFrame;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure PegarNomes(pNovoNome1, pNovoNome2: string);
  end;

var
  DtHFaixaFrame: TDtHFaixaFrame;

implementation

{$R *.dfm}

uses Sis.Types.Dates;

{ TDtHFaixaFrame }

constructor TDtHFaixaFrame.Create(AOwner: TComponent);
begin
  inherited;
  DtIniFrame := TDateTimeFrame.Create(Self);
  DtIniFrame.Name := 'DtIniFrame';

  DtFinFrame := TDateTimeFrame.Create(Self);
  DtFinFrame.Name := 'DtFinFrame';

  PegarNomes('Data Inicial', 'Data Final');
end;

procedure TDtHFaixaFrame.Dias30ToolButtonClick(Sender: TObject);
var
  i, f: TDateTime;
begin
  inherited;
  SetDtHRangeDays(i, f, 30);
  DtIniFrame.Value := i;
  DtFinFrame.Value := f;
end;

procedure TDtHFaixaFrame.HojeToolButtonClick(Sender: TObject);
var
  i, f: TDateTime;
begin
  inherited;
  SetDtHRangeToday(i, f);
  DtIniFrame.Value := i;
  DtFinFrame.Value := f;
end;

procedure TDtHFaixaFrame.MesAntToolButtonClick(Sender: TObject);
var
  i, f: TDateTime;
begin
  inherited;
  SetDtHRangePreviousMonth(i, f);
  DtIniFrame.Value := i;
  DtFinFrame.Value := f;
end;

procedure TDtHFaixaFrame.MesAtuToolButtonClick(Sender: TObject);
var
  i, f: TDateTime;
begin
  inherited;
  SetDtHRangeThisMonth(i, f);
  DtIniFrame.Value := i;
  DtFinFrame.Value := f;

end;

procedure TDtHFaixaFrame.PegarNomes(pNovoNome1, pNovoNome2: string);
var
  iToolButtonIndex: integer;
  oUltimoToolButton: TToolButton;
begin
  DtIniFrame.PegarNome(pNovoNome1);
  DtFinFrame.PegarNome(pNovoNome2);
  DtFinFrame.Left := DtIniFrame.Left + DtIniFrame.Width + 6;

  ToolBar1.Left := DtFinFrame.Left + DtFinFrame.Width + 6;

  iToolButtonIndex := ToolBar1.ButtonCount - 1;
  oUltimoToolButton := ToolBar1.Buttons[iToolButtonIndex];
  Width := ToolBar1.Left + oUltimoToolButton.Left + oUltimoToolButton.Width + 1;
end;

end.
