unit App.PDV.UI.Balanca.VendaForm.Teste_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.PDV.UI.Balanca.VendaForm_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TBalancaTesteVendaForm = class(TBalancaVendaForm)
  private
    { Private declarations }
  protected
    procedure LePeso(out pPeso: Currency; out pDeuErro: Boolean;
      out pMens: string); override;
  public
    { Public declarations }
  end;

var
  BalancaTesteVendaForm: TBalancaTesteVendaForm;

implementation

{$R *.dfm}

uses System.Math;

{ TBalancaTesteVendaForm }

procedure TBalancaTesteVendaForm.LePeso(out pPeso: Currency;
  out pDeuErro: Boolean; out pMens: string);
begin
  inherited;
  pPeso := RoundTo(Random(10000) / 1000, -3);
  pDeuErro := False;
end;

end.
