unit App.UI.Form.DataSet.Acesso.PerfilDeUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Acesso.PerfilDeUso.Ent.Factory_u,
  App.Acesso.PerfilDeUso.Ent, App.AppInfo, Sis.Config.SisConfig, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI, App.UI.TabSheet.DataSet.Types_u, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  App.AppObj;

type
  TPerfilDeUsoDataSetForm = class(TTabSheetDataSetBasForm)
    OpcaoSisAction_PerfilDeUsoDataSetForm: TAction;

    procedure OpcaoSisAction_PerfilDeUsoDataSetFormExecute(Sender: TObject);
  private
    { Private declarations }
    FPerfilDeUsoEnt: IPerfilDeUsoEnt;

  protected
    function GetNomeArqTabView: string; override;

    procedure DoAtualizar(Sender: TObject); override;

    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    procedure ToolBar1CrieBotoes; override;

    procedure RecordToEnt; override;
    procedure EntToRecord; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pAppObj: IAppObj); override;
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
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pAppObj: IAppObj);
begin
  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI,
    pModoDataSetForm, pIdPos, pAppObj);
  FPerfilDeUsoEnt := EntEdCastToPerfilDeUsoEnt(pEntEd);
end;

procedure TPerfilDeUsoDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := PerfilDeUsoPerg(Self, AppInfo, EntEd, EntDBI);

  if not Resultado then
    exit;

  FDMemTable.Edit;
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
begin
  inherited;
  Result := PerfilDeUsoPerg(Self, AppInfo, EntEd, EntDBI);

  if not Result then
    exit;

  FDMemTable.Append;
  EntToRecord;
  FDMemTable.Post;
  DBGrid1.Repaint;

  OpcaoSisAction_PerfilDeUsoDataSetForm.Execute;
end;

procedure TPerfilDeUsoDataSetForm.EntToRecord;
var
  Tab: TFDMemTable;
begin
  inherited;
  Tab := FDMemTable;

  Tab.Fields[0 { perfil_de_uso_id } ].AsInteger := FPerfilDeUsoEnt.Id;
  Tab.Fields[1 { nome } ].AsString := FPerfilDeUsoEnt.Descr;
  Tab.Fields[2 { de_sistema } ].AsBoolean := FPerfilDeUsoEnt.DeSistema;
end;

function TPerfilDeUsoDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews +
    'App\Retag\Acesso\tabview.retag.acesso.perfil_de_uso.csv';
  Result := sNomeArq;
end;

procedure TPerfilDeUsoDataSetForm.OpcaoSisAction_PerfilDeUsoDataSetFormExecute
  (Sender: TObject);
var
  iPerfilDeUsoId: integer;
  sPerfilDeUsoNome: string;
begin
  inherited;
  iPerfilDeUsoId := FDMemTable.Fields[0].AsInteger;
  sPerfilDeUsoNome := Trim(FDMemTable.Fields[1].AsString);

  OpcaoSisPerfilUsoPerg(iPerfilDeUsoId, sPerfilDeUsoNome, AppObj, DBMS);
end;

procedure TPerfilDeUsoDataSetForm.RecordToEnt;
var
  Tab: TFDMemTable;
begin
  inherited;
  Tab := FDMemTable;

  FPerfilDeUsoEnt.Id := Tab.Fields[0 { perfil_de_uso_id } ].AsInteger;
  FPerfilDeUsoEnt.Descr := Trim(Tab.Fields[1 { nome } ].AsString);
  FPerfilDeUsoEnt.DeSistema := Tab.Fields[2 { de_sistema } ].AsBoolean;
end;

procedure TPerfilDeUsoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(OpcaoSisAction_PerfilDeUsoDataSetForm,
    TitToolBar1_BasTabSheet);
end;

end.
