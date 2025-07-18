unit App.UI.Frame.DBGrid.Est.VendaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.DBGrid_u, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Sis.DBI,
  Sis.Entities.Types, Sis.Types;

type
  TRetagVendaItemDBGridFrame = class(TDBGridFrame)
  private
    { Private declarations }
    FRetagVendaItemDBI: IDBI;
    function GetNomeArqTabView: string;
    procedure Preparar;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pRetagVendaItemDBI: IDBI); reintroduce;
    procedure Carregar(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pEstMovId: Int64);
  end;

var
  RetagVendaItemDBGridFrame: TRetagVendaItemDBGridFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.DB.DataSet.Utils;

{ TRetagVendaItemDBGridFrame }

procedure TRetagVendaItemDBGridFrame.Carregar(pLojaId: TLojaId;
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

  FRetagVendaItemDBI.ForEach(Values, LeRegEInsere);
end;

constructor TRetagVendaItemDBGridFrame.Create(AOwner: TComponent;
  pRetagVendaItemDBI: IDBI);
begin
  inherited Create(AOwner);
  DBGrid1.Align := alClient;
  FRetagVendaItemDBI := pRetagVendaItemDBI;
  Preparar;
end;

function TRetagVendaItemDBGridFrame.GetNomeArqTabView: string;
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
    'App\Retag\Est\Ven\tabview.app.retag.est.retagvendaitem.csv';

  Result := sNomeArq;
end;

procedure TRetagVendaItemDBGridFrame.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
begin
  if pRecNo = -1 then
    exit;

  FDMemTableAppendDataSet(q, FDMemTable1, True);
end;

procedure TRetagVendaItemDBGridFrame.Preparar;
var
  sNomeArq: string;
begin
  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDMemTable1, DBGrid1);
  DBGrid1.Align := alClient;

//  FieldORDEM := FDMemTable1.FieldByName('ORDEM');
end;

end.
