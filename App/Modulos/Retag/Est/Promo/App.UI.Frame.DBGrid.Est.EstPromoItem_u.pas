unit App.UI.Frame.DBGrid.Est.EstPromoItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.DBGrid_u, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Sis.DBI, Sis.Entities.Types, Sis.Types,
  App.Est.EstPromoItem.DBI_u;

type
  TEstPromoItemDBGridFrame = class(TDBGridFrame)
  private
    { Private declarations }
    FEstPromoItemDBI: IDBI;
    function GetNomeArqTabView: string;
    procedure Preparar;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pEstPromoItemDBI: IDBI); reintroduce;
    procedure Carregar(pLojaId: TLojaId; pPromoId: integer);
  end;

var
  EstPromoItemDBGridFrame: TEstPromoItemDBGridFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.DB.DataSet.Utils;

{ TEstPromoItemDBGridFrame }

procedure TEstPromoItemDBGridFrame.Carregar(pLojaId: TLojaId; pPromoId: integer);
var
  Values: Variant;
begin
  FDMemTable1.EmptyDataSet;

  if pPromoId = 0 then
    exit;

  Values := VarArrayCreate([0, 1], varVariant);
  Values[0] := pLojaId;
  Values[1] := pPromoId;

  FEstPromoItemDBI.ForEach(Values, LeRegEInsere);

end;

constructor TEstPromoItemDBGridFrame.Create(AOwner: TComponent;
  pEstPromoItemDBI: IDBI);
begin
  inherited Create(AOwner);
  DBGrid1.Align := alClient;
  FEstPromoItemDBI := pEstPromoItemDBI;
  Preparar;
end;

function TEstPromoItemDBGridFrame.GetNomeArqTabView: string;
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
    'App\Retag\Est\Promo\tabview.app.retag.est.promo.item.csv';
  Result := sNomeArq;
end;

procedure TEstPromoItemDBGridFrame.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
begin
  if pRecNo = -1 then
    exit;

  FDMemTableAppendDataSet(q, FDMemTable1, True);
end;

procedure TEstPromoItemDBGridFrame.Preparar;
var
  sNomeArq: string;
begin
  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDMemTable1, DBGrid1);
  DBGrid1.Align := alClient;
end;

end.
