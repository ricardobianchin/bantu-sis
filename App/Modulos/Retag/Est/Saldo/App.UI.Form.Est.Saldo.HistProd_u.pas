unit App.UI.Form.Est.Saldo.HistProd_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.Types, Vcl.StdCtrls,
  Sis.UI.Frame.Bas.DBGrid_u, Sis.DBI, App.AppObj,
  Sis.DB.DBTypes, System.Actions, Vcl.ActnList, Vcl.ToolWin, Vcl.ComCtrls,
  Data.DB;

type
  TEstSaldoHistProdForm = class(TBasForm)
    TopoPanel: TPanel;
    ProdIdTopoLabel: TLabel;
    DescrTopoLabel: TLabel;
    MeioPanel: TPanel;
    ActionList1: TActionList;
    AtuAction: TAction;
    BasePanel: TPanel;
    SempreVisivelCheckBox: TCheckBox;
    ToolBar1: TToolBar;
    AtuToolButton: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SempreVisivelCheckBoxClick(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure AtuActionExecute(Sender: TObject);
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
    FSaldo: Currency;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
    function GetOnCloseForm: TProcedureIntegerOfObject; // Getter
    procedure SetOnCloseForm(AValue: TProcedureIntegerOfObject); // Setter
  public
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    property OnCloseForm: TProcedureIntegerOfObject read GetOnCloseForm
      write SetOnCloseForm;

    constructor Create(AOwner: TComponent;
      pOnCloseForm: TProcedureIntegerOfObject; pProdId: TId; pDescrRed: string;
      pAppObj: IAppObj);
  end;

var
  EstSaldoHistProdForm: TEstSaldoHistProdForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils, App.DB.Utils, Sis.Sis.Constants, Sis.DB.Factory,
  App.Retag.Est.Factory, Sis.UI.Controls.Utils, Sis.UI.Controls.TDBGrid,
  App.Est.Types_u;

{ TEstSaldoHistProdForm }

procedure TEstSaldoHistProdForm.SempreVisivelCheckBoxClick(Sender: TObject);
begin
  inherited;
  if SempreVisivelCheckBox.Checked then
    FormStyle := TFormStyle.fsStayOnTop
  else
    FormStyle := TFormStyle.fsNormal;
end;

procedure TEstSaldoHistProdForm.AtuActionExecute(Sender: TObject);
var
  Values: Variant;
begin
  inherited;
  FDBGridFrame.FDMemTable1.DisableControls;
  FDBGridFrame.FDMemTable1.BeginBatch;
  FDBGridFrame.FDMemTable1.EmptyDataSet;

  Values := VarArrayCreate([0, 1], varVariant);
  Values[0] := FAppObj.Loja.Id;
  Values[1] := FProdId;

  try
    FSaldo := 0;
    FEstSaldoHistProdFormDBI.ForEach(Values, LeRegEInsere);
  finally
    FDBGridFrame.FDMemTable1.First;
    FDBGridFrame.FDMemTable1.EndBatch;
    FDBGridFrame.FDMemTable1.EnableControls;
    DBGridPosicioneColumnVisible(FDBGridFrame.DBGrid1);
  end;
end;

constructor TEstSaldoHistProdForm.Create(AOwner: TComponent;
  pOnCloseForm: TProcedureIntegerOfObject; pProdId: TId; pDescrRed: string;
  pAppObj: IAppObj);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);

  FDBConnection := DBConnectionCreate('TEstSaldoHistProdForm.' +
    pProdId.ToString + '.conn', FAppObj.SisConfig, FDBConnectionParams,
    nil, nil);

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

  FEstSaldoHistProdFormDBI := EstSaldoHistProdFormDBICreate
    (FDBConnection, FAppObj);

  sNomeArq := FEstSaldoHistProdFormDBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDBGridFrame.FDMemTable1,
    FDBGridFrame.DBGrid1);
  Width := 573;
  Height := 600;
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

procedure TEstSaldoHistProdForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
  sPrefixo: string;
  iTerminalId: SmallInt;
  iDocId: integer;
  iOrdem: SmallInt;
  uQtd: Currency;
  sTipo: string;
  bCodUsaTerm: Boolean;
  sCod: string;
begin
  if pRecNo = -1 then
    exit;

  FDBGridFrame.FDMemTable1.Append;

  for i := 0 to q.FieldCount - 1 do
  begin
    FDBGridFrame.FDMemTable1.Fields[i].Value := q.Fields[i].Value;
  end;

  sPrefixo := q.Fields[1].AsString;
  iOrdem := q.Fields[5].AsInteger + 1;
  iDocId := q.Fields[6].AsInteger;


  sTipo := q.Fields[8].AsString;
  uQtd := q.Fields[10].AsCurrency;
  EstSaldoHistCalc(FSaldo, uQtd, sTipo, bCodUsaTerm);
  FDBGridFrame.FDMemTable1.Fields[11].AsCurrency := FSaldo;

  if bCodUsaTerm then
  begin
    iTerminalId := q.Fields[3].AsInteger;
    sCod := Format('%s-%.3d-%.3d-%.8d-%d', [sprefixo, FAppObj.Loja.Id, iTerminalId, iDocId, iOrdem]);
  end
  else
  begin
    sCod := Format('%s-%.3d-%.8d-%d', [sprefixo, FAppObj.Loja.Id, iDocId, iOrdem]);
  end;

  FDBGridFrame.FDMemTable1.Fields[7].AsString := sCod;
  FDBGridFrame.FDMemTable1.Post;
end;

procedure TEstSaldoHistProdForm.SetOnCloseForm
  (AValue: TProcedureIntegerOfObject);
begin
  FOnCloseForm := AValue;
end;

procedure TEstSaldoHistProdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FormGarantaNaTela(Self);
  AtuAction.Execute;
  SempreVisivelCheckBoxClick(SempreVisivelCheckBox);
end;

end.
