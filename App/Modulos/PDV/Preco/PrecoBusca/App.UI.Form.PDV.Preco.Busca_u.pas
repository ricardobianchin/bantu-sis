unit App.UI.Form.PDV.Preco.Busca_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.DBGrid_u, Sis.Types,
  App.PDV.Preco.PrecoBusca.Um.Frame_u, Vcl.Mask, Sis.DB.DBTypes,
  Sis.Entities.Types, App.AppObj, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Sis.DB.FDDataSetManager, App.PDV.Preco.Utils, Sis.DBI,
  Sis.UI.Frame.Bas.Filtro.BuscaString_u, Vcl.ComCtrls, Vcl.ToolWin,
  Sis.UI.Constants;

type
  TPrecoBuscaForm = class(TDiagBasForm)
    FundoPanel: TPanel;
    BasePanel: TPanel;
    TitleBarPanel: TPanel;
    TitleBarCaptionLabel: TLabel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
    Edit1: TEdit;
    StatusPanel: TPanel;
    AjudaPanel: TPanel;
    AjudaLabel_PrecoBuscaForm: TLabel;
    TempoPanel: TPanel;
    TempoLabel_PrecoBuscaForm: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FecharToolButtonClick(Sender: TObject);
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

    procedure DispareBuscaTimer;
    procedure DoFiltroChange(Sender: TObject);
    procedure LeReg(q: TDataSet; pRecNo: integer);
    procedure BuscaStringEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    property DBI: IDBI read FDBI;
    procedure AjusteControles; override;
    property QtdRegsExibindo: TQuantidade read GetQtdRegsExibindo
      write SetQtdRegsExibindo;
    property PrecoBuscaTodosFrame: TDBGridFrame read FPrecoBuscaTodosFrame;

    procedure AjusteQtdRegsExibindo(pQtd: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pDBI: IDBI); reintroduce; virtual;
  end;

  // var
  // PrecoPregForm: TPrecoPregForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Controls.Utils, Sis.Types.strings_u,
  Sis.Types.Utils_u, System.Math, Sis.DB.Factory, Sis.Entities.Terminal,
  Sis.DB.DataSet.Utils, Sis.Types.Variants, System.DateUtils;

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
  FFDMemTable.Append;
  RecordToFDMemTable(q, FFDMemTable);
  FFDMemTable.Post;
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
  FFiltroFrame.BuscaStringEdit.OnKeyDown := BuscaStringEditKeyDown;
  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';

  sNomeArq := DBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable,
    FPrecoBuscaTodosFrame.DBGrid1);

  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  ToolBar1.Color := COR_AZUL_TITLEBAR;
  // DisparaShowTimer := True;
  MakeRounded(Self, 30);

  ///
  Height := Min(1000, Screen.WorkAreaRect.Height - 10);
  Width := 700;

  FundoPanel.Align := alClient;

  // WindowState := TWindowState.wsMaximized;
  BorderStyle := TFormBorderStyle.bsNone;
  ClearStyleElements(FFiltroFrame);
  FFiltroFrame.Font.Size := 14;
  FFiltroFrame.BuscaStringEdit.Width := 150;
  FFiltroFrame.BuscaStringEdit.Left := FFiltroFrame.FiltroTitLabel.Left +
    FFiltroFrame.FiltroTitLabel.Width + 5;
  FFiltroFrame.AutoSize := True;
  BasePanel.Height := 50;
  FPrecoBuscaTodosFrame.DBGrid1.Align := alClient;

end;

procedure TPrecoBuscaForm.AjusteControles;
begin
  inherited;
  FFiltroFrame.BuscaStringEdit.SetFocus;
end;

procedure TPrecoBuscaForm.AjusteQtdRegsExibindo(pQtd: integer);
begin
  if pQtd <= 0 then
    QtdRegsExibindo := qtdNenhu
  else if pQtd = 1 then
    QtdRegsExibindo := qtdUm
  else { (pQtd <= 0 or pQtd > 1) }
    QtdRegsExibindo := qtdTodos;
end;

procedure TPrecoBuscaForm.BuscaStringEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN:
      SimuleTecla(Key, PrecoBuscaTodosFrame.DBGrid1);
  end;
end;

procedure TPrecoBuscaForm.DispareBuscaTimer;
begin

end;

procedure TPrecoBuscaForm.DoFiltroChange(Sender: TObject);
var
  sBusca: string;
  ti, tf, delta: TDateTime;
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
    ti := NOW;
    FFDMemTable.BeginBatch();
    try
      FDBI.ForEach(FFiltroFrame.Values, LeReg);
    finally
      FFDMemTable.EndBatch;
      tf := NOW;
      delta := tf - ti;
    end;
  finally
    FFDMemTable.First;
    FFDMemTable.EnableControls;
    AjusteQtdRegsExibindo(FFDMemTable.RecordCount);
    TempoLabel_PrecoBuscaForm.Caption := 'Consultado em: ' + DateTimeToStr(NOW)
      + ' Tempo(s): ' + FormatFloat('######0.000', SecondSpan(ti, tf));
  end;
end;

procedure TPrecoBuscaForm.FecharToolButtonClick(Sender: TObject);
begin
  inherited;
  CancelAct_Diag.Execute;
end;

procedure TPrecoBuscaForm.FormShow(Sender: TObject);
begin
  inherited;
  ToolBar1.Left := Width - ToolBar1.Width;

  TitleBarCaptionLabel.Caption := 'BUSCA PREÇO';
  TitleBarCaptionLabel.StyleElements := [];
  TitleBarCaptionLabel.Font.Color := clWhite;
  AlteracaoTextoLabel.Parent := FundoPanel;

  ControlAlignToCenter(TitleBarCaptionLabel);
  ControlAlignToRect(Self, Screen.WorkAreaRect);
  ControlAlignToCenter(FFiltroFrame);

end;

procedure TPrecoBuscaForm.SetQtdRegsExibindo(const Value: TQuantidade);
begin
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
      FPrecoBuscaUmFrame.PegarRecord(FFDMemTable);
    end;
  end;
end;

end.
