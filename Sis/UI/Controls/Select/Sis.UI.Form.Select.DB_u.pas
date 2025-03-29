unit Sis.UI.Form.Select.DB_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Select_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Sis.Types,
  Vcl.StdCtrls, Sis.DB.FDDataSetManager, Sis.DBI, Sis.UI.Frame.Bas.DBGrid_u,
  Sis.UI.Frame.Bas.Filtro_u, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.ToolWin;

const
  GRID_FONT_SIZE = 9;
  GRID_ALTU = 254;

type
  TDadosColuna = record
    WidthOriginal: integer;
    WidthOriginalTotal: integer;
    function GetWidthAtual(WidthOriginalTotalAtual: integer): integer;

  end;

  TDBSelectForm = class(TSelectForm)
    TitleBarPanel: TPanel;
    TitleBarCaptionLabel: TLabel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FDBI: IDBI;
    FDBGridFrame: TDBGridFrame;
    FFiltro: TFiltroFrame;
    FDadosColunaArray: TArray<TDadosColuna>;
    FAjustaTamanho: Boolean;

    procedure DoFiltroChange(Sender: TObject);
    procedure LeReg(q: TDataSet; pRecNo: integer);
    procedure AtualizeQtdRegs;
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);

    procedure AjusteTamanhos;

  protected
    function GetLastSelected: string; override;
    procedure AjusteControles; override;

  public
    { Public declarations }
    function Execute(pParams: string = ''): Boolean; override;
    property DBI: IDBI read FDBI;
    property Filtro: TFiltroFrame read FFiltro;

    constructor Create(pDBI: IDBI; pFiltro: TFiltroFrame); reintroduce; virtual;
  end;

var
  DBSelectForm: TDBSelectForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils, Sis.Types.strings_u, Sis.UI.Controls.Utils,
  Sis.UI.Constants;

{ TDBSelectForm }

procedure TDBSelectForm.AjusteControles;
begin
  inherited;
  if Filtro.Values[0] = '' then
    DoFiltroChange(nil);
end;

procedure TDBSelectForm.AjusteTamanhos;
var
  i: integer;
  iLarg: integer;
  iFontSize: integer;
begin
  if not FAjustaTamanho then
    exit;

  iLarg := (FDBGridFrame.DBGrid1.Width * 95) div 100;

  for i := 0 to FDBGridFrame.DBGrid1.Columns.Count - 1 do
  begin
    FDBGridFrame.DBGrid1.Columns[i].Width := FDadosColunaArray[i].GetWidthAtual( iLarg);
  end;

  iFontSize := (GRID_FONT_SIZE * FDBGridFrame.DBGrid1.Height) div GRID_ALTU;
  FDBGridFrame.DBGrid1.Font.Size := iFontSize;
  FDBGridFrame.DBGrid1.TitleFont.Size := (iFontSize * 9) div 10;

  FFiltro.FontSize := (9 * Height) div 254;
  QtdRegsLabel.Font.Size := (5 * Height) div 254;
  MensLabel.Font.Size := (6 * Height) div 254;
  TitleBarCaptionLabel.Font.Size := (6 * Height) div 254;
  TitleBarCaptionLabel.Left := TitleBarPanel.Width div 50;
  TitleBarCaptionLabel.Top := (TitleBarPanel.Height - TitleBarCaptionLabel.Height) div 2;

  //ControlAlignToRect(TitleBarCaptionLabel, TitleBarPanel.ClientRect);
  ControlAlignToCenter(FFiltro);
//  maximizar, borderst
end;

procedure TDBSelectForm.AtualizeQtdRegs;
var
  sFormat: string;
  sMens: string;
begin
  inherited;
  sFormat := '%d Registros';
  sMens := Format(sFormat, [FDBGridFrame.FDMemTable1.RecordCount]);
  QtdRegsLabel.Caption := sMens;
end;

constructor TDBSelectForm.Create(pDBI: IDBI; pFiltro: TFiltroFrame);
var
  sNomeArq: string;
  i: integer;
  iWidthTotalOriginal: integer;
begin
  FAjustaTamanho := False;
  inherited Create(nil);
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  ToolBar1.Color := COR_AZUL_TITLEBAR;
  // MakeRounded(Self, 30);

  FDBI := pDBI;
  FFiltro := pFiltro;
  FFiltro.Parent := BasePanel;
  // FFiltro.Align := alTop;
  FFiltro.Top := 0;
  FFiltro.Left := 20;
  FFiltro.OnChange := DoFiltroChange;
  FFiltro.AutoSize := True;

  QtdRegsLabel.Top := 4;

  FDBGridFrame := TDBGridFrame.Create(FundoPanel);
  FDBGridFrame.Parent := FundoPanel;
  FDBGridFrame.Align := alClient;
  FDBGridFrame.DBGrid1.Align := alClient;
  FDBGridFrame.DBGrid1.TabStop := False;

//  WindowState := TWindowState.wsMaximized;
  BorderStyle := TFormBorderStyle.bsNone;
  WindowState := TWindowState.wsNormal;
//  BorderStyle := TFormBorderStyle.bsSizeable;
  Top := 0;
  Left := 0;
  Width := Screen.WorkAreaRect.Width;
  Height := Screen.WorkAreaRect.Height;

  sNomeArq := DBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDBGridFrame.FDMemTable1,
    FDBGridFrame.DBGrid1);

  SetLength(FDadosColunaArray, FDBGridFrame.DBGrid1.Columns.Count);
  iWidthTotalOriginal := 0;
  for i := 0 to FDBGridFrame.DBGrid1.Columns.Count - 1 do
  begin
    FDadosColunaArray[i].WidthOriginal := FDBGridFrame.DBGrid1.Columns[i].Width;
    inc(iWidthTotalOriginal, FDadosColunaArray[i].WidthOriginal);
  end;

  for i := 0 to FDBGridFrame.DBGrid1.Columns.Count - 1 do
  begin
    FDadosColunaArray[i].WidthOriginalTotal := iWidthTotalOriginal;
  end;
  FAjustaTamanho := True;

  AjusteTamanhos;
end;

procedure TDBSelectForm.DBGrid1DblClick(Sender: TObject);
begin
  OkAct_Diag.Execute;
end;

procedure TDBSelectForm.DBGrid1Enter(Sender: TObject);
begin
  Filtro.SetFocus;
end;

procedure TDBSelectForm.DoFiltroChange(Sender: TObject);
var
  T: TFDMemTable;
begin
  T := FDBGridFrame.FDMemTable1;
  T.DisableControls;
  T.EmptyDataSet;
  try
    T.BeginBatch();
    try
      FDBI.ForEach(FFiltro.Values, LeReg);
    finally
      T.EndBatch;
    end;
  finally
    T.First;
    T.EnableControls;
    AtualizeQtdRegs;
  end;
end;

procedure TDBSelectForm.LeReg(q: TDataSet; pRecNo: integer);
var
  T: TFDMemTable;
begin
  if pRecNo = -1 then
  begin
    exit;
  end;
  T := FDBGridFrame.FDMemTable1;

  T.Append;
  RecordToFDMemTable(q, T);
  T.Post;
end;

procedure TDBSelectForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  AjusteTamanhos;
end;

function TDBSelectForm.Execute(pParams: string): Boolean;
var
  aParams: TArray<string>;
  i: integer;
  aValores: variant;
  iQtdParams: integer;
begin
  aParams := pParams.Split([';']);
  iQtdParams := Length(aParams);
  if iQtdParams > 0 then
  begin
    aValores := VarArrayCreate([0, iQtdParams - 1], varVariant);
    for i := 0 to iQtdParams - 1 do
    begin
      aValores[i] := aParams[i];
    end;
  end
  else
  begin
    aValores := VarArrayCreate([0, 0], varVariant);
    aValores[0] := '';
  end;
  Filtro.Values := aValores;

  result := Perg
end;

procedure TDBSelectForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer;
begin
  inherited;
  FDBGridFrame.FDMemTable1.DisableControls;
  case Key of
    VK_PRIOR:
      begin
        for i := 1 to 23 do
        begin
          FDBGridFrame.FDMemTable1.Prior;
        end;
      end;
    VK_NEXT:
      begin
        for i := 1 to 23 do
        begin
          FDBGridFrame.FDMemTable1.Next;
        end;
      end;
    VK_UP:
      FDBGridFrame.FDMemTable1.Prior;
    VK_DOWN:
      FDBGridFrame.FDMemTable1.Next;
  end;
  FDBGridFrame.FDMemTable1.EnableControls;
end;

procedure TDBSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if FDBGridFrame.FDMemTable1.IsEmpty then
    begin
      ErroOutput.Exibir('Não há registro selecionável');
      exit;
    end;
    OkAct_Diag.Execute;
  end;
  inherited;

end;

procedure TDBSelectForm.FormResize(Sender: TObject);
begin
  inherited;
  AjusteTamanhos;
end;

function TDBSelectForm.GetLastSelected: string;
begin
  result := FDBGridFrame.FDMemTable1.Fields[0].AsString;
end;

{ TDadosColuna }

function TDadosColuna.GetWidthAtual(WidthOriginalTotalAtual: integer): integer;
begin
  result := (WidthOriginal * WidthOriginalTotalAtual) div WidthOriginalTotal;
end;

end.
