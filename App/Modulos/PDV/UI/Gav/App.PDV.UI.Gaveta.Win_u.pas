unit App.PDV.UI.Gaveta.Win_u;

interface

uses App.PDV.UI.Gaveta, Sis.Entities.Terminal;

type
  TGavetaWin = class(TInterfacedObject, IGaveta)
  private
    FTerminal: ITerminal;
  public
    procedure Acione;
    function Aberta: Boolean;
    constructor Create(pTerminal: ITerminal);
  end;

implementation

uses Sis.Win.Utils.Printer_u;

{ TGavetaWin }

function TGavetaWin.Aberta: Boolean;
begin
  Result := False;
end;

procedure TGavetaWin.Acione;
begin
  ImprimaWinSpool(FTerminal.GavetaImprNome, 'Abre Gaveta', FTerminal.GavetaComando);
end;

constructor TGavetaWin.Create(pTerminal: ITerminal);
begin
  FTerminal := pTerminal;
end;

end.
