unit App.UI.Form.PDV.Preco.Busca_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.DBGrid_u, Sis.Types,
  App.PDV.Preco.PrecoBusca.Um.Frame_u, Vcl.Mask, Sis.DB.DBTypes,
  Sis.Entities.Types, App.AppObj, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Sis.DB.FDDataSetManager, App.Prod.BuscaTipo_u, Sis.DBI,
  Sis.UI.Frame.Bas.Filtro.BuscaString_u, Vcl.ComCtrls, Vcl.ToolWin,
  Sis.UI.Constants, Vcl.DBGrids;

const
  LARG_ORIGINAL = 1366;
  ALTU_ORIGINAL = 737;
  FILTRO_FONT_SIZE = 24 / ALTU_ORIGINAL;
  GRID_FONT_SIZE = 16 / ALTU_ORIGINAL;

const
  ColumnWidths: array[0..4] of Integer = (80, 580, 160, 148, 260);

type
  TPrecoBuscaForm = class(TDiagBasForm)
    FundoPanel: TPanel;
    BasePanel: TPanel;
    TitleBarPanel: TPanel;
    TitleBarCaptionLabel: TLabel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
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
    procedure AjusteTamanhos; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pDBI: IDBI); reintroduce; virtual;
  end;

  // var
  // PrecoPregForm: TPrecoPregForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Controls.Utils, Sis.Types.strings_u,
  Sis.Types.Utils_u, System.Math, Sis.DB.Factory, Sis.Terminal,
  Sis.DB.DataSet.Utils, Sis.Types.Variants, System.DateUtils, Sis.UI.Controls.TDBGrid;

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
  MensLabel.Parent := BasePanel;
  MensLabel.VIsible := False;

  FDBI := pDBI;

  Left := Screen.WorkAreaRect.Left;
  Top := Screen.WorkAreaRect.Top;
  Width := Screen.WorkAreaRect.Right - Screen.WorkAreaRect.Left;
  Height := Screen.WorkAreaRect.Bottom - Screen.WorkAreaRect.Top;

  FPrecoBuscaTodosFrame := TDBGridFrame.Create(FundoPanel);
  FPrecoBuscaUmFrame := TPrecoBuscaUmFrame.Create(FundoPanel);

  FPrecoBuscaTodosFrame.Align := alClient;
  FPrecoBuscaUmFrame.Align := alClient;
  SetQtdRegsExibindo(qtdNenhu);

  BasePanel.AutoSize := True;

  FFiltroFrame := TFiltroStringFrame.Create(BasePanel, DoFiltroChange);
  FFiltroFrame.FiltroStringEdit.OnKeyDown := BuscaStringEditKeyDown;
  FFiltroFrame.AutoSize := True;

  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';

  sNomeArq := DBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable,
    FPrecoBuscaTodosFrame.DBGrid1);

  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  ToolBar1.Color := COR_AZUL_TITLEBAR;
//  MakeRounded(Self, 30);

  ///
  // Height := Min(1000, Screen.WorkAreaRect.Height - 10);
  // Width := 700;

  FundoPanel.Align := alClient;

  WindowState := TWindowState.wsMaximized;
  BorderStyle := TFormBorderStyle.bsNone;
//  WindowState := TWindowState.wsNormal;
//  BorderStyle := TFormBorderStyle.bsSizeable;
//  Width := 600;
//  Height := 400;
//  Top := 10;
//  Left := 10;
  ClearStyleElements(FFiltroFrame);
  FPrecoBuscaTodosFrame.DBGrid1.Align := alClient;

end;

procedure TPrecoBuscaForm.AjusteControles;
begin
  inherited;
  FFiltroFrame.FiltroStringEdit.SetFocus;
  StatusPanel.Top := FundoPanel.Height + 10;
  FFiltroFrame.Top := FundoPanel.Height div 2;
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

procedure TPrecoBuscaForm.AjusteTamanhos;
var
  i: integer;
  g: TDBGrid;
begin
  inherited;
  if not Assigned(FFiltroFrame) then
    exit;

//  BasePanel.Height := 120;
  FFiltroFrame.Top := 0;
  // FFiltroFrame.Height
  FFiltroFrame.Font.Size := (24 * height) div ALTU_ORIGINAL;
  FFiltroFrame.FiltroStringEdit.Left := FFiltroFrame.FiltroTitLabel.Left +
    FFiltroFrame.FiltroTitLabel.Width + 5;
  FFiltroFrame.FiltroStringEdit.Width := (200 * Width) div LARG_ORIGINAL;

  g := FPrecoBuscaTodosFrame.DBGrid1;
  g.Font.Size := (20 * height) div ALTU_ORIGINAL;
  G.TitleFont.Size := (g.Font.Size * 9) div 10;
  for i := 0 to g.Columns.Count - 1 do
  begin
    g.columns[i].width := (width * ColumnWidths[i]) div LARG_ORIGINAL;
  end;

  FPrecoBuscaUmFrame.PrecoLabel.height := FPrecoBuscaUmFrame.Height div 2;
  FPrecoBuscaUmFrame.DescrLabel.height := FPrecoBuscaUmFrame.PrecoLabel.height - 1;

  FPrecoBuscaUmFrame.PrecoLabel.Font.Size := (75 * FPrecoBuscaUmFrame.Height) div 400;
  FPrecoBuscaUmFrame.DescrLabel.Font.Size := (27 * FPrecoBuscaUmFrame.Height) div 400;

  ControlAlignToCenter(TitleBarCaptionLabel);
  ControlAlignToCenter(FFiltroFrame);
end;

procedure TPrecoBuscaForm.BuscaStringEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN:
      SimuleTecla(Key, PrecoBuscaTodosFrame.DBGrid1);
  end;
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
end;

procedure TPrecoBuscaForm.SetQtdRegsExibindo(const Value: TQuantidade);
begin
  FQtdRegsExibindo := Value;
  case FQtdRegsExibindo of
    qtdTodos:
      begin
        FPrecoBuscaTodosFrame.VIsible := True;
        FPrecoBuscaUmFrame.VIsible := False;
      end;
  else // qtdNenhu, qtdUm:
    begin
      FPrecoBuscaTodosFrame.VIsible := False;
      FPrecoBuscaUmFrame.VIsible := True;
      FPrecoBuscaUmFrame.PegarRecord(FFDMemTable);
    end;
  end;
end;

end.
