unit Sis.UI.IO.Output.ToLabel_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.StdCtrls;

type
  TLabelOutput = class(TInterfacedObject, IOutput)
  private
    FLabel: TLabel;
    FQtdExib: integer;
    FAtivo: boolean;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    property Ativo: boolean read GetAtivo write SetAtivo;
    constructor Create(pLabel: TLabel);
  end;

implementation

uses Vcl.Forms;

{ TLabelOutput }

constructor TLabelOutput.Create(pLabel: TLabel);
begin
  FLabel := pLabel;
  FQtdExib := 0;
  FAtivo := True;
end;

procedure TLabelOutput.Exibir(pFrase: string);
begin
  if not Ativo then
    exit;

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

function TLabelOutput.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

procedure TLabelOutput.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
