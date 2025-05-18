unit App.UI.Fram.DBGrid.Est.EstSaidaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.DBGrid_u, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, App.Retag.Est.EstSaidaItem.DBI_u, Sis.DBI, Sis.Entities.Types, Sis.Types;

type
  TEstSaidaItemDBGridFrame = class(TDBGridFrame)
  private
    { Private declarations }
    FEstSaidaItemDBI: IDBI;
    function GetNomeArqTabView: string;
    procedure Preparar;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pEstSaidaItemDBI: IDBI); reintroduce;
    procedure Carregar(pLojaId: TLojaId; pTerminalId: TTerminalId; pEstMovId: Int64);
  end;

var
  EstSaidaItemDBGridFrame: TEstSaidaItemDBGridFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.DB.DataSet.Utils;

{ TEstSaidaItemDBGridFrame }

procedure TEstSaidaItemDBGridFrame.Carregar(pLojaId: TLojaId;
  pTerminalId: TTerminalId; pEstMovId: Int64);
var
  Values: Variant;
begin
  FDMemTable1.EmptyDataSet;
  Values := VarArrayCreate([0, 2], varVariant);
  Values[0] := pLojaId;
  Values[1] := pTerminalId;
  Values[2] := pEstMovId;

  FEstSaidaItemDBI.ForEach(Values, LeRegEInsere);
end;

constructor TEstSaidaItemDBGridFrame.Create(AOwner: TComponent; pEstSaidaItemDBI: IDBI);
begin
  inherited Create(AOwner);
  DBGrid1.Align := alClient;
  FEstSaidaItemDBI := pEstSaidaItemDBI;
  Preparar;
end;

function TEstSaidaItemDBGridFrame.GetNomeArqTabView: string;
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
    'App\Retag\Est\Sai\tabview.app.retag.est.estsaiitem.csv';

  Result := sNomeArq;
end;

procedure TEstSaidaItemDBGridFrame.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
begin
  if pRecNo = -1 then
    exit;

  FDMemTableAppendDataSet(q, FDMemTable1, True);

//  FDMemTable1.Append;
//
//  for i := 0 to q.FieldCount - 1 do
//  begin
//    Sis.DB.DataSet.Utils.FDMemTableAppendDataSet()
//
//    FDMemTable.Fields[i].Value := q.Fields[i].Value;
//  end;
//  FDMemTable1.Post;
end;

procedure TEstSaidaItemDBGridFrame.Preparar;
var
  sNomeArq: string;
begin
  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDMemTable1, DBGrid1);
  DBGrid1.Align := alClient;
end;

end.
