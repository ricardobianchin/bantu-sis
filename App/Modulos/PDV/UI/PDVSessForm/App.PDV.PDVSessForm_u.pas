unit App.PDV.PDVSessForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, App.Est.Venda.CaixaSessao.DBI,
  Data.DB, Vcl.Grids, Vcl.DBGrids, App.AppObj, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, System.Actions, Vcl.ActnList, Vcl.ToolWin,
  Vcl.StdCtrls, Sis.UI.IO.Output, App.Est.Venda.CaixaSessaoRecord_u,
  Sis.UI.Form.Bas.Diag_u;

type
  TPDVSessForm = class(TDiagBasForm)
    BasePanel: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    TopoPanel: TPanel;
    MeioPanel: TPanel;
    DBGrid1Splitter: TSplitter;
    DBGrid1: TDBGrid;
    SubPanel: TPanel;
    Splitter2: TSplitter;
    ItemPanel: TPanel;
    ItemDBGrid: TDBGrid;
    PagPanel: TPanel;
    PagDBGrid: TDBGrid;
    ToolBarActionList: TActionList;
    RelatAction: TAction;
    SessFDMemTable: TFDMemTable;
    ItemFDMemTable: TFDMemTable;
    PagFDMemTable: TFDMemTable;
    ItemDataSource: TDataSource;
    PagDataSource: TDataSource;
    SessDataSource: TDataSource;
    procedure RelatActionExecute(Sender: TObject);
  private
    { Private declarations }
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FCaixaSessaoRec: TCaixaSessaoRec;
    FAppObj: IAppObj;
  protected
    procedure AjusteControles; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pCaixaSessaoDBI: ICaixaSessaoDBI;
      pAppObj: IAppObj); reintroduce;
  end;

procedure Exibir(AOwner: TComponent; pCaixaSessaoDBI: ICaixaSessaoDBI;
      pAppObj: IAppObj);

      var
  PDVSessForm: TPDVSessForm;

implementation

{$R *.dfm}

uses System.Math, Sis.DB.DataSet.Utils, Sis.UI.IO.Factory,
  App.PDV.ImpressaoTextoCxSessRelat_u;

procedure Exibir(AOwner: TComponent; pCaixaSessaoDBI: ICaixaSessaoDBI;
      pAppObj: IAppObj);
begin
  PDVSessForm := TPDVSessForm.Create(AOwner, pCaixaSessaoDBI, pAppObj);
  try
    PDVSessForm.ShowModal;
  finally
    FreeAndNil(PDVSessForm);
  end;
end;

{ TPDVSessForm }

procedure TPDVSessForm.AjusteControles;
begin
  inherited;
  FCaixaSessaoDBI.CaixaSessaoUltimoGet(FCaixaSessaoRec);
  FCaixaSessaoDBI.PDVCarregarDataSet(SessFDMemTable, FCaixaSessaoRec);
end;

constructor TPDVSessForm.Create(AOwner: TComponent;
  pCaixaSessaoDBI: ICaixaSessaoDBI; pAppObj: IAppObj);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FCaixaSessaoDBI := pCaixaSessaoDBI;
  FAppObj := pAppObj;

  Height := Min(600, Screen.WorkAreaRect.Height - 10);
  Width := 800;
  DBGrid1.Height := (MeioPanel.Height - DBGrid1Splitter.Height) div 2;

  ItemDBGrid.Width := (MeioPanel.Width * 2) div 3;

  sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
    'App\PDV\tabview.pdv.sessform.csv';

  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, SessFDMemTable, DBGrid1);
end;

procedure TPDVSessForm.RelatActionExecute(Sender: TObject);
begin
  inherited;
  if SessFDMemTable.IsEmpty then
  begin
    ErroOutput.Exibir('Não há registro visivel a processar');
    exit;
  end;
  FCaixaSessaoDBI
end;

end.
