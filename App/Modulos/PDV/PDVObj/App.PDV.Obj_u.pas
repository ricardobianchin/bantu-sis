unit App.PDV.Obj_u;

interface

uses App.PDV.Obj, Sis.Terminal, App.PDV.UI.Gaveta, App.PDV.UI.Balanca,
  App.PDV.UI.Balanca.VendaForm_u;

type
  TPDVObj = class(TInterfacedObject, IPDVObj)
  private
    FTerminal: ITerminal;
    FGaveta: IGaveta;
    FBalanca: IBalanca;
    FBalancaVendaForm: TBalancaVendaForm;

    function GetGaveta: IGaveta;
    function GetBalanca: IBalanca;
  protected
    function GetFiscal: Boolean; virtual;
  public

    property Fiscal: Boolean read GetFiscal;
    property Gaveta: IGaveta read GetGaveta;

    property Balanca: IBalanca read GetBalanca;

    constructor Create(pTerminal: ITerminal);
    destructor Destroy; override;
  end;

implementation

{ TPDVObj }

uses App.PDV.Factory_u;

constructor TPDVObj.Create(pTerminal: ITerminal);
begin
  FTerminal := pTerminal;
  FGaveta := GavetaCreate(FTerminal);
  FBalancaVendaForm := BalancaVendaFormCreate(FTerminal);
  FBalanca := BalancaCreate(FBalancaVendaForm);
end;

destructor TPDVObj.Destroy;
begin
  FBalancaVendaForm.Free;
  inherited;
end;

function TPDVObj.GetBalanca: IBalanca;
begin
  Result := FBalanca;
end;

function TPDVObj.GetFiscal: Boolean;
begin
  Result := True;
end;

function TPDVObj.GetGaveta: IGaveta;
begin
  Result := FGaveta;
end;

end.

