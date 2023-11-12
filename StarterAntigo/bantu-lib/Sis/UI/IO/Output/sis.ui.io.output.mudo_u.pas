unit Sis.UI.IO.Output.Mudo_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs;

type
  TOutputMudo = class(TInterfacedObject, IOutput)
  private

//    function GetEnabled: boolean;
//    procedure SetEnabled(Value: boolean);
  public
//    property Enabled: boolean read GetEnabled write SetEnabled;
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

{
  function TOutputMudo.GetEnabled: boolean;
  begin
    result := false;
  end;

  procedure TOutputMudo.SetEnabled(Value: boolean);
  begin

  end;

}
end.
