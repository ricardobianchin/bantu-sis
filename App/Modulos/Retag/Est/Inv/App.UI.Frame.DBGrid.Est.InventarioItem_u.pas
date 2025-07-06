unit App.UI.Frame.DBGrid.Est.InventarioItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.DBGrid_u, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, App.Retag.Est.InventarioItem.DBI_u, Sis.DBI, Sis.Entities.Types,
  Sis.Types;

type
  TInventarioItemDBGridFrame = class(TDBGridFrame)
  private
    { Private declarations }
    FInventarioItemDBI: IDBI;
    function GetNomeArqTabView: string;
    procedure Preparar;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pInventarioItemDBI: IDBI);
      reintroduce;
    procedure Carregar(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pEstMovId: Int64);
  end;

var
  InventarioItemDBGridFrame: TInventarioItemDBGridFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.DB.DataSet.Utils;

{ TInventarioItemDBGridFrame }

procedure TInventarioItemDBGridFrame.Carregar(pLojaId: TLojaId;
  pTerminalId: TTerminalId; pEstMovId: Int64);
var
  Values: Variant;
begin
  FDMemTable1.EmptyDataSet;

  if pEstMovId = 0 then
    exit;

  Values := VarArrayCreate([0, 2], varVariant);
  Values[0] := pLojaId;
  Values[1] := pTerminalId;
  Values[2] := pEstMovId;

  FInventarioItemDBI.ForEach(Values, LeRegEInsere);
end;

constructor TInventarioItemDBGridFrame.Create(AOwner: TComponent;
  pInventarioItemDBI: IDBI);
begin
  inherited Create(AOwner);
  DBGrid1.Align := alClient;
  FInventarioItemDBI := pInventarioItemDBI;
  Preparar;
end;

function TInventarioItemDBGridFrame.GetNomeArqTabView: string;
var
  sNomeArq: string;
  sExeName: string;
  sPastaBin: string;
  sPasta: string;
  sPastaConsultas: string;
  sPastaConsTabViews: string;
begin
  sExeName := ParamStr(0);
  sPastaBin := GetPastaDoArquivo(sExeName);
  sPasta := PastaAcima(sPastaBin);

  sPastaConsultas := sPasta + 'Cons\';
  sPastaConsTabViews := sPastaConsultas + 'TabViews\';
  ForceDirectories(sPastaConsTabViews);

  sNomeArq := sPastaConsTabViews +
    'App\Retag\Est\Inv\tabview.app.retag.est.invitem.csv';
  Result := sNomeArq;
end;

procedure TInventarioItemDBGridFrame.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
begin
  if pRecNo = -1 then
    exit;

  FDMemTableAppendDataSet(q, FDMemTable1, True);
end;

procedure TInventarioItemDBGridFrame.Preparar;
var
  sNomeArq: string;
begin
  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDMemTable1, DBGrid1);
  DBGrid1.Align := alClient;
end;

end.
