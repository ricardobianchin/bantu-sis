unit App.PDV.UI.Gaveta.NaoTem_u;

interface

uses App.PDV.UI.Gaveta;

type
  TGavetaNaoTem = class(TInterfacedObject, IGaveta)
  private
  public
    procedure Acione;
    function Aberta: Boolean;
  end;


implementation

{ TGavetaNaoTem }

function TGavetaNaoTem.Aberta: Boolean;
begin
  Result := False;
end;

procedure TGavetaNaoTem.Acione;
begin

end;

end.
