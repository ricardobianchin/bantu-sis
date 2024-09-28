unit App.UI.Frame.DBGrid.Config.Ambi.Terminal_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.DBGrid_u, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Sis.DB.DataSet.Utils;

type
  TTerminaisDBGridFrame = class(TDBGridFrame)
  private
    { Private declarations }
    function GetNomeArqTabView: string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Preparar;
  end;

var
  TerminaisDBGridFrame: TTerminaisDBGridFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files;

{ TDBGridFrame1 }

constructor TTerminaisDBGridFrame.Create(AOwner: TComponent);
var
  sNomeArq: string;
begin
  inherited;
//  sNomeArq := GetNomeArqTabView;
//  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDMemTable1, DBGrid1);
end;

function TTerminaisDBGridFrame.GetNomeArqTabView: string;
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
    'App\Config\Ambiente\tabview.config.ambi.terminais.csv';

  Result := sNomeArq;
end;

procedure TTerminaisDBGridFrame.Preparar;
begin
  DBGrid1.Align := alClient;
end;

end.
