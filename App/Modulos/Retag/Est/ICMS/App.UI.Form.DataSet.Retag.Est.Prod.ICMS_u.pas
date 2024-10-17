unit App.UI.Form.DataSet.Retag.Est.Prod.ICMS_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u, Sis.Types, Sis.Types.Utils_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Ent.Ed.Id.Descr, App.Retag.Est.Prod.ICMS.Ent, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TRetagEstProdICMSDataSetForm = class(TTabSheetDataSetBasForm)
    DesativarAction_DatasetTabSheet: TAction;
    AtivarAction_DatasetTabSheet: TAction;
    procedure DesativarAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AtivarAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    function GetProdICMSEnt: IProdICMSEnt;
    property ProdICMSEnt: IProdICMSEnt read GetProdICMSEnt;
    function AtivoSet(pValor: boolean): boolean;

  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
  public
    { Public declarations }
    function GetSelectItem: TSelectItem; override;
  end;

var
  RetagEstProdICMSDataSetForm: TRetagEstProdICMSDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Est.Prod.ICMS.Ent_u,
  App.Retag.Est.Prod.ICMS.DBI_u, Sis.Sis.Constants;

{ TRetagEstProdICMSDataSetForm }

procedure TRetagEstProdICMSDataSetForm.AtivarAction_DatasetTabSheetExecute
  (Sender: TObject);
begin
  AtivoSet(True);
end;

function TRetagEstProdICMSDataSetForm.AtivoSet(pValor: boolean): boolean;
var
  oICMSDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  bStatusAtual: boolean;
  oCampoAtivo: TField;
begin
  inherited;
  if FDMemTable.IsEmpty then
  begin
    OutputNotify.Exibir('Não há registros visíveis para ativar');
    exit;
  end;

  oCampoAtivo := FDMemTable.FieldByName('ATIVO');

  bStatusAtual := oCampoAtivo.AsBoolean;
  Result := pValor <> bStatusAtual;
  if not Result then
    exit;

  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppObj);

  oConn := DBConnectionCreate('Retag.ICMS.AtivoSet.Atu.Conn', SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  oICMSDBI := RetagEstProdICMSDBICreate(oConn, ProdICMSEnt);

  Result := oICMSDBI.AtivoSet(FDMemTable.Fields[0].AsInteger, pValor);

  if not Result then
    exit;

  FDMemTable.Edit;
  oCampoAtivo.AsBoolean := pValor;
  FDMemTable.Post;
end;

procedure TRetagEstProdICMSDataSetForm.DesativarAction_DatasetTabSheetExecute
  (Sender: TObject);
begin
  AtivoSet(False);
end;

procedure TRetagEstProdICMSDataSetForm.DoAlterar;
begin
  inherited;
  // no momento nao está permitindo editar
end;

procedure TRetagEstProdICMSDataSetForm.DoAtualizar(Sender: TObject);
var
  oICMSDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppObj);

  oConn := DBConnectionCreate('Retag.ICMS.Ed.Atu.Conn', SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  oICMSDBI := RetagEstProdICMSDBICreate(oConn, ProdICMSEnt);

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    oICMSDBI.PreencherDataSet(0, LeRegEInsere);
  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstProdICMSDataSetForm.DoInserir: boolean;
var
  oICMSDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  inherited;
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppObj);

  oDBConnection := DBConnectionCreate('Retag.ICMS.Ed.Ins.Conn', SisConfig,
    oDBConnectionParams, ProcessLog, Output);
  ProdICMSEnt.Id := 0;
  ProdICMSEnt.Sigla := '';
  ProdICMSEnt.Descr := '';
  ProdICMSEnt.Perc := ZERO_CURRENCY;
  ProdICMSEnt.Ativo := True;

   oICMSDBI := RetagEstProdICMSDBICreate(oDBConnection, ProdICMSEnt);

   Result := ProdICMSPerg(Self, AppInfo, EntEd, oICMSDBI);

  if not Result then
    exit;

  FDMemTable.InsertRecord([ProdICMSEnt.Id, ProdICMSEnt.Sigla, ProdICMSEnt.Descr,
    ProdICMSEnt.Perc, ProdICMSEnt.Ativo]);
end;

function TRetagEstProdICMSDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'App\Retag\Est\tabview.est.prod.icms.csv';

  Result := sNomeArq;
end;

function TRetagEstProdICMSDataSetForm.GetProdICMSEnt: IProdICMSEnt;
begin
  Result := TProdICMSEnt(EntEd);
end;

function TRetagEstProdICMSDataSetForm.GetSelectItem: TSelectItem;
var
  fPerc: currency;
  Descr: string;
begin
  Result.Id := FDMemTable.Fields[0].AsInteger;

  fPerc := FDMemTable.Fields[3].AsCurrency;
  if fPerc > 0 then
    Result.Descr := FormatFloat('##0.##', fPerc)
  else
    Result.Descr := FDMemTable.Fields[2].AsString;
end;

procedure TRetagEstProdICMSDataSetForm.RecordToEnt;
begin
  inherited;
  ProdICMSEnt.Id := FDMemTable.Fields[0].AsInteger;
  ProdICMSEnt.Sigla := FDMemTable.Fields[1].AsString;
  ProdICMSEnt.Descr := FDMemTable.Fields[2].AsString;
  ProdICMSEnt.Perc := FDMemTable.Fields[3].AsCurrency;
  ProdICMSEnt.Ativo := FDMemTable.Fields[4].AsBoolean;

end;

procedure TRetagEstProdICMSDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(DesativarAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AtivarAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
