unit App.PDV.UI.Balanca.VendaForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, App.PDV.UI.Balanca, Sis.Entities.Types;

type
  TBalancaVendaForm = class(TDiagBasForm)
    FundoPanel: TPanel;
    TitLabel: TLabel;
    StatusLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FBalanca: IBalanca;
    FPeso: string;
    FDeuErro: Boolean;
    FMens: string;
  public
    { Public declarations }

    property Peso: string read FPeso;
    property DeuErro: Boolean read FDeuErro;
    property Mens: string read FMens;

    constructor Create(AOwner: TComponent; pBalanca: IBalanca); reintroduce;
  end;

procedure PergPeso(pBalanca: IBalanca; out pPeso: string; out pErroDeu: Boolean;
  out pMens: string);

var
  BalancaVendaForm: TBalancaVendaForm;

implementation

{$R *.dfm}

procedure PergPeso(pBalanca: IBalanca; out pPeso: string; out pErroDeu: Boolean;
  out pMens: string);
begin
  BalancaVendaForm := TBalancaVendaForm.Create(nil, pBalanca);
  pErroDeu := not BalancaVendaForm.Perg;
  pPeso := BalancaVendaForm.Peso;
  pMens := BalancaVendaForm.Mens;

end;

{ TBalancaVendaForm }

constructor TBalancaVendaForm.Create(AOwner: TComponent; pBalanca: IBalanca);
begin
  inherited Create(AOwner);
  MensLabel.Parent := FundoPanel;
  AlteracaoTextoLabel.Parent := FundoPanel;
  FBalanca := pBalanca;
end;

procedure TBalancaVendaForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FBalanca.LePeso(FPeso, FDeuErro, FMens);

  if FDeuErro then
    CancelAct_Diag.Execute
  else
    OkAct_Diag.Execute;
end;

end.
