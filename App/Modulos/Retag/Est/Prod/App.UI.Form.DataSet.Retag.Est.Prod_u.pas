unit App.UI.Form.DataSet.Retag.Est.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppObj,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.Filtro.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl, App.Ent.Ed,
  App.Ent.Ed.Id.Descr, App.Retag.Est.Prod.Ent, Sis.UI.FormCreator,
  App.Est.Prod.Barras.DBI, {Sis.DB.UltimoId,}
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario,
  App.UI.TabSheet.DataSet.Types_u;

type
  TRetagEstProdDataSetForm = class(TTabSheetDataSetBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }

    FUltimoId: integer;
    FCodsBarrasAcumulando: string;
    FFiltroStringFrame: TFiltroStringFrame;

    // FProdUltimoId: IUltimoId;
    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;

    function PergEd(pDataSetStateAbrev: string): boolean;
    procedure CrieFiltroFrame;

  protected
    { Protected declarations }
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoLer; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure LeRegEInsere(q: TDataSet; pRecNo: integer); override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
      pIdPos: integer; pAppObj: IAppObj); override;
  end;

var
  RetagEstProdDataSetForm: TRetagEstProdDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Est.Prod.Ent_u, App.Est.Factory_u,
  App.Retag.Est.Prod.Ed.DBI, Sis.Types.Bool_u, Sis.Sis.Constants;

{ TRetagEstProdDataSetForm }

constructor TRetagEstProdDataSetForm.Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
      pIdPos: integer; pAppObj: IAppObj);
begin
  inherited Create(AOwner, pFormClassNamesSL, pUsuarioLog, pDBMS,
    pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI, pModoDataSetForm,
    pIdPos, pAppObj);
  FFiltroStringFrame := nil;
  // FProdUltimoId := ProdDataSetUltimoIdCreate(FDMemTable);

end;

procedure TRetagEstProdDataSetForm.CrieFiltroFrame;
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

procedure TRetagEstProdDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := PergEd('Alt');

  if not Resultado then
    exit;

  FDMemTable.Edit;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TRetagEstProdDataSetForm.DoAtualizar(Sender: TObject);
var
  oProdDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  oConn := DBConnectionCreate('Retag.Dataset.Prod.Atu.Conn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  oProdDBI := RetagEstProdDBICreate(oConn, ProdEnt);

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  // FProdUltimoId.Zerar;
  FUltimoId := -1;
  FCodsBarrasAcumulando := '';

  try
//    oProdDBI.ForEach(0, LeRegEInsere);
    EntDBI.ForEach(FFiltroStringFrame.Values, LeRegEInsere);



  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstProdDataSetForm.DoInserir: boolean;
begin
  inherited;
  Result := PergEd('Ins');

  if not Result then
    exit;

  FDMemTable.Insert;
  FDMemTable.Fields[0].AsInteger := ProdEnt.Id;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TRetagEstProdDataSetForm.DoLer;
var
  oDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  inherited;
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  oConn := DBConnectionCreate('Retag.DataSet.Prod.Ler.Conn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  oDBI := RetagEstProdDBICreate(oConn, ProdEnt);
  oDBI.Ler;
end;

function TRetagEstProdDataSetForm.PergEd(pDataSetStateAbrev: string): boolean;
var
  oProdDBI: IEntDBI;

  oProdFabrDBI: IEntDBI;
  oProdTipoDBI: IEntDBI;
  oProdUnidDBI: IEntDBI;
  oProdICMSDBI: IEntDBI;
  oBarrasDBI: IBarrasDBI;
  // oProdBarrasDBI: IBarrasDBI;

  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  sBusca: string;
  oFabrDataSetFormCreator: IFormCreator;
  oProdTipoDataSetFormCreator: IFormCreator;
  oProdUnidDataSetFormCreator: IFormCreator;
  oProdICMSDataSetFormCreator: IFormCreator;

  oAppObj: IAppObj;
  oRetagEstProdEdDBI: IRetagEstProdEdDBI;
begin
  inherited;
  oAppObj := AppObj;

  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, oAppObj);

  oDBConnection := DBConnectionCreate('Retag.Prod.Ed.' + pDataSetStateAbrev +
    '.Conn', oAppObj.SisConfig, oDBConnectionParams, ProcessLog, Output);

  oProdDBI := RetagEstProdDBICreate(oDBConnection, ProdEnt);
  oProdFabrDBI := RetagEstProdFabrDBICreate(oDBConnection, ProdEnt.ProdFabrEnt);
  oProdTipoDBI := RetagEstProdTipoDBICreate(oDBConnection, ProdEnt.ProdTipoEnt);
  oProdUnidDBI := RetagEstProdUnidDBICreate(oDBConnection, ProdEnt.ProdUnidEnt);
  oProdICMSDBI := RetagEstProdICMSDBICreate(oDBConnection, ProdEnt.ProdICMSEnt);
  oBarrasDBI := AppEstBarrasDBICreate(oDBConnection);

  oFabrDataSetFormCreator := FabrDataSetFormCreatorCreate(nil, UsuarioLog,
    DBMS, Output, ProcessLog, OutputNotify, ProdEnt.ProdFabrEnt, oProdFabrDBI, oAppObj);

  oProdTipoDataSetFormCreator := ProdTipoDataSetFormCreatorCreate(nil, UsuarioLog,
    DBMS, Output, ProcessLog, OutputNotify,
    ProdEnt.ProdTipoEnt, oProdTipoDBI, oAppObj);

  oProdUnidDataSetFormCreator := ProdUnidDataSetFormCreatorCreate(nil, UsuarioLog,
    DBMS, Output, ProcessLog, OutputNotify,
    ProdEnt.ProdUnidEnt, oProdUnidDBI, oAppObj);

  oProdICMSDataSetFormCreator := ProdICMSDataSetFormCreatorCreate(nil, UsuarioLog,
    DBMS, Output, ProcessLog, OutputNotify,
    ProdEnt.ProdICMSEnt, oProdICMSDBI, oAppObj);

  oRetagEstProdEdDBI := RetagEstProdEdDBICreate(oDBConnection);

  Result := ProdPerg(Self, EntEd
    //
    , oProdDBI, oProdFabrDBI, oProdTipoDBI, oProdUnidDBI, oProdICMSDBI //
    , oBarrasDBI //

    //
    , oFabrDataSetFormCreator, oProdTipoDataSetFormCreator,
    oProdUnidDataSetFormCreator, oProdICMSDataSetFormCreator
    //
    , AppObj, oRetagEstProdEdDBI, UsuarioLog);
end;

procedure TRetagEstProdDataSetForm.EntToRecord;
begin
  FDMemTable.Fields[1 { descr } ].AsString := ProdEnt.Descr;
  FDMemTable.Fields[2 { descr_red } ].AsString := ProdEnt.DescrRed;
  FDMemTable.Fields[3 { fabr_id } ].AsInteger := ProdEnt.ProdFabrEnt.Id;
  FDMemTable.Fields[4 { fabr_nome } ].AsString := ProdEnt.ProdFabrEnt.Descr;
  FDMemTable.Fields[5 { tipo_id } ].AsInteger := ProdEnt.ProdTipoEnt.Id;
  FDMemTable.Fields[6 { tipo_descr } ].AsString := ProdEnt.ProdTipoEnt.Descr;
  FDMemTable.Fields[7 { unid_id } ].AsInteger := ProdEnt.ProdUnidEnt.Id;
  FDMemTable.Fields[8 { unid_sigla } ].AsString := ProdEnt.ProdUnidEnt.Descr;
  FDMemTable.Fields[9 { icms_id } ].AsInteger := ProdEnt.ProdUnidEnt.Id;
  FDMemTable.Fields[10 { icms_descr_perc } ].AsString :=
    ProdEnt.ProdICMSEnt.Descr;
  FDMemTable.Fields[11 { codbarras } ].AsString :=
    ProdEnt.ProdBarrasList.GetAsString(', ');
  FDMemTable.Fields[12 { Custo } ].AsCurrency :=
    iif(ProdEnt.CustoNovo > 0, ProdEnt.CustoNovo, ProdEnt.CustoAtual);
  FDMemTable.Fields[13 { Preco } ].AsCurrency :=
    iif(ProdEnt.PrecoNovo > 0, ProdEnt.PrecoNovo, ProdEnt.PrecoAtual);
  FDMemTable.Fields[14 { Ativo } ].AsBoolean := ProdEnt.Ativo;
  FDMemTable.Fields[15 { Localiz } ].AsString := ProdEnt.Localiz;
  FDMemTable.Fields[16 { Capac_emb } ].AsCurrency := ProdEnt.CapacEmb;
  FDMemTable.Fields[17 { Margem } ].AsCurrency := ProdEnt.Margem;

end;

function TRetagEstProdDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews + 'App\Retag\Est\tabview.est.prod.csv';

  Result := sNomeArq;
end;

function TRetagEstProdDataSetForm.GetProdEnt: IProdEnt;
begin
  Result := TProdEnt(EntEd);
end;

procedure TRetagEstProdDataSetForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
const
  PROD_ID_FIELD_INDEX = 0;
  BARRAS_FIELD_INDEX = 11;
var
  I: integer;
  iProdIdAtual: integer;
  sBarrasAtual: string;
begin
  // inherited;
  if pRecNo = -1 then
  begin
    if (FDMemTable.State in [dsEdit, dsInsert]) then
    begin
      FDMemTable.Fields[BARRAS_FIELD_INDEX].AsString := FCodsBarrasAcumulando;
      FDMemTable.Post;
    end;
    exit;
  end;

  iProdIdAtual := q.Fields[PROD_ID_FIELD_INDEX].AsInteger;
  sBarrasAtual := q.Fields[BARRAS_FIELD_INDEX].AsString.Trim;

  if FUltimoId <> iProdIdAtual then
  begin
    if (FDMemTable.State in [dsEdit, dsInsert]) then
    begin
      FDMemTable.Fields[BARRAS_FIELD_INDEX].AsString := FCodsBarrasAcumulando;
      FCodsBarrasAcumulando := '';
      FDMemTable.Post;
    end;
    FUltimoId := iProdIdAtual;

    FCodsBarrasAcumulando := sBarrasAtual;

    FDMemTable.Append;
    for I := 0 to q.FieldCount - 1 do
    begin
      FDMemTable.Fields[I].Value := q.Fields[I].Value;
    end;
  end
  else
  begin
    if sBarrasAtual <> '' then
    begin
      if FCodsBarrasAcumulando <> '' then
        FCodsBarrasAcumulando := FCodsBarrasAcumulando + ', ';
      FCodsBarrasAcumulando := FCodsBarrasAcumulando + sBarrasAtual
    end;
  end;
end;

procedure TRetagEstProdDataSetForm.RecordToEnt;
begin
  inherited;
  ProdEnt.Id := FDMemTable.Fields[0].AsInteger;
  // ProdEnt.Descr := FDMemTable.Fields[1].AsString;
  // ProdEnt.DescrRed := FDMemTable.Fields[2].AsString;
  // ProdEnt.ProdFabrEnt.Id := FDMemTable.Fields[3].AsInteger;
  // ProdEnt.ProdFabrEnt.Descr := FDMemTable.Fields[4].AsString;
end;

procedure TRetagEstProdDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  // InsAction_DatasetTabSheet.Execute;

end;

procedure TRetagEstProdDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
