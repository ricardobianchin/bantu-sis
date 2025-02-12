unit App.PDV.UI.Balanca.VendaForm.Teste_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.PDV.UI.Balanca.VendaForm_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls;

const
  BALANCA_FUNCIONA = True;

type
  TBalancaTesteVendaForm = class(TBalancaVendaForm)
  private
    { Private declarations }
  protected
    procedure LePeso(out pPesoCurrency: Currency; out pDeuErro: Boolean;
      out pMensagem: string); override;
  public
    { Public declarations }
  end;

var
  BalancaTesteVendaForm: TBalancaTesteVendaForm;

implementation

{$R *.dfm}

uses System.Math;

{ TBalancaTesteVendaForm }

procedure TBalancaTesteVendaForm.LePeso(out pPesoCurrency: Currency;
  out pDeuErro: Boolean; out pMensagem: string);
begin
  inherited;
  if BALANCA_FUNCIONA then
  begin
    pPesoCurrency := RoundTo(Random(3000) / 1000, -3);
    pDeuErro := FALSE;
    exit;
  end;

  pDeuErro := True;
  pMensagem := 'Teste balanca falhou';
end;

end.
