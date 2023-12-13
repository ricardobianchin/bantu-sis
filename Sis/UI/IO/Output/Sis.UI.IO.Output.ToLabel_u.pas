unit Sis.UI.IO.Output.ToLabel_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.StdCtrls;

type
  TLabelOutput = class(TInterfacedObject, IOutput)
  private
    FLabel: TLabel;
    FQtdExib: integer;

  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    constructor Create(pLabel: TLabel);
  end;

implementation

uses Vcl.Forms;

{ TLabelOutput }

constructor TLabelOutput.Create(pLabel: TLabel);
begin
  FLabel := pLabel;
  FQtdExib := 0;
end;

procedure TLabelOutput.Exibir(pFrase: string);
begin
  FLabel.Caption := pFrase;

  if (FQtdExib > 5) then
  begin
    FQtdExib := 0;
    Application.ProcessMessages;
  end
  else
    FLabel.Repaint;

end;

procedure TLabelOutput.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

end.
