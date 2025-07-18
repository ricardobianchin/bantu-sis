unit App.UI.Frame.DBGrid.Est.EntradaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.DBGrid_u, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Sis.DBI, Sis.Entities.Types, Sis.Types;

type
  TEntradaItemDBGridFrame = class(TDBGridFrame)
  private
    { Private declarations }
    FEntradaItemDBI: IDBI;
    function GetNomeArqTabView: string;
    procedure Preparar;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
  public
    { Public declarations }
    FieldORDEM: TField;
    FieldNITEM: TField;
    FieldPROD_ID_DELES: TField;
    FieldPROD_ID: TField;
    FieldDESCR_RED: TField;
    FieldFABR_NOME: TField;
    FieldUNID_SIGLA: TField;
    FieldQTD: TField;
    FieldMARGEM: TField;
    FieldCUSTO: TField;
    FieldPRECO: TField;
    FieldCANCELADO: TField;
    FieldCRIADO_EM: TField;
{
ORDEM
NITEM
PROD_ID_DELES
PROD_ID
DESCR_RED
FABR_NOME
UNID_SIGLA
QTD
MARGEM
CUSTO
PRECO
CANCELADO
}
    constructor Create(AOwner: TComponent; pEntradaItemDBI: IDBI); reintroduce;
    procedure Carregar(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pEstMovId: Int64);
  end;

var
  EntradaItemDBGridFrame: TEntradaItemDBGridFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.DB.DataSet.Utils, App.Retag.Est.EntradaItem.DBI_u;

{ TEntradaItemDBGridFrame }

procedure TEntradaItemDBGridFrame.Carregar(pLojaId: TLojaId;
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

  FEntradaItemDBI.ForEach(Values, LeRegEInsere);
end;

constructor TEntradaItemDBGridFrame.Create(AOwner: TComponent;
  pEntradaItemDBI: IDBI);
begin
  inherited Create(AOwner);
  DBGrid1.Align := alClient;
  FEntradaItemDBI := pEntradaItemDBI;
  Preparar;
end;

function TEntradaItemDBGridFrame.GetNomeArqTabView: string;
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
    'App\Retag\Est\Ent\tabview.app.retag.est.entitem.csv';

  Result := sNomeArq;
end;

procedure TEntradaItemDBGridFrame.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
begin
  if pRecNo = -1 then
    exit;

  FDMemTableAppendDataSet(q, FDMemTable1, True);
end;

procedure TEntradaItemDBGridFrame.Preparar;
var
  sNomeArq: string;
begin
  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDMemTable1, DBGrid1);
  DBGrid1.Align := alClient;

  FieldORDEM := FDMemTable1.FieldByName('ORDEM');
  FieldNITEM := FDMemTable1.FieldByName('NITEM');
  FieldPROD_ID_DELES := FDMemTable1.FieldByName('PROD_ID_DELES');
  FieldPROD_ID := FDMemTable1.FieldByName('PROD_ID');
  FieldDESCR_RED := FDMemTable1.FieldByName('DESCR_RED');
  FieldFABR_NOME := FDMemTable1.FieldByName('FABR_NOME');
  FieldUNID_SIGLA := FDMemTable1.FieldByName('UNID_SIGLA');
  FieldQTD := FDMemTable1.FieldByName('QTD');
  FieldCUSTO := FDMemTable1.FieldByName('CUSTO');
  FieldMARGEM := FDMemTable1.FieldByName('MARGEM');
  FieldPRECO := FDMemTable1.FieldByName('PRECO');
  FieldCANCELADO := FDMemTable1.FieldByName('CANCELADO');
  FieldCRIADO_EM := FDMemTable1.FieldByName('CRIADO_EM');
end;

end.
