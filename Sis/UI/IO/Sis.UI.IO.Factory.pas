unit Sis.UI.IO.Factory;

interface

uses Sis.UI.IO.Output, Vcl.StdCtrls, Vcl.Controls, Sis.UI.IO.Input.Str;

function MudoOutputCreate: IOutput;
function LabelOutputCreate(pLabel: TLabel;
  pAutoOcultar: Boolean = False): IOutput;
function LabelSafeOutputCreate(pLabel: TLabel): IOutput;
function MemoOutputCreate(pMemo: TMemo): IOutput;
function BalloonHintOutputCreate(pBalloonHint: TBalloonHint): IOutput;
function ShowMessageOutputCreate: IOutput;

implementation

uses Sis.UI.IO.Output.Mudo_u, Sis.UI.IO.Output.ToLabel_u,
  Sis.UI.IO.Output.Safe.ToLabel_u, Sis.UI.IO.Output.ToMemo_u,
  Sis.UI.IO.Output.ToBalloonHint_u, Sis.UI.IO.Output.ShowMessage_u;

function MudoOutputCreate: IOutput;
begin
  Result := TMudoOutput.Create;
end;

function LabelOutputCreate(pLabel: TLabel; pAutoOcultar: Boolean): IOutput;
begin
  Result := TLabelOutput.Create(pLabel, pAutoOcultar);
end;

function LabelSafeOutputCreate(pLabel: TLabel): IOutput;
begin
  Result := TLabelSafeOutput.Create(pLabel);
end;

function MemoOutputCreate(pMemo: TMemo): IOutput;
begin
  Result := TMemoOutput.Create(pMemo);
end;

function BalloonHintOutputCreate(pBalloonHint: TBalloonHint): IOutput;
begin
  Result := TBalloonHintOutput.Create(pBalloonHint);
end;

function ShowMessageOutputCreate: IOutput;
begin
  Result := TShowMessageOutput.Create;
end;


end.
