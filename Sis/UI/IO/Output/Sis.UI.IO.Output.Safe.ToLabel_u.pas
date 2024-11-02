unit Sis.UI.IO.Output.Safe.ToLabel_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs, Vcl.StdCtrls, System.Classes;

type
  TLabelSafeOutput = class(TInterfacedObject, IOutput)
  private
    FLabel: TLabel;
    FAtivo: boolean;
    FProximaFrase: string;
    procedure DoExibir;

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

{ TLabelSafeOutput }

constructor TLabelSafeOutput.Create(pLabel: TLabel);
begin
  FLabel := pLabel;
  FAtivo := True;
end;

procedure TLabelSafeOutput.DoExibir;
begin
  FLabel.Caption := FProximaFrase;
  FLabel.Visible := True;
end;

procedure TLabelSafeOutput.Exibir(pFrase: string);
begin
  if not Ativo then
    exit;
  FProximaFrase := pFrase;
  TThread.Queue(nil, DoExibir);
end;

procedure TLabelSafeOutput.ExibirPausa(pFrase: string;
  pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

function TLabelSafeOutput.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

procedure TLabelSafeOutput.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
