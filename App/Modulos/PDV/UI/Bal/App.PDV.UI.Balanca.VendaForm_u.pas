unit App.PDV.UI.Balanca.VendaForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.Entities.Types, Sis.UI.IO.Output;

type
  TBalancaVendaForm = class(TDiagBasForm)
    FundoPanel: TPanel;
    TitLabel: TLabel;
    StatusLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPeso: Currency;
    FDeuErro: Boolean;
    FMens: string;
    FStatusOutput: IOutput;
  protected
    procedure LePeso(out pPeso: Currency; out pDeuErro: Boolean;
      out pMens: string); virtual; abstract;
    property StatusOutput: IOutput read FStatusOutput;
  public
    { Public declarations }

    property Peso: Currency read FPeso;
    property DeuErro: Boolean read FDeuErro;
    property Mens: string read FMens;

    constructor Create(AOwner: TComponent); override;
  end;

var
  BalancaVendaForm: TBalancaVendaForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Factory;

{ TBalancaVendaForm }

constructor TBalancaVendaForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MensLabel.Parent := FundoPanel;
  AlteracaoTextoLabel.Parent := FundoPanel;
  FStatusOutput := LabelOutputCreate(StatusLabel);
  FStatusOutput.Exibir('Lendo peso...');
end;

procedure TBalancaVendaForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LePeso(FPeso, FDeuErro, FMens);

  if FDeuErro then
    CancelAct_Diag.Execute
  else
    OkAct_Diag.Execute;
end;

end.
