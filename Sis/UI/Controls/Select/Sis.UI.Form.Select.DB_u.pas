unit Sis.UI.Form.Select.DB_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Select_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Sis.Types,
  Vcl.StdCtrls, Sis.DB.FDDataSetManager, Sis.DBI, Sis.UI.Frame.Bas.DBGrid_u,
  Sis.UI.Frame.Bas.Filtro_u, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDBSelectForm = class(TSelectForm)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FDBI: IDBI;
    FDBGridFrame: TDBGridFrame;
    FFiltro: TFiltroFrame;

    procedure DoFiltroChange(Sender: TObject);
    procedure LeReg(q: TDataSet; pRecNo: integer);
    procedure AtualizeQtdRegs;
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);

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

uses Sis.DB.DataSet.Utils, Sis.Types.strings_u, Sis.UI.Controls.Utils;

{ TDBSelectForm }

procedure TDBSelectForm.AjusteControles;
begin
  inherited;
  if Filtro.Values[0] = '' then
    DoFiltroChange(nil);
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
begin
  inherited Create(nil);
  FDBI := pDBI;
  FFiltro := pFiltro;
  FFiltro.Parent := BasePanel;
//  FFiltro.Align := alTop;
  FFiltro.Top := 0;
  FFiltro.Left := 20;
  FFiltro.OnChange := DoFiltroChange;

  QtdRegsLabel.Top := 4;

  FDBGridFrame := TDBGridFrame.Create(FundoPanel);
  FDBGridFrame.Parent := FundoPanel;
  FDBGridFrame.Align := alClient;
  FDBGridFrame.DBGrid1.Align := alClient;
  FDBGridFrame.DBGrid1.TabStop := False;
  Width := 800;
  Height := 550;

  sNomeArq := DBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDBGridFrame.FDMemTable1,
    FDBGridFrame.DBGrid1);
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
    VK_PRIOR: begin for i := 1 to 23 do begin FDBGridFrame.FDMemTable1.Prior; end; end;
    VK_NEXT: begin for i := 1 to 23 do begin FDBGridFrame.FDMemTable1.Next; end; end;
    VK_UP: FDBGridFrame.FDMemTable1.Prior;
    VK_DOWN: FDBGridFrame.FDMemTable1.Next;
  end;
  FDBGridFrame.FDMemTable1.EnableControls;
end;

procedure TDBSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    if FDBGridFrame.FDMemTable1.IsEmpty then
    begin
      ErroOutput.Exibir('Não há registro selecionável');
      exit;
    end;
    OkAct_Diag.execute;
  end;
  inherited;

end;

function TDBSelectForm.GetLastSelected: string;
begin
  Result :=FDBGridFrame.FDMemTable1.Fields[0].AsString;
end;

end.
