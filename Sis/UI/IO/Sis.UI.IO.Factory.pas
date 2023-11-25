unit Sis.UI.IO.Factory;

interface

uses Sis.UI.IO.Output, Vcl.StdCtrls;

function MudoOutputCreate: IOutput;
function LabelOutputCreate(pLabel: TLabel): IOutput;
function MemoOutputCreate(pMemo: TMemo): IOutput;

implementation

uses Sis.UI.IO.Output.Mudo_u, Sis.UI.IO.Output.ToLabel_u,
  Sis.UI.IO.Output.ToMemo_u;

function MudoOutputCreate: IOutput;
begin
  Result := TMudoOutput.Create;
end;

function LabelOutputCreate(pLabel: TLabel): IOutput;
begin
  Result := TLabelOutput.Create(pLabel);
end;

function MemoOutputCreate(pMemo: TMemo): IOutput;
begin
  Result := TMemoOutput.Create(pMemo);
end;

end.
