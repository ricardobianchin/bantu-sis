unit btu.sis.ui.io.output.mudo_u;

interface

uses btu.sis.ui.io.output, Vcl.Dialogs;

type
  TOutputMudo = class(TInterfacedObject, IOutput)
  private

    function GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
  public
    property Enabled: boolean read GetEnabled write SetEnabled;
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
  end;


implementation

{ TOutputMudo }

procedure TOutputMudo.Exibir(pFrase: string);
begin

end;

procedure TOutputMudo.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin

end;

function TOutputMudo.GetEnabled: boolean;
begin
  result := false;
end;

procedure TOutputMudo.SetEnabled(Value: boolean);
begin

end;

end.
