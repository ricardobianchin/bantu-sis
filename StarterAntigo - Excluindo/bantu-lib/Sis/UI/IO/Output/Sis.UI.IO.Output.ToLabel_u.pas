unit Sis.UI.IO.Output.ToLabel_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.StdCtrls;

type
  TOutputToLabel = class(TInterfacedObject, IOutput)
  private
    FLabel: TLabel;

  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    constructor Create(pLabel: TLabel);
  end;

implementation

uses sis.ui.io.output.exibirpausa.form_u;

{ TOutputToLabel }

constructor TOutputToLabel.Create(pLabel: TLabel);
begin
  FLabel := pLabel;
end;

procedure TOutputToLabel.Exibir(pFrase: string);
begin
  FLabel.Caption := pFrase;
  FLabel.Repaint;
end;

procedure TOutputToLabel.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
  sis.ui.io.output.exibirpausa.form_u.Exibir(pFrase, pMsgDlgType);
end;

end.
