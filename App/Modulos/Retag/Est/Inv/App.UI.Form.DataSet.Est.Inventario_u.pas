unit App.UI.Form.DataSet.Est.Inventario_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Est_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo,
  App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.Inventario.Ent, App.Retag.Est.Inventario.DBI,
  App.UI.Frame.DBGrid.Est.InventarioItem_u, App.Retag.Est.InventarioItem.DBI_u,
  Sis.DBI, App.UI.Form.Perg_u;

type
  TAppInventarioDataSetForm = class(TAppEstDataSetForm)
  private
    { Private declarations }
    FInventarioEnt: IInventarioEnt;
    FInventarioDBI: IInventarioDBI;
    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;
    FInventarioItemDBI: IDBI;
    FInventarioItemDBGridFrame: TInventarioItemDBGridFrame;
  protected
    procedure EstLeRegEInsere(q: TDataSet; pRecNo: integer); override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;

    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure CrieFiltroFrame; override;
    function PergEd: boolean; override;
    procedure DetailCarregar; override;

    function AtuPode: Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  AppInventarioDataSetForm: TAppInventarioDataSetForm;

implementation

{$R *.dfm}

uses App.UI.Frame.Bas.EstFiltro_u, Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  App.Retag.Est.Factory, Sis.DB.Factory, App.DB.Utils, App.UI.Form.Retag.Excl_u, Sis.DB.DataSet.Utils, Sis.Entities.Types, Sis.Types,
  Sis.UI.Controls.Utils, Sis.Sis.Constants, Sis.Types.Utils_u,
  App.Retag.Est.InventarioItem;

function TAppInventarioDataSetForm.AtuPode: Boolean;
var
  // valores dth so sao lidos aqui pra poder testar
  // serao depois relidos por ForEach
  DtHIni: TDateTime;
  DtHFin: TDateTime;
  sMens: string;
begin
  Result := inherited;
  if not Result then
    exit;

  EstFiltroFrame.DtHFaixaFrame.DtIniFrame.PreencheDtH(DtHIni, sMens);
  Result := sMens = '';
  if not Result then// a mens de erro ja foi exibida dentro do dthframe
    exit;

  EstFiltroFrame.DtHFaixaFrame.DtFinFrame.PreencheDtH(DtHFin, sMens);
  Result := sMens = '';
  if not Result then// a mens de erro ja foi exibida dentro do dthframe
    exit;

  Result := DtHIni < DtHFin;
  if not Result then
  begin
    EstFiltroFrame.ErroLabel.Caption :=
      'A data final deve ser maior do que a inicial';
    exit;
  end;
end;

constructor TAppInventarioDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  inherited;
//  FInventarioEnt := pEntEd as IInventarioEnt; //EntEdCastToInventarioEnt(pEntEd);
  FInventarioEnt := EntEdCastToInventarioEnt(pEntEd);
  FInventarioDBI := EntDBICastToInventarioDBI(pEntDBI);

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppInventarioDataSetForm.PergEd.conn',
    AppObj.SisConfig, FDBConnectionParams, ProcessLog, Output);

  FInventarioItemDBI := TInventarioItemDBI.Create(FDBConnection);
  FInventarioItemDBGridFrame := TInventarioItemDBGridFrame.Create(DetailPanel,
    FInventarioItemDBI);
  ItemsDBGridFrame := FInventarioItemDBGridFrame;
  FInventarioItemDBGridFrame.Align := alClient;
end;

procedure TAppInventarioDataSetForm.CrieFiltroFrame;
begin
  inherited;
  EstFiltroFrame := TEstFiltroFrame.Create(Self, DoAtualizar);
  EstFiltroFrame.Align := alBottom;
  EstFiltroFrame.Top := DetailPanel.Top + DetailPanel.Height;
  TitPanel_BasTabSheet.Top := EstFiltroFrame.Top + EstFiltroFrame.Height;
end;

procedure TAppInventarioDataSetForm.DetailCarregar;
var
  i: integer;
  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iEstMovId: Int64;
begin
  inherited;

  iLojaId := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  iTerminalId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;
  iEstMovId := FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt;

  FInventarioItemDBGridFrame.Carregar(iLojaId, iTerminalId, iEstMovId);
end;

procedure TAppInventarioDataSetForm.EntToRecord;
var
  i: integer;
  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iId: TId;
  sCod: string;
begin
  inherited;

  iLojaId := FInventarioEnt.Loja.Id;
  iTerminalId := FInventarioEnt.TerminalId;
  iId := FInventarioEnt.InventarioId;

  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := iLojaId;
  FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger := iTerminalId;
  FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt := FInventarioEnt.EstMovId;
  FDMemTable.Fields[3 { INVENTARIO_ID } ].AsInteger := iId;

  sCod := 'SAI-' + CodsToCodAsString(iLojaId, iTerminalId, iId, False);
  FDMemTable.Fields[4 { COD } ].AsString := sCod;

  FDMemTable.Fields[5 { CRIADO_EM } ].AsDateTime := FInventarioEnt.CriadoEm; //
  FDMemTable.Fields[6 { FINALIZADO } ].AsBoolean := FInventarioEnt.Finalizado;
  // ;
  FDMemTable.Fields[7 { FINALIZADO_EM } ].AsDateTime :=
    FInventarioEnt.FinalizadoEm; //
  FDMemTable.Fields[8 { CANCELADO } ].AsBoolean := FInventarioEnt.Cancelado; //
  FDMemTable.Fields[9 { CANCELADO_EM } ].AsDateTime :=
    FInventarioEnt.CanceladoEm; //
  FDMemTable.Fields[10 { CRIADO_POR_ID } ].AsInteger := 0;
  FDMemTable.Fields[11 { CRIADO_POR_APELIDO } ].AsString := '';
  FDMemTable.Fields[12 { CANCELADO_POR_ID } ].AsInteger := 0; //
  FDMemTable.Fields[13 { CANCELADO_POR_APELIDO } ].AsString := ''; //
  FDMemTable.Fields[14 { FINALIZADO_POR_ID } ].AsInteger := 0; //
  FDMemTable.Fields[15 { FINALIZADO_POR_APELIDO } ].AsString := ''; //

end;

procedure TAppInventarioDataSetForm.EstLeRegEInsere(q: TDataSet;
  pRecNo: integer);
var
  i: integer;
  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iId: TId;
  sCod: string;
begin
  if pRecNo = -1 then
    exit;

  FDMemTable.Append;

  iLojaId := q.Fields[0 { LOJA_ID } ].AsInteger;
  iTerminalId := q.Fields[1 { TERMINAL_ID } ].AsInteger;
  iId := q.Fields[3 { EST_SAIDA_ID } ].AsInteger;

  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := iLojaId;
  FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger := iTerminalId;
  FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt := q.Fields[2 { EST_MOV_ID } ]
    .AsLargeInt;
  FDMemTable.Fields[3 { INVENTARIO_ID } ].AsInteger := iId;

  sCod := 'SAI-' + CodsToCodAsString(iLojaId, iTerminalId, iId, False);
  FDMemTable.Fields[4 { COD } ].AsString := sCod;
  FDMemTable.Fields[5 { CRIADO_EM } ].AsDateTime := q.Fields[5 { CRIADO_EM } ]
    .AsDateTime; //
  FDMemTable.Fields[6 { FINALIZADO } ].AsBoolean := q.Fields[6 { FINALIZADO } ]
    .AsBoolean; //
  FDMemTable.Fields[7 { FINALIZADO_EM } ].AsDateTime :=
    q.Fields[7 { FINALIZADO_EM } ].AsDateTime; //
  FDMemTable.Fields[8 { CANCELADO } ].AsBoolean := q.Fields[8 { CANCELADO } ]
    .AsBoolean; //
  FDMemTable.Fields[9 { CANCELADO_EM } ].AsDateTime :=
    q.Fields[9 { CANCELADO_EM } ].AsDateTime; //
  FDMemTable.Fields[10 { CRIADO_POR_ID } ].AsInteger :=
    q.Fields[10 { CRIADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[11 { CRIADO_POR_APELIDO } ].AsString :=
    q.Fields[11 { CRIADO_POR_APELIDO } ].AsString; //
  FDMemTable.Fields[12 { CANCELADO_POR_ID } ].AsInteger :=
    q.Fields[12 { CANCELADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[13 { CANCELADO_POR_APELIDO } ].AsString :=
    q.Fields[13 { CANCELADO_POR_APELIDO } ].AsString; //
  FDMemTable.Fields[14 { FINALIZADO_POR_ID } ].AsInteger :=
    q.Fields[14 { FINALIZADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[15 { FINALIZADO_POR_APELIDO } ].AsString :=
    q.Fields[15 { FINALIZADO_POR_APELIDO } ].AsString; //


  // RecordToFDMemTable(q, FDMemTable);

  FDMemTable.Post;
end;

function TAppInventarioDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Inv\tabview.app.retag.est.inv.csv';

  Result := sNomeArq;
end;

function TAppInventarioDataSetForm.PergEd: boolean;
begin
  Result := InventarioPerg(nil, AppObj, FInventarioEnt, FInventarioDBI,
    FDBConnection, UsuarioLog, DBMS);
end;

procedure TAppInventarioDataSetForm.RecordToEnt;
var
  i: integer;
  sCod: string;
begin
  inherited;

  FInventarioEnt.Loja.Id := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  FInventarioEnt.TerminalId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;
  FInventarioEnt.EstMovId := FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt;
  FInventarioEnt.InventarioId := FDMemTable.Fields[3 { EST_SAIDA_ID } ].AsInteger;

  FInventarioEnt.CriadoEm := FDMemTable.Fields[5 { CRIADO_EM } ].AsDateTime; //
  FInventarioEnt.Finalizado := FDMemTable.Fields[6 { FINALIZADO } ].AsBoolean;
  // ;
  FInventarioEnt.FinalizadoEm := FDMemTable.Fields[7 { FINALIZADO_EM } ]
    .AsDateTime; //
  FInventarioEnt.Cancelado := FDMemTable.Fields[8 { CANCELADO } ].AsBoolean; //
  FInventarioEnt.CanceladoEm := FDMemTable.Fields[9 { CANCELADO_EM } ]
    .AsDateTime; //
  // FDMemTable.Fields[12 { CRIADO_POR_ID } ].AsInteger := 0;
  // FDMemTable.Fields[13 { CRIADO_POR_APELIDO } ].AsString := '';
  // FDMemTable.Fields[14 { CANCELADO_POR_ID } ].AsInteger := 0; //
  // FDMemTable.Fields[15 { CANCELADO_POR_APELIDO } ].AsString := ''; //
  // FDMemTable.Fields[16 { FINALIZADO_POR_ID } ].AsInteger := 0; //
  // FDMemTable.Fields[17 { FINALIZADO_POR_APELIDO } ].AsString := ''; //
end;

procedure TAppInventarioDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
//  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(FinalizAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
