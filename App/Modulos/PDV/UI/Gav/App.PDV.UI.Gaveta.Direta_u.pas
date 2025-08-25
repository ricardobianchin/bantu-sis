unit App.PDV.UI.Gaveta.Direta_u;

interface

uses App.PDV.UI.Gaveta, Sis.Terminal;

type
  TGavetaDireta = class(TInterfacedObject, IGaveta)
  private
    FTerminal: ITerminal;
  public
    procedure Acione;
    function Aberta: Boolean;
    constructor Create(pTerminal: ITerminal);
  end;

implementation

uses Sis.Win.Utils.Printer_u;

{ TGavetaDireta }

function TGavetaDireta.Aberta: Boolean;
begin
  Result := False;
end;

procedure TGavetaDireta.Acione;
begin
  ImprimaDireta(FTerminal.GavetaImprNome, FTerminal.GavetaComando);
end;

constructor TGavetaDireta.Create(pTerminal: ITerminal);
begin
  FTerminal := pTerminal;
end;

end.
