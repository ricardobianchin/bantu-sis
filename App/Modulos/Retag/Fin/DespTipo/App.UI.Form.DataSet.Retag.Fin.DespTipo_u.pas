unit App.UI.Form.DataSet.Retag.Fin.DespTipo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppObj,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.Filtro.BuscaString_u, Sis.Usuario,
  Sis.UI.IO.Output, App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  Sis.UI.IO.Output.ProcessLog, App.Ent.Ed.Id.Descr, Sis.UI.ImgDM,
  App.Ent.Ed, App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed.Id.Descr,
  App.Retag.Fin.DespTipo.Ent, App.Retag.Fin.Factory;

type
  TRetagEstDespTipoDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    FFiltroStringFrame: TFiltroStringFrame;
    procedure CrieFiltroFrame;
    function GetDespTipoEnt: IDespTipoEnt;
    property DespTipoEnt: IDespTipoEnt read GetDespTipoEnt;
  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  RetagEstDespTipoDataSetForm: TRetagEstDespTipoDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Fin.DespTipo.Ent_u;

{ TRetagEstDespTipoDataSetForm }

constructor TRetagEstDespTipoDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  inherited;
  FFiltroStringFrame := nil;
end;

procedure TRetagEstDespTipoDataSetForm.CrieFiltroFrame;
var
  iIndexUltimoBotao: integer;
  l, w: integer;
  oToolB: TToolBar;
begin
  if Assigned(FFiltroStringFrame) then
    exit;

  // FFiltroStringFrame
  oToolB := TitToolBar1_BasTabSheet;
  FFiltroStringFrame := TFiltroStringFrame.Create(oToolB, DoAtualizar);
  FFiltroStringFrame.Parent := oToolB;

  iIndexUltimoBotao := oToolB.ButtonCount - 1;

  if iIndexUltimoBotao > -1 then
  begin
    l := oToolB.ControlCount;
    l := oToolB.Buttons[iIndexUltimoBotao].Left;
    w := oToolB.Buttons[iIndexUltimoBotao].Width;
    FFiltroStringFrame.Left := l + w;
  end
  else
    FFiltroStringFrame.Left := 0;
end;

procedure TRetagEstDespTipoDataSetForm.DoAlterar;
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(FFiltroStringFrame.Values, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

procedure TRetagEstDespTipoDataSetForm.DoAtualizar(Sender: TObject);
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(FFiltroStringFrame.Values, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstDespTipoDataSetForm.DoInserir: boolean;
begin
  inherited;
  Result := DespTipoPerg(Self, AppObj, EntEd, EntDBI { oFabrDBI } );

  if not Result then
    exit;

  FDMemTable.InsertRecord([DespTipoEnt.Id, DespTipoEnt.Descr]);
end;

function TRetagEstDespTipoDataSetForm.GetDespTipoEnt: IDespTipoEnt;
begin
  Result := EntEdCastToDespTipoEnt(EntEd);
end;

function TRetagEstDespTipoDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Fin\tabview.fin.desptipo.csv';

  Result := sNomeArq;
end;

procedure TRetagEstDespTipoDataSetForm.RecordToEnt;
begin
  inherited;
  DespTipoEnt.Id := FDMemTable.Fields[0].AsInteger;
  DespTipoEnt.Descr := FDMemTable.Fields[1].AsString;
end;

procedure TRetagEstDespTipoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
