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
    procedure CancelAct_DiagExecute(Sender: TObject);
  private
    { Private declarations }
    FPeso: Currency;
    FDeuErro: Boolean;
    FMensagem: string;
    FStatusOutput: IOutput;
  protected
    procedure LePeso(out pPeso: Currency; out pDeuErro: Boolean;
      out pMensagem: string); virtual; abstract;
    procedure AjusteControles; override;
        function PodeOk: Boolean; override;
    property StatusOutput: IOutput read FStatusOutput;


  public
    { Public declarations }

    property Peso: Currency read FPeso;
    property DeuErro: Boolean read FDeuErro;
    property Mensagem: string read FMensagem;

    constructor Create(AOwner: TComponent); override;
  end;

var
  BalancaVendaForm: TBalancaVendaForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Factory;

{ TBalancaVendaForm }

procedure TBalancaVendaForm.AjusteControles;
begin
  inherited;
  LePeso(FPeso, FDeuErro, FMensagem);

  if FDeuErro then
    CancelAct_Diag.Execute
  else
    OkAct_Diag.Execute;
end;

procedure TBalancaVendaForm.CancelAct_DiagExecute(Sender: TObject);
begin
  inherited;
  FDeuErro := True;
  FMensagem := 'Ler Peso cancelado pelo usuário';
end;

constructor TBalancaVendaForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MensLabel.Parent := FundoPanel;
  AlteracaoTextoLabel.Parent := FundoPanel;
  FStatusOutput := LabelOutputCreate(StatusLabel);
  FStatusOutput.Exibir('Lendo peso...');
  SempreDisparaOnShow := True;
end;

function TBalancaVendaForm.PodeOk: Boolean;
begin
  Result := FPeso >= 0.001;
end;

end.
