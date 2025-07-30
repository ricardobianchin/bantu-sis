unit App.UI.Form.DataSet.Est.Venda_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Est_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo,
  App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  Sis.DBI, App.UI.Form.Perg_u, App.Retag.Est.Venda.DBI,
  App.Retag.Est.Venda.Ent, App.Retag.Est.VendaItem,
  App.UI.Frame.DBGrid.Est.VendaItem_u;

type
  TAppRetagVendaDataSetForm = class(TAppEstDataSetForm)
    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FRetagVendaEnt: IRetagVendaEnt;
    FRetagVendaDBI: IRetagVendaDBI;
    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;
    FRetagVendaItemDBI: IDBI;
    FRetagVendaItemDBGridFrame: TRetagVendaItemDBGridFrame;
    // FDMemTableFORNECEDOR_ID: TField;
  protected
    procedure EstLeRegEInsere(q: TDataSet; pRecNo: integer); override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;

    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure CrieFiltroFrame; override;
    procedure DetailCarregar; override;

    function FinalizPode: boolean; override;
    procedure DoAlterar; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pStrBuscaInicial: string;
      pAppObj: IAppObj); override;
  end;

var
  AppRetagVendaDataSetForm: TAppRetagVendaDataSetForm;

implementation

{$R *.dfm}

uses App.UI.Frame.Bas.EstFiltro_u, Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  App.Retag.Est.Factory, Sis.DB.Factory, App.DB.Utils,
  App.UI.Form.Retag.Excl_u, Sis.DB.DataSet.Utils, Sis.Entities.Types, Sis.Types,
  Sis.UI.Controls.Utils, Sis.Sis.Constants, Sis.Types.Utils_u,
  App.Retag.Est.VendaItem.DBI_u;

{ TAppEstDataSetForm1 }

procedure TAppRetagVendaDataSetForm.AtuAction_DatasetTabSheetExecute(
  Sender: TObject);
begin
  inherited;
//
end;

constructor TAppRetagVendaDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pStrBuscaInicial: string;pAppObj: IAppObj);
begin
  inherited;
  FRetagVendaEnt := EntEdCastToRetagVendaEnt(pEntEd);
  FRetagVendaDBI := EntDBICastToRetagVendaDBI(pEntDBI);

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppRetagVendaDataSetForm.PergEd.conn',
    AppObj.SisConfig, FDBConnectionParams, ProcessLog, Output);

  FRetagVendaItemDBI := TRetagVendaItemDBI.Create(FDBConnection);
  FRetagVendaItemDBGridFrame := TRetagVendaItemDBGridFrame.Create(DetailPanel,
    FRetagVendaItemDBI);
  ItemsDBGridFrame := FRetagVendaItemDBGridFrame;
//  FRetagVendaItemDBGridFrame.DBGrid1.OnDblClick := ItemDBGridDblClick;

  FRetagVendaItemDBGridFrame.Align := alClient;

  // FDMemTableFORNECEDOR_ID := FDMemTable.FindField('FORNECEDOR_ID');
end;

procedure TAppRetagVendaDataSetForm.CrieFiltroFrame;
begin
  inherited;
  EstFiltroFrame := TEstFiltroFrame.Create(Self, DoAtualizar);
  EstFiltroFrame.Align := alBottom;
  EstFiltroFrame.Top := DetailPanel.Top + DetailPanel.Height;
  TitPanel_BasTabSheet.Top := EstFiltroFrame.Top + EstFiltroFrame.Height;
end;

procedure TAppRetagVendaDataSetForm.DetailCarregar;
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

  FRetagVendaItemDBGridFrame.Carregar(iLojaId, iTerminalId, iEstMovId);
end;

procedure TAppRetagVendaDataSetForm.DoAlterar;
begin
  inherited;

end;

procedure TAppRetagVendaDataSetForm.EntToRecord;
begin
  inherited;

end;

procedure TAppRetagVendaDataSetForm.EstLeRegEInsere(q: TDataSet;
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
  iId := q.Fields[3 { VENDA_ID } ].AsInteger;

  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := iLojaId;
  FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger := iTerminalId;
  FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt := q.Fields[2 { EST_MOV_ID } ]
    .AsLargeInt;
  FDMemTable.Fields[3 { ENTRADA_ID } ].AsInteger := iId;

  sCod := FRetagVendaEnt.NomeEntAbrev + '-' + CodsToCodAsString(iLojaId,
    iTerminalId, iId, False);

  FDMemTable.Fields[4 { COD } ].AsString := sCod;

  FDMemTable.Fields[5 { CRIADO_EM } ].AsDateTime := q.Fields[5 { CRIADO_EM } ]
    .AsDateTime; //

  FDMemTable.Fields[6 { DESCONTO_TOTAL } ].AsCurrency :=
    q.Fields[6 { DESCONTO_TOTAL } ].AsCurrency; //
  FDMemTable.Fields[7 { TOTAL_LIQUIDO } ].AsCurrency :=
    q.Fields[7 { TOTAL_LIQUIDO } ].AsCurrency; //

  FDMemTable.Fields[8 { FINALIZADO } ].AsBoolean := q.Fields[8 { FINALIZADO } ]
    .AsBoolean; //
  FDMemTable.Fields[9 { FINALIZADO_EM } ].AsDateTime :=
    q.Fields[9 { FINALIZADO_EM } ].AsDateTime; //
  FDMemTable.Fields[10 { CANCELADO } ].AsBoolean := q.Fields[10 { CANCELADO } ]
    .AsBoolean; //
  FDMemTable.Fields[11 { CANCELADO_EM } ].AsDateTime :=
    q.Fields[11 { CANCELADO_EM } ].AsDateTime; //
  FDMemTable.Fields[12 { CRIADO_POR_ID } ].AsInteger :=
    q.Fields[12 { CRIADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[13 { CRIADO_POR_APELIDO } ].AsString :=
    q.Fields[13 { CRIADO_POR_APELIDO } ].AsString; //
  FDMemTable.Fields[14 { CANCELADO_POR_ID } ].AsInteger :=
    q.Fields[14 { CANCELADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[15 { CANCELADO_POR_APELIDO } ].AsString :=
    q.Fields[15 { CANCELADO_POR_APELIDO } ].AsString; //
  FDMemTable.Fields[16 { FINALIZADO_POR_ID } ].AsInteger :=
    q.Fields[16 { FINALIZADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[17 { FINALIZADO_POR_APELIDO } ].AsString :=
    q.Fields[17 { FINALIZADO_POR_APELIDO } ].AsString; //

  // RecordToFDMemTable(q, FDMemTable);

  FDMemTable.Post;
end;

function TAppRetagVendaDataSetForm.FinalizPode: boolean;
begin
  Result := False;
end;

function TAppRetagVendaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Ven\tabview.app.retag.est.ven.csv';

  Result := sNomeArq;
end;

procedure TAppRetagVendaDataSetForm.RecordToEnt;
begin
  inherited;

end;

procedure TAppRetagVendaDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
end;

end.
