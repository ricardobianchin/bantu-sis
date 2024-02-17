unit Sis.UI.IO.Output.ToBalloonHint_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.Controls, Vcl.ExtCtrls;

type
  TBalloonHintOutput = class(TInterfacedObject, IOutput)
  private
    FBalloonHint: TBalloonHint;
    FAtivo: boolean;
    FBalloonHintCloseTimer: TTimer;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
    procedure BalloonHintCloseTimerTimer(Sender: TObject);
  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    property Ativo: boolean read GetAtivo write SetAtivo;

    constructor Create(pBalloonHint: TBalloonHint);
    destructor Destroy; override;

  end;

implementation

uses System.Types;

{ TBalloonHintOutput }

procedure TBalloonHintOutput.BalloonHintCloseTimerTimer(Sender: TObject);
begin
  FBalloonHintCloseTimer.Enabled := False;
  FBalloonHint.HideHint;
end;

constructor TBalloonHintOutput.Create(pBalloonHint: TBalloonHint);
begin
  FAtivo := True;
  FBalloonHint := pBalloonHint;
  FBalloonHintCloseTimer := TTimer.Create(nil);
  FBalloonHintCloseTimer.Enabled := False;
  FBalloonHintCloseTimer.Interval := 5000;
  FBalloonHintCloseTimer.OnTimer := BalloonHintCloseTimerTimer;
end;

destructor TBalloonHintOutput.Destroy;
begin
  FBalloonHintCloseTimer.Free;
  inherited;
end;

procedure TBalloonHintOutput.Exibir(pFrase: string);
var
  HintPoint: TPoint;
begin
  if not FAtivo then
    exit;

  HintPoint := Mouse.CursorPos;
  FBalloonHint.Title := pFrase;
  FBalloonHint.ShowHint(HintPoint);
  FBalloonHintCloseTimer.Enabled := False;
  FBalloonHintCloseTimer.Enabled := True;
end;

procedure TBalloonHintOutput.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

function TBalloonHintOutput.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

procedure TBalloonHintOutput.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
