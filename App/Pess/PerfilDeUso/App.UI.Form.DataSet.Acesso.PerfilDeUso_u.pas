unit App.UI.Form.DataSet.Acesso.PerfilDeUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Acesso.PerfilDeUso.Ent.Factory_u,
  App.Acesso.PerfilDeUso.Ent, App.AppInfo, Sis.Config.SisConfig, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI, App.UI.TabSheet.DataSet.Types_u, FireDAC.Comp.Client,
  Sis.UI.Controls.TreeView.Frame_u, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Sis.UI.Controls.TreeView.Frame.Preenchedor;

type
  TPerfilDeUsoDataSetForm = class(TTabSheetDataSetBasForm)
    FundoPanel_PerfilDeUsoDataSetForm: TPanel;
    DBGridSplitter_PerfilDeUsoDataSetForm: TSplitter;
  private
    { Private declarations }
    FPerfilDeUsoEnt: IPerfilDeUsoEnt;
    FTreeViewFrame: TTreeViewFrame;
    FTreeViewPreenchedor: ITreeViewPreenchedor;

    procedure PreenchaTreeView;
  protected
    function GetNomeArqTabView: string; override;

    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    procedure ToolBar1CrieBotoes; override;

    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure PrepareControls; override;

    procedure FDMemTable1AfterOpen(DataSet: TDataSet); override;
    procedure FDMemTable1AfterScroll(DataSet: TDataSet); override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer); override;
  end;

var
  PerfilDeUsoDataSetForm: TPerfilDeUsoDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, Sis.UI.Controls.TDBGrid,
  App.Acesso.PerfilDeUso.UI.Factory_u, Sis.UI.ImgDM;

{ TPerfilDeUsoDataSetForm }

constructor TPerfilDeUsoDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  inherited;
  FPerfilDeUsoEnt :=EntEdCastToPerfilDeUsoEnt(pEntEd);
end;

procedure TPerfilDeUsoDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := PerfilDeUsoPerg(Self, AppInfo, EntEd, EntDBI);

  if not Resultado then
    exit;

  FDMemTable.Append;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TPerfilDeUsoDataSetForm.DoAtualizar(Sender: TObject);
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.PreencherDataSet(0, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TPerfilDeUsoDataSetForm.DoInserir: boolean;
//var
//  oDBConnectionParams: TDBConnectionParams;
//  oDBConnection: IDBConnection;
begin
  inherited;
//  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
//    AppInfo, SisConfig);

//  oDBConnection := DBConnectionCreate('Retag.PerfilDeUso.Ed.Ins.Conn', SisConfig, DBMS,
//    oDBConnectionParams, ProcessLog, Output);

  Result := PerfilDeUsoPerg(Self, AppInfo, EntEd, EntDBI);

  if not Result then
    exit;

  FDMemTable.Append;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TPerfilDeUsoDataSetForm.EntToRecord;
var
  Tab: TFDMemTable;
begin
  inherited;
  Tab := FDMemTable;

  Tab.Fields[0{perfil_de_uso_id}].AsInteger := FPerfilDeUsoEnt.Id;
  Tab.Fields[1{nome}].AsString := FPerfilDeUsoEnt.Descr;
  Tab.Fields[2{de_sistema}].AsBoolean := FPerfilDeUsoEnt.DeSistema;
end;

procedure TPerfilDeUsoDataSetForm.FDMemTable1AfterOpen(DataSet: TDataSet);
begin
  PreenchaTreeView;
end;

procedure TPerfilDeUsoDataSetForm.FDMemTable1AfterScroll(DataSet: TDataSet);
begin
  PreenchaTreeView;
end;

function TPerfilDeUsoDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews +
    'App\Retag\Acesso\tabview.retag.acesso.perfil_de_uso.csv';
  Result := sNomeArq;
end;

procedure TPerfilDeUsoDataSetForm.PreenchaTreeView;
var
  iFiltroId: integer;
begin
  iFiltroId := FDMemTable.Fields[0{perfil_de_uso_id}].AsInteger;
  FTreeViewPreenchedor.PreenchaTreeView(iFiltroId, '');
end;

procedure TPerfilDeUsoDataSetForm.PrepareControls;
begin
  inherited;
  FundoPanel_PerfilDeUsoDataSetForm.Visible := True;

  FundoPanel_PerfilDeUsoDataSetForm.Align := alClient;
  FundoPanel_PerfilDeUsoDataSetForm.Caption := '';

  DBGrid1.Parent := FundoPanel_PerfilDeUsoDataSetForm;
  DBGrid1.Align := alLeft;
  DBGrid1.Width :=  (Width * 5) div 10;

  DBGridSplitter_PerfilDeUsoDataSetForm.Left := DBGrid1.Width + 4;

  FTreeViewFrame := TTreeViewFrame.Create(FundoPanel_PerfilDeUsoDataSetForm);
  FTreeViewFrame.Align := alClient;
  FTreeViewPreenchedor := PerfilTreeViewPreenchedorCreate(FTreeViewFrame,
    AppInfo, SisConfig, DBMS, SisImgDataModule.ImageList_9_9);

end;

procedure TPerfilDeUsoDataSetForm.RecordToEnt;
var
  Tab: TFDMemTable;
begin
  inherited;
  Tab := FDMemTable;

  FPerfilDeUsoEnt.Id := Tab.Fields[0{perfil_de_uso_id}].AsInteger;
  FPerfilDeUsoEnt.Descr := Trim(Tab.Fields[1{nome}].AsString);
  FPerfilDeUsoEnt.DeSistema := Tab.Fields[2{de_sistema}].AsBoolean;
end;

procedure TPerfilDeUsoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
