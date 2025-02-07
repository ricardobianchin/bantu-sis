unit App.PDV.UI.Balanca_u;

interface

uses App.PDV.UI.Balanca, App.PDV.UI.Balanca.VendaForm_u;

type
  TBalanca = class(TInterfacedObject, IBalanca)
  private
    FBalancaVendaForm: TBalancaVendaForm;
    FHabilitada: Boolean;

    function GetHabilitada: Boolean;
  public
    procedure LePeso(out pPeso: Currency; out pDeuErro: Boolean;
      out pMensagem: string);
    constructor Create(pBalancaVendaForm: TBalancaVendaForm = nil);

    property Habilitada: Boolean read GetHabilitada;
  end;

implementation

uses System.SysUtils;

{ TBalanca }

constructor TBalanca.Create(pBalancaVendaForm: TBalancaVendaForm);
begin
  FBalancaVendaForm := pBalancaVendaForm;
  FHabilitada := FBalancaVendaForm <> nil;
end;

function TBalanca.GetHabilitada: Boolean;
begin
  Result := FHabilitada;
end;

procedure TBalanca.LePeso(out pPeso: Currency; out pDeuErro: Boolean;
  out pMensagem: string);
var
  Resultado: Boolean;
begin
  if not FHabilitada then
  begin
    pDeuErro := True;
    pMensagem := 'BALANÇA NÃO CONFIGURADA NO SISTEMA';
    exit;
  end;
  Resultado := FBalancaVendaForm.Perg
end;

end.
