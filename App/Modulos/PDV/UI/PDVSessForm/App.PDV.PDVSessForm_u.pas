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
  Vcl.StdCtrls, Sis.UI.IO.Output, Sis.UI.Form.Bas.Diag_u, Sis.UI.Impressao,
  Sis.Terminal, Sis.Usuario, App.Est.Venda.Caixa.CaixaSessao;

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
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FCaixaSessao: ICaixaSessao;
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FImpressao: IImpressao;
  protected
    procedure AjusteControles; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pImpressoraNome: string;
      pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
      pCaixaSessaoDBI: ICaixaSessaoDBI); reintroduce;
  end;

procedure Exibir(AOwner: TComponent; pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCaixaSessaoDBI: ICaixaSessaoDBI);

var
  PDVSessForm: TPDVSessForm;

implementation

{$R *.dfm}

uses System.Math, Sis.DB.DataSet.Utils, Sis.UI.IO.Factory, App.PDV.Factory_u,
  App.PDV.ImpressaoTextoCxSessRelat_u, App.Est.Venda.CaixaSessao.Factory_u;

procedure Exibir(AOwner: TComponent; pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCaixaSessaoDBI: ICaixaSessaoDBI);
begin
  PDVSessForm := TPDVSessForm.Create(AOwner, pImpressoraNome, pUsuario, pAppObj,
    pTerminal, pCaixaSessaoDBI);
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
  FCaixaSessaoDBI.CaixaSessaoUltimoGet(FCaixaSessao);
  FCaixaSessaoDBI.PDVCarregarDataSet(SessFDMemTable, FCaixaSessao);
end;

constructor TPDVSessForm.Create(AOwner: TComponent; pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCaixaSessaoDBI: ICaixaSessaoDBI);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FTerminal := pTerminal;

  FCaixaSessao := CaixaSessaoCreate(pUsuario //
    , FAppObj.SisConfig.LocalMachineId.IdentId //
    , FAppObj.Loja.Id //
    , pTerminal.TerminalId);

  FCaixaSessaoDBI := pCaixaSessaoDBI;

  FImpressao := ImpressaoTextoCxSessRelatCreate(pImpressoraNome, pUsuario,
    pAppObj, pTerminal, pCaixaSessaoDBI, FCaixaSessao);

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
  FImpressao.Imprima;
end;

procedure TPDVSessForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  RelatAction.Execute;
end;

end.
