unit Sis.UI.IO.Output.ToMemo_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMemoOutput = class(TInterfacedObject, IOutput)
  private
    FMemo: TMemo;
    FQtdExib: integer;
    FAtivo: boolean;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    property Ativo: boolean read GetAtivo write SetAtivo;
    constructor Create(pMemo: TMemo);
  end;

implementation

{ TMemoOutput }

uses Sis.UI.Controls.Utils, Winapi.Windows, Vcl.Forms;

constructor TMemoOutput.Create(pMemo: TMemo);
begin
  FQtdExib := 0;
  FMemo := pMemo;
  FAtivo := True;
end;

procedure TMemoOutput.Exibir(pFrase: string);
begin
  if not Ativo then
    exit;

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
  MessageDlg(pFrase, pMsgDlgType, [mbOk], 0);
end;

function TMemoOutput.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

procedure TMemoOutput.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
