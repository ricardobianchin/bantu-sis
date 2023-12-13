unit Sis.UI.IO.Output.ToMemo_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMemoOutput = class(TInterfacedObject, IOutput)
  private
    FMemo: TMemo;

    FQtdExib: integer;

  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    constructor Create(pMemo: TMemo);
  end;

implementation

{ TMemoOutput }

uses Sis.UI.Controls.Utils, Winapi.Windows, Vcl.Forms;

constructor TMemoOutput.Create(pMemo: TMemo);
begin
  FQtdExib := 0;
  FMemo := pMemo;
end;

procedure TMemoOutput.Exibir(pFrase: string);
begin
  FMemo.Lines.Add(pFrase);
  SimuleTecla(vk_end);
  inc(FQtdExib);
  if (FQtdExib > 20) then
  begin
    FQtdExib := 0;
    Application.ProcessMessages;
  end
  else
    FMemo.Repaint;
end;

procedure TMemoOutput.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

end.
