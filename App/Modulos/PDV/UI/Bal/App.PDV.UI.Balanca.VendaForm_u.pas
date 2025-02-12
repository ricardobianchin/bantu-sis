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
    FPesoCurrency: Currency;
    FDeuErro: Boolean;
    FMensagem: string;
    FStatusOutput: IOutput;
  protected
    procedure LePeso(out pPesoCurrency: Currency; out pDeuErro: Boolean;
      out pMensagem: string); virtual; abstract;
    procedure AjusteControles; override;
    function PodeOk: Boolean; override;
    property StatusOutput: IOutput read FStatusOutput;

  public
    { Public declarations }

    property PesoCurrency: Currency read FPesoCurrency write FPesoCurrency;
    property DeuErro: Boolean read FDeuErro write FDeuErro;
    property Mensagem: string read FMensagem write FMensagem;

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
  try
    try
      LePeso(FPesoCurrency, FDeuErro, FMensagem);
    except
      on e: exception do
      begin
        FDeuErro := True;
        FMensagem := e.Message;
      end;
    end;
  finally
    if FDeuErro then
      ModalResult := mrCancel
    else
      OkAct_Diag.Execute;
  end;
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
  Result := FPesoCurrency >= 0.001;
end;

end.
