unit Sis.UI.Frame.Bas.Filtro_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Sis.UI.Frame.Bas_u;

type
  TFiltroFrame = class(TBasFrame)
    ChangeTimer: TTimer;
    procedure ChangeTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FOnChange: TNotifyEvent;
  protected
    procedure AgendeChange;

    function GetOnChange: TNotifyEvent; virtual;
    procedure SetOnChange(const Value: TNotifyEvent); virtual;

    procedure SetValues(Value: variant); virtual;
    function GetValues: variant; virtual;
  public
    { Public declarations }
    procedure AjusteValores; virtual;

    property Values: variant read GetValues write SetValues;
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;

    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent); reintroduce;
  end;

var
  FiltroFrame: TFiltroFrame;

implementation

{$R *.dfm}

procedure TFiltroFrame.AgendeChange;
begin
  ChangeTimer.Enabled := False;
  ChangeTimer.Enabled := True;
end;

procedure TFiltroFrame.AjusteValores;
begin

end;

procedure TFiltroFrame.ChangeTimerTimer(Sender: TObject);
begin
  ChangeTimer.Enabled := False;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TFiltroFrame.Create(AOwner: TComponent; pOnChange: TNotifyEvent);
begin
  inherited Create(AOwner);
  OnChange := pOnChange;
end;

function TFiltroFrame.GetOnChange: TNotifyEvent;
begin
  Result := FOnChange;
end;

function TFiltroFrame.GetValues: variant;
begin
  AjusteValores;
  Result := System.Variants.Null;// varNull;
end;

procedure TFiltroFrame.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TFiltroFrame.SetValues(Value: variant);
begin

end;

end.
