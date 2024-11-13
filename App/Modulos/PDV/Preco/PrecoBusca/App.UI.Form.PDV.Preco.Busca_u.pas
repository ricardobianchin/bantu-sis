unit App.UI.Form.PDV.Preco.Busca_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.DBGrid_u, Sis.Types,
  App.PDV.Preco.PrecoBusca.Um.Frame_u, Vcl.Mask, Sis.DB.DBTypes, Sis.Entities.Types,
  App.AppObj, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, App.PDV.Preco.Utils, Sis.DBI, Sis.UI.Frame.Bas.Filtro.BuscaString_u;

type
  TPrecoBuscaForm = class(TDiagBasForm)
    FundoPanel: TPanel;
    BasePanel: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FDBI: IDBI;

    FQtdRegsExibindo: TQuantidade;
    FPrecoBuscaTodosFrame: TDBGridFrame;
    FPrecoBuscaUmFrame: TPrecoBuscaUmFrame;

    FFDMemTable: TFDMemTable;
    FFiltroFrame: TFiltroStringFrame;

    function GetQtdRegsExibindo: TQuantidade;
    procedure SetQtdRegsExibindo(const Value: TQuantidade);

    function BuscaStrToTipo(pStr: string): TProdBuscaTipo;
    function BuscaStrToProc(pStr: string): TProcedureStringOfObject;
    procedure DispareBuscaTimer;
    procedure DoFiltroChange(Sender: TObject);
    procedure LeReg(q: TDataSet; pRecNo: integer);
  protected
    property DBI: IDBI read FDBI;
    procedure AjusteControles; override;
    property QtdRegsExibindo: TQuantidade read GetQtdRegsExibindo write SetQtdRegsExibindo;
    property PrecoBuscaTodosFrame: TDBGridFrame read FPrecoBuscaTodosFrame;

    procedure Buscar(pStr: string);

    procedure AjusteQtdRegsExibindo(pQtd: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pDBI: IDBI); reintroduce; virtual;
  end;

  // var
  // PrecoPregForm: TPrecoPregForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.Types.strings_u, Sis.Types.Utils_u, System.Math,
  Sis.DB.Factory, Sis.Entities.Terminal, Sis.DB.DataSet.Utils, Sis.Types.Variants;

{ TPrecoPregForm }

function TPrecoBuscaForm.GetQtdRegsExibindo: TQuantidade;
begin
  Result := FQtdRegsExibindo;
end;

procedure TPrecoBuscaForm.LeReg(q: TDataSet; pRecNo: integer);
begin
  if pRecNo = -1 then
  begin
    exit;
  end;
  RecordToFDMemTable(q, FFDMemTable);
end;

constructor TPrecoBuscaForm.Create(AOwner: TComponent; pDBI: IDBI);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FDBI := pDBI;

  FPrecoBuscaTodosFrame := TDBGridFrame.Create(FundoPanel);
  FPrecoBuscaUmFrame := TPrecoBuscaUmFrame.Create(FundoPanel);

  FPrecoBuscaTodosFrame.Align := alClient;
  FPrecoBuscaUmFrame.Align := alClient;
  SetQtdRegsExibindo(qtdNenhu);

  FFiltroFrame := TFiltroStringFrame.Create(BasePanel, DoFiltroChange);
  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';

  sNomeArq := DBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable,
    FPrecoBuscaTodosFrame.DBGrid1);
end;

procedure TPrecoBuscaForm.AjusteControles;
begin
  inherited;
  Height := Min(1000, Screen.WorkAreaRect.Height-10);
  Width := 700;
  ControlAlignToRect(Self, Screen.WorkAreaRect);

  // ClearStyleElements(Self);
  FundoPanel.Align := alClient;


  // WindowState := TWindowState.wsMaximized;
  BorderStyle := TFormBorderStyle.bsNone;
  ControlAlignToCenter(FFiltroFrame);
end;

procedure TPrecoBuscaForm.AjusteQtdRegsExibindo(pQtd: integer);
begin
  if pQtd <= 0 then
    QtdRegsExibindo := qtdNenhu
  else if pQtd = 1 then
    QtdRegsExibindo := qtdUm
  else {(pQtd <= 0 or pQtd > 1)}
    QtdRegsExibindo := qtdTodos;
end;

procedure TPrecoBuscaForm.DispareBuscaTimer;
begin

end;

procedure TPrecoBuscaForm.DoFiltroChange(Sender: TObject);
var
  sBusca: string;
begin
  FFDMemTable.DisableControls;
  FFDMemTable.EmptyDataSet;
  try
    sBusca := VarToString(FFiltroFrame.Values[0]);
    sBusca := Trim(sBusca);

    if sBusca = '' then
    begin
      exit;
    end;

    FDBI.PreencherDataSet(FFiltroFrame.Values, LeReg);
  finally
    FFDMemTable.First;
    FFDMemTable.EnableControls;
    AjusteQtdRegsExibindo(FFDMemTable.RecordCount);
  end;
end;

procedure TPrecoBuscaForm.Buscar(pStr: string);
var
  FProcBuscar: TProcedureStringOfObject;
begin
  FProcBuscar := BuscaStrToProc(pStr);
  FProcBuscar(pStr);
end;

function TPrecoBuscaForm.BuscaStrToProc(pStr: string): TProcedureStringOfObject;
begin

end;

function TPrecoBuscaForm.BuscaStrToTipo(pStr: string): TProdBuscaTipo;
begin

end;

procedure TPrecoBuscaForm.SetQtdRegsExibindo(const Value: TQuantidade);
begin
  if FQtdRegsExibindo = Value then
    exit;

  FQtdRegsExibindo := Value;
  case FQtdRegsExibindo of
    qtdTodos:
      begin
        FPrecoBuscaTodosFrame.Visible := True;
        FPrecoBuscaUmFrame.Visible := False;
      end;
  else // qtdNenhu, qtdUm:
    begin
      FPrecoBuscaTodosFrame.Visible := False;
      FPrecoBuscaUmFrame.Visible := True;
    end;
  end;
end;

procedure TPrecoBuscaForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FFiltroFrame.Values := VarToVarArray('A');
end;



end.
