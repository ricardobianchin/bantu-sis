unit App.UI.Form.DataSet.Est.Promo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls,
  App.UI.Form.Bas.TabSheet.DataSet.Master_u,
  App.UI.Form.Bas.TabSheet.DataSet_u,
  Sis.DB.DBTypes, Sis.Usuario, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.Ent.Ed, App.Ent.DBI, Sis.Types, App.UI.TabSheet.DataSet.Types_u,
  App.AppObj, App.Est.EstMovDBI, Sis.Types.Utils_u, Sis.Entities.Types,
  Sis.UI.Frame.Bas.DBGrid_u, App.Est.Promo.Ent, App.Est.Promo.DBI, Sis.DBI,
  App.UI.Frame.DBGrid.Est.EstPromoItem_u, App.Est.EstPromoItem.DBI_u;

type
  TAppPromoDataSetForm = class(TTabSheetDataSetMasterBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);
    procedure InsAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FEstPromoEnt: IEstPromoEnt;
    FEstPromoDBI: IEstPromoDBI;
    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;
    FEstPromoItemDBI: IDBI;
    FEstPromoItemDBGridFrame: TEstPromoItemDBGridFrame;
    FDMemTableATIVO: TField;

    procedure EstLeRegEInsere(q: TDataSet; pRecNo: integer);
  protected
    function PergEd: boolean; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;

    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure DetailCarregar; override;

    procedure DoAlterar; override;
    procedure DoAtualizar(Sender: TObject); override;
    function AtuPode: boolean; override;
    function DoInserir: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  AppPromoDataSetForm: TAppPromoDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.TToolBar, Sis.UI.Controls.TDBGrid, App.DB.Utils,
  Sis.Sis.Constants, Sis.DB.Factory, App.Retag.Est.Factory, App.UI.Form.Perg_u,
  Sis.UI.IO.Files, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.DB.DataSet.Utils, Sis.UI.Controls.Utils, App.Est.PromoItem;

{ TAppPromoDataSetForm }

procedure TAppPromoDataSetForm.AltAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  Result: boolean;
begin
  Result := not FDMemTable.IsEmpty;
  if not Result then
  begin
    ShowMessage('Não há registro de nota a alterar');
    exit;
  end;

  inherited;
end;

procedure TAppPromoDataSetForm.AtuAction_DatasetTabSheetExecute(
  Sender: TObject);
begin
  inherited;
   //
end;

function TAppPromoDataSetForm.AtuPode: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

end;

constructor TAppPromoDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  inherited;
  FEstPromoEnt := EntEdCastToEstPromoEnt(pEntEd);
  FEstPromoDBI := EntDBICastToEstPromoDBI(pEntDBI);

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppEstPromoDataSetForm.conn',
    AppObj.SisConfig, FDBConnectionParams, ProcessLog, Output);

  FEstPromoItemDBI := TEstPromoItemDBI.Create(FDBConnection);
  FEstPromoItemDBGridFrame := TEstPromoItemDBGridFrame.Create(DetailPanel,
    FEstPromoItemDBI);
  FEstPromoItemDBGridFrame.Align := alClient;

  FDMemTableATIVO := FDMemTable.FindField('ATIVO');
end;

procedure TAppPromoDataSetForm.DetailCarregar;
var
  i: integer;
  iLojaId: TLojaId;
  iPromoId: Int64;
begin
  inherited;

  iLojaId := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  iPromoId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;

  FEstPromoItemDBGridFrame.Carregar(iLojaId, iPromoId);
end;

procedure TAppPromoDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := PergEd;
  if not Resultado then
    exit;
  {
  FDMemTable.Edit;
  FDMemTableEST_SAIDA_MOTIVO_ID.AsInteger := FEstSaidaEnt.SaidaMotivoId;
  FDMemTableEST_SAIDA_MOTIVO_DESCR.AsString := FEstSaidaEnt.SaidaMotivoDescr;
  FDMemTable.Post;
  }
end;

procedure TAppPromoDataSetForm.DoAtualizar(Sender: TObject);
begin
  inherited;
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(0, EstLeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
    DetailCarregar;
  end;

end;

function TAppPromoDataSetForm.DoInserir: boolean;
var
  ValAnterior: Boolean;
begin
  ValAnterior :=  FEstPromoEnt.EditandoItem;
//  FEstMovEnt.EditandoItem := False;

  Result := PergEd;

  if not Result then
    exit;

//  if not FEstMovEnt.EditandoItem then
  if not ValAnterior then
  begin
    FDMemTable.Append;
    EntToRecord;
    FDMemTable.Post;
  end;

  DetailCarregar;
end;

procedure TAppPromoDataSetForm.EntToRecord;
var
  i: integer;
  iLojaId: TLojaId;
  iId: TId;
  sCod: string;
begin
  inherited;

  iLojaId := FEstPromoEnt.Loja.Id;
  iId := FEstPromoEnt.PromoId;

  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := iLojaId;
  FDMemTable.Fields[1 { PROMO_ID } ].AsInteger := iId;
  FDMemTable.Fields[2 { COD } ].AsString := FEstPromoEnt.GetCod;
  FDMemTable.Fields[3 { NOME } ].AsString := FEstPromoEnt.Nome;
  FDMemTable.Fields[4 { ATIVO } ].AsBoolean := FEstPromoEnt.Ativo;
  FDMemTable.Fields[5 { INICIA_EM } ].AsDateTime := FEstPromoEnt.IniciaEm;
  FDMemTable.Fields[6 { TERMINA_EM } ].AsDateTime := FEstPromoEnt.TerminaEm;
end;

procedure TAppPromoDataSetForm.EstLeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
  iLojaId: TLojaId;
  iId: TId;
  sCod: string;
begin
  if pRecNo = -1 then
    exit;

  iLojaId := q.Fields[0 { LOJA_ID } ].AsInteger;
  iId := q.Fields[3 { PROMO_ID } ].AsInteger;


  FDMemTable.Append;
  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := ILojaId;
  FDMemTable.Fields[1 { PROMO_ID } ].AsInteger := iId;

  sCod := 'PROMO-' + CodsToCodAsString(iLojaId, 0, iId, False);

  FDMemTable.Fields[2 { COD } ].AsString := sCod;
  FDMemTable.Fields[3 { NOME } ].AsString := q.Fields[3].AsString;
  FDMemTable.Fields[4 { ATIVO } ].AsBoolean := q.Fields[4].AsBoolean;
  FDMemTable.Fields[5 { INICIA_EM } ].AsDateTime := q.Fields[5].AsDateTime;
  FDMemTable.Fields[6 { TERMINA_EM } ].AsDateTime := q.Fields[6].AsDateTime;

  FDMemTable.Post;
end;

function TAppPromoDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Promo\tabview.app.retag.est.promo.csv';
    
  Result := sNomeArq;
end;

procedure TAppPromoDataSetForm.InsAction_DatasetTabSheetExecute(
  Sender: TObject);
begin
  inherited;
//
end;

function TAppPromoDataSetForm.PergEd: boolean;
begin
  Result := EstPromoPerg(nil, AppObj, FEstPromoEnt, FEstPromoDBI,
    FDBConnection, UsuarioLog, DBMS);
end;

{
CRIAR RecordToEnt; BASEADO NO MESMO METODO EM C:\Pr\app\bantu\bantu-sis\Src\App\Modulos\Retag\Est\Sai\App.UI.Form.DataSet.Est.EstSaida_u.pas
}
procedure TAppPromoDataSetForm.RecordToEnt;
begin
  inherited;
  FEstPromoEnt.Loja.Id := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  FEstPromoEnt.PromoId := FDMemTable.Fields[1 { PROMO_ID } ].AsInteger;
  FEstPromoEnt.Nome := FDMemTable.Fields[3 { NOME } ].AsString;
  FEstPromoEnt.Ativo := FDMemTable.Fields[4 { ATIVO } ].AsBoolean;
  FEstPromoEnt.IniciaEm := FDMemTable.Fields[5 { INICIA_EM } ].AsDateTime;
  FEstPromoEnt.TerminaEm := FDMemTable.Fields[6 { TERMINA_EM } ].AsDateTime;
end;

procedure TAppPromoDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  InsAction_DatasetTabSheet.Execute;
end;

procedure TAppPromoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
