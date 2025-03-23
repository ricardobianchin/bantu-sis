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
  private
    { Private declarations }
    FDBI: IDBI;
    FGridFrame: TDBGridFrame;
    FFiltro: TFiltroFrame;

    procedure DoFiltroChange(Sender: TObject);
    procedure LeReg(q: TDataSet; pRecNo: integer);
    procedure AtualizeQtdRegs;

  protected

  public
    { Public declarations }
    function Perg(pParams: string = ''): Boolean; override;
    property DBI: IDBI read FDBI;
    property Filtro: TFiltroFrame read FFiltro;
    constructor Create(pDBI: IDBI; pFiltro: TFiltroFrame); reintroduce; virtual;
  end;

var
  DBSelectForm: TDBSelectForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils;

{ TDBSelectForm }

procedure TDBSelectForm.AtualizeQtdRegs;
var
  sFormat: string;
  sMens: string;
begin
  inherited;
  sFormat := '%d Registros';
  sMens := Format(sFormat, [FGridFrame.FDMemTable1.RecordCount]);
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
  FFiltro.Align := alTop;
  FFiltro.OnChange := DoFiltroChange;

  FGridFrame := TDBGridFrame.Create(FundoPanel);
  FGridFrame.Align := alClient;

  sNomeArq := DBI.GetNomeArqTabView(varNull);
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FGridFrame.FDMemTable1,
    FGridFrame.DBGrid1);
end;

procedure TDBSelectForm.DoFiltroChange(Sender: TObject);
var
  T: TFDMemTable;
begin
  T := FGridFrame.FDMemTable1;
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
  T := FGridFrame.FDMemTable1;

  T.Append;
  RecordToFDMemTable(q, T);
  T.Post;
end;

function TDBSelectForm.Perg(pParams: string): Boolean;
begin
  Filtro.Values := pParams;
end;

end.
