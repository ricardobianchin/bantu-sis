unit App.UI.Form.Est.Saldo.HistProd_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.Types, Vcl.StdCtrls, Sis.UI.Frame.Bas.DBGrid_u, Sis.DBI, App.AppObj,
  Sis.DB.DBTypes;

type
  TEstSaldoHistProdForm = class(TBasForm)
    TopoPanel: TPanel;
    ProdIdTopoLabel: TLabel;
    DescrTopoLabel: TLabel;
    SempreVisivelCheckBox: TCheckBox;
    MeioPanel: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SempreVisivelCheckBoxClick(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    FProdId: TId;
    FDescrRed: string;
    FOnCloseForm: TProcedureIntegerOfObject;
    FDBGridFrame: TDBGridFrame;

    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;

    FEstSaldoHistProdFormDBI: IDBI;
    function GetOnCloseForm: TProcedureIntegerOfObject; // Getter
    procedure SetOnCloseForm(AValue: TProcedureIntegerOfObject); // Setter
  public  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    property OnCloseForm: TProcedureIntegerOfObject read GetOnCloseForm write SetOnCloseForm;

    constructor Create(AOwner: TComponent; pOnCloseForm: TProcedureIntegerOfObject; pProdId: TId; pDescrRed: string; pAppObj: IAppObj);
  end;

var
  EstSaldoHistProdForm: TEstSaldoHistProdForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils, App.DB.Utils, Sis.Sis.Constants, Sis.DB.Factory,
  App.Retag.Est.Factory, Sis.UI.Controls.Utils;

{ TEstSaldoHistProdForm }

procedure TEstSaldoHistProdForm.SempreVisivelCheckBoxClick(Sender: TObject);
begin
  inherited;
  if SempreVisivelCheckBox.Checked then
    FormStyle := TFormStyle.fsStayOnTop
  else
    FormStyle := TFormStyle.fsNormal;
end;

constructor TEstSaldoHistProdForm.Create(AOwner: TComponent; pOnCloseForm: TProcedureIntegerOfObject; pProdId: TId;
  pDescrRed: string; pAppObj: IAppObj);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);

  FDBConnection := DBConnectionCreate('TEstSaldoHistProdForm.'+pProdId.ToString+'.conn',
    FAppObj.SisConfig, FDBConnectionParams, nil, nil);

  FOnCloseForm := pOnCloseForm;
  FProdId := pProdId;
  FDescrRed := pDescrRed;

  ProdIdTopoLabel.Caption := Format('%7.7d', [FProdId]);
  DescrTopoLabel.Caption := pDescrRed;

  Caption := 'Histórico de Saldo - ' + ProdIdTopoLabel.Caption + ' - ' +
    DescrTopoLabel.Caption;
  FDBGridFrame := TDBGridFrame.Create(MeioPanel);
  FDBGridFrame.Align := alClient;
  FDBGridFrame.DBGrid1.Align := alClient;

  FEstSaldoHistProdFormDBI := EstSaldoHistProdFormDBICreate(FDBConnection, FAppObj);

  sNomeArq := FEstSaldoHistProdFormDBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDBGridFrame.FDMemTable1,
    FDBGridFrame.DBGrid1);

end;

procedure TEstSaldoHistProdForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Adiciona o estilo WS_EX_APPWINDOW para garantir o botão na barra de tarefas
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  // Garante que o formulário seja uma janela de nível superior
  Params.WndParent := 0;
end;

procedure TEstSaldoHistProdForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := TCloseAction.caFree;
  if Assigned(FOnCloseForm) then
    FOnCloseForm(FProdId);
end;

function TEstSaldoHistProdForm.GetOnCloseForm: TProcedureIntegerOfObject;
begin
  Result := FOnCloseForm;
end;

procedure TEstSaldoHistProdForm.SetOnCloseForm(AValue: TProcedureIntegerOfObject);
begin
  FOnCloseForm := AValue;
end;

procedure TEstSaldoHistProdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FormGarantaNaTela(Self);
end;

end.
