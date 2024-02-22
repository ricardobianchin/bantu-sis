unit Sis.UI.Frame.Bas.FiltroParams_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TFiltroParamsFrame = class(TFrame)
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
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
  end;

implementation

{$R *.dfm}
{ TFiltroParamsFrame }

procedure TFiltroParamsFrame.AjusteValores;
begin

end;

procedure TFiltroParamsFrame.ChangeTimerTimer(Sender: TObject);
begin
  ChangeTimer.Enabled := False;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TFiltroParamsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TFiltroParamsFrame.Destroy;
begin
  inherited;
end;

procedure TFiltroParamsFrame.AgendeChange;
begin
  ChangeTimer.Enabled := False;
  ChangeTimer.Enabled := True;
end;

function TFiltroParamsFrame.GetOnChange: TNotifyEvent;
begin
  Result := FOnChange;
end;

function TFiltroParamsFrame.GetValues: variant;
begin
  AjusteValores;
  Result := varNull;
end;

procedure TFiltroParamsFrame.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TFiltroParamsFrame.SetValues(Value: variant);
begin

end;

end.
