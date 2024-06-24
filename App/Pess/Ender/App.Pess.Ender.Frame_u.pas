unit App.Pess.Ender.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Data.DB, App.Pess.Ender.Controls.Frame_u,
  App.Pess.Ender.DBGrid.Frame_u, App.Pess.Ent, Sis.DB.DataSet.Utils,
  App.Pess.DBI, FireDAC.Comp.Client, App.AppInfo, App.Pess.Utils;

type
  TEnderFrame = class(TBasFrame)
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;
    FFDMemTable: TFDMemTable;
    FEnderControlsFrame: TEnderControlsFrame;
    FEnderDBGridFrame: TEnderDBGridFrame;
    FAppInfo: IAppInfo;
    function GetNomeArqTabViewEndereco: string;
    procedure EnderecoFDMemTableAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPessEnt: IPessEnt;
      pPessDBI: IPessDBI; pAppInfo: IAppInfo); reintroduce;
  end;

var
  EnderFrame: TEnderFrame;

implementation

{$R *.dfm}
{ TEnderFrame }

constructor TEnderFrame.Create(AOwner: TComponent; pPessEnt: IPessEnt;
  pPessDBI: IPessDBI; pAppInfo: IAppInfo);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FAppInfo := pAppInfo;
  FPessEnt := pPessEnt;
  FPessDBI := pPessDBI;
  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';
  FFDMemTable.AfterScroll := EnderecoFDMemTableAfterScroll;

  FEnderControlsFrame := TEnderControlsFrame.Create(Self, pPessEnt, FPessDBI,
    FFDMemTable);
  FEnderDBGridFrame := TEnderDBGridFrame.Create(Self, pPessEnt, FPessDBI,
    FFDMemTable);

  sNomeArq := GetNomeArqTabViewEndereco;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable,
    FEnderDBGridFrame.DBGrid1, ENDER_TABVIEW_ORDEM_INDEX);
end;

procedure TEnderFrame.EnderecoFDMemTableAfterScroll(DataSet: TDataSet);
begin

end;

function TEnderFrame.GetNomeArqTabViewEndereco: string;
var
  sNomeArq: string;
begin
  sNomeArq := FAppInfo.PastaConsTabViews +
    'App\Config\Ambiente\tabview.config.ambi.pess.loja.csv';
  Result := sNomeArq;
end;

end.
