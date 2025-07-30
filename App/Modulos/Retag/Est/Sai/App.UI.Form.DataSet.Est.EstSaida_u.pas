unit App.UI.Form.DataSet.Est.EstSaida_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Est_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo,
  App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.EstSaida.Ent, App.Retag.Est.EstSaida.DBI,
  App.UI.Frame.DBGrid.Est.EstSaidaItem_u, App.Retag.Est.EstSaidaItem.DBI_u,
  Sis.DBI, App.UI.Form.Perg_u;

type
  TAppEstSaidaDataSetForm = class(TAppEstDataSetForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);
    procedure InsAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FEstSaidaEnt: IEstSaidaEnt;
    FEstSaidaDBI: IEstSaidaDBI;
    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;
    FEstSaidaItemDBI: IDBI;
    FEstSaidaItemDBGridFrame: TEstSaidaItemDBGridFrame;
    FDMemTableEST_SAIDA_MOTIVO_ID: TField;
    FDMemTableEST_SAIDA_MOTIVO_DESCR: TField;
  protected
    procedure EstLeRegEInsere(q: TDataSet; pRecNo: integer); override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;

    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure CrieFiltroFrame; override;
    function PergEd: boolean; override;
    procedure DetailCarregar; override;

    function FinalizPode: boolean; override;
    procedure DoAlterar; override;
    function AtuPode: Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pStrBuscaInicial: string;
      pAppObj: IAppObj); override;
  end;

var
  AppEstSaidaDataSetForm: TAppEstSaidaDataSetForm;

implementation

{$R *.dfm}

uses App.UI.Frame.Bas.EstFiltro_u, Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  App.Retag.Est.Factory, Sis.DB.Factory, App.DB.Utils, App.UI.Form.Retag.Excl_u, Sis.DB.DataSet.Utils, Sis.Entities.Types, Sis.Types,
  Sis.UI.Controls.Utils, Sis.Sis.Constants, Sis.Types.Utils_u,
  App.Retag.Est.EstSaidaItem;

{ TAppEstSaidaDataSetForm }

procedure TAppEstSaidaDataSetForm.AltAction_DatasetTabSheetExecute(
  Sender: TObject);
var
  Result: Boolean;
begin
  Result := not FDMemTable.IsEmpty;
  if not Result then
  begin
    ShowMessage('Não há registro de nota a alterar');
    exit;
  end;

  Result := not DMemTableFINALIZADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota já está finalizada e não pode ser alterada');
    exit;
  end;

  Result := not DMemTableCANCELADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota está cancelada e não pode ser alterada');
    exit;
  end;

  inherited;
end;

function TAppEstSaidaDataSetForm.AtuPode: Boolean;
var
  // valores dth so sao lidos do filtro aqui somente pra poder testar
  // serao depois relidos no ForEach
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

constructor TAppEstSaidaDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pStrBuscaInicial: string;pAppObj: IAppObj);
begin
  inherited;
//  FEstSaidaEnt := pEntEd as IEstSaidaEnt; //EntEdCastToEstSaidaEnt(pEntEd);
  FEstSaidaEnt := EntEdCastToEstSaidaEnt(pEntEd);
  FEstSaidaDBI := EntDBICastToEstSaidaDBI(pEntDBI);

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppEstSaidaDataSetForm.conn',
    AppObj.SisConfig, FDBConnectionParams, ProcessLog, Output);

  FEstSaidaItemDBI := TEstSaidaItemDBI.Create(FDBConnection);
  FEstSaidaItemDBGridFrame := TEstSaidaItemDBGridFrame.Create(DetailPanel,
    FEstSaidaItemDBI);
  ItemsDBGridFrame := FEstSaidaItemDBGridFrame;
  FEstSaidaItemDBGridFrame.Align := alClient;

  FDMemTableEST_SAIDA_MOTIVO_ID := FDMemTable.FindField('EST_SAIDA_MOTIVO_ID');
  FDMemTableEST_SAIDA_MOTIVO_DESCR := FDMemTable.FindField('EST_SAIDA_MOTIVO_DESCR');
end;

procedure TAppEstSaidaDataSetForm.CrieFiltroFrame;
begin
  inherited;
  EstFiltroFrame := TEstFiltroFrame.Create(Self, DoAtualizar);
  EstFiltroFrame.Align := alBottom;
  EstFiltroFrame.Top := DetailPanel.Top + DetailPanel.Height;
  TitPanel_BasTabSheet.Top := EstFiltroFrame.Top + EstFiltroFrame.Height;

  // {$IFDEF DEBUG}
  // SetNameToHint(Self);
  // {$ENDIF}
  // TitToolBar1_BasTabSheet

  // TitToolPanel_BasTabSheet.Height := TitToolPanel_BasTabSheet.Height +
  // EstFiltroFrame.Height;
  // TitToolBar1_BasTabSheet.Top := EstFiltroFrame.Top + EstFiltroFrame.Height;
end;

procedure TAppEstSaidaDataSetForm.DetailCarregar;
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

  FEstSaidaItemDBGridFrame.Carregar(iLojaId, iTerminalId, iEstMovId);
end;

procedure TAppEstSaidaDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := PergEd;
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTableEST_SAIDA_MOTIVO_ID.AsInteger := FEstSaidaEnt.SaidaMotivoId;
  FDMemTableEST_SAIDA_MOTIVO_DESCR.AsString := FEstSaidaEnt.SaidaMotivoDescr;
  FDMemTable.Post;
end;

procedure TAppEstSaidaDataSetForm.EntToRecord;
var
  i: integer;
  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iId: TId;
  sCod: string;
begin
  inherited;

  iLojaId := FEstSaidaEnt.Loja.Id;
  iTerminalId := FEstSaidaEnt.TerminalId;
  iId := FEstSaidaEnt.EstSaidaId;

  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := iLojaId;
  FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger := iTerminalId;
  FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt := FEstSaidaEnt.EstMovId;
  FDMemTable.Fields[3 { EST_SAIDA_ID } ].AsInteger := iId;

  sCod := 'SAI-' + CodsToCodAsString(iLojaId, iTerminalId, iId, False);
  FDMemTable.Fields[4 { COD } ].AsString := sCod;

  FDMemTable.Fields[5 { CRIADO_EM } ].AsDateTime := FEstSaidaEnt.CriadoEm; //
  FDMemTable.Fields[6 { EST_SAIDA_MOTIVO_ID } ].AsInteger :=
    FEstSaidaEnt.SaidaMotivoId; //
  FDMemTable.Fields[7 { EST_SAIDA_MOTIVO_DESCR } ].AsString :=
    FEstSaidaEnt.SaidaMotivoDescr; // ; //
  FDMemTable.Fields[8 { FINALIZADO } ].AsBoolean := FEstSaidaEnt.Finalizado;
  // ;
  FDMemTable.Fields[9 { FINALIZADO_EM } ].AsDateTime :=
    FEstSaidaEnt.FinalizadoEm; //
  FDMemTable.Fields[10 { CANCELADO } ].AsBoolean := FEstSaidaEnt.Cancelado; //
  FDMemTable.Fields[11 { CANCELADO_EM } ].AsDateTime :=
    FEstSaidaEnt.CanceladoEm; //
  FDMemTable.Fields[12 { CRIADO_POR_ID } ].AsInteger := 0;
  FDMemTable.Fields[13 { CRIADO_POR_APELIDO } ].AsString := '';
  FDMemTable.Fields[14 { CANCELADO_POR_ID } ].AsInteger := 0; //
  FDMemTable.Fields[15 { CANCELADO_POR_APELIDO } ].AsString := ''; //
  FDMemTable.Fields[16 { FINALIZADO_POR_ID } ].AsInteger := 0; //
  FDMemTable.Fields[17 { FINALIZADO_POR_APELIDO } ].AsString := ''; //

end;

procedure TAppEstSaidaDataSetForm.EstLeRegEInsere(q: TDataSet; pRecNo: integer);
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
  FDMemTable.Fields[3 { EST_SAIDA_ID } ].AsInteger := iId;

  sCod := 'SAI-' + CodsToCodAsString(iLojaId, iTerminalId, iId, False);
  FDMemTable.Fields[4 { COD } ].AsString := sCod;
  FDMemTable.Fields[5 { CRIADO_EM } ].AsDateTime := q.Fields[5 { CRIADO_EM } ]
    .AsDateTime; //
  FDMemTable.Fields[6 { EST_SAIDA_MOTIVO_ID } ].AsInteger :=
    q.Fields[6 { EST_SAIDA_MOTIVO_ID } ].AsInteger; //
  FDMemTable.Fields[7 { EST_SAIDA_MOTIVO_DESCR } ].AsString :=
    q.Fields[7 { EST_SAIDA_MOTIVO_DESCR } ].AsString; //
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

function TAppEstSaidaDataSetForm.FinalizPode: boolean;
var
  s: string;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := FDMemTableEST_SAIDA_MOTIVO_ID.AsInteger > 0;
  if not Result then
  begin
    s := 'O campo ''Motivo'' é obrigatório para finalizar uma Nota de Saída';
    ShowMessage(s);
    exit;
  end;
end;

function TAppEstSaidaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Sai\tabview.app.retag.est.sai.csv';

  Result := sNomeArq;
end;

procedure TAppEstSaidaDataSetForm.InsAction_DatasetTabSheetExecute(
  Sender: TObject);
begin
  inherited;
//
end;

function TAppEstSaidaDataSetForm.PergEd: boolean;
begin
  Result := EstSaidaPerg(nil, AppObj, FEstSaidaEnt, FEstSaidaDBI,
    FDBConnection, UsuarioLog, DBMS);
end;

procedure TAppEstSaidaDataSetForm.RecordToEnt;
var
  i: integer;
  sCod: string;
begin
  inherited;

  FEstSaidaEnt.Loja.Id := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  FEstSaidaEnt.TerminalId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;
  FEstSaidaEnt.EstMovId := FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt;
  FEstSaidaEnt.EstSaidaId := FDMemTable.Fields[3 { EST_SAIDA_ID } ].AsInteger;

  FEstSaidaEnt.CriadoEm := FDMemTable.Fields[5 { CRIADO_EM } ].AsDateTime; //
  FEstSaidaEnt.SaidaMotivoId := FDMemTable.Fields[6 { EST_SAIDA_MOTIVO_ID } ]
    .AsInteger; //
  FEstSaidaEnt.SaidaMotivoDescr := FDMemTable.Fields
    [7 { EST_SAIDA_MOTIVO_DESCR } ].AsString; //
  FEstSaidaEnt.Finalizado := FDMemTable.Fields[8 { FINALIZADO } ].AsBoolean;
  // ;
  FEstSaidaEnt.FinalizadoEm := FDMemTable.Fields[9 { FINALIZADO_EM } ]
    .AsDateTime; //
  FEstSaidaEnt.Cancelado := FDMemTable.Fields[10 { CANCELADO } ].AsBoolean; //
  FEstSaidaEnt.CanceladoEm := FDMemTable.Fields[11 { CANCELADO_EM } ]
    .AsDateTime; //
  // FDMemTable.Fields[12 { CRIADO_POR_ID } ].AsInteger := 0;
  // FDMemTable.Fields[13 { CRIADO_POR_APELIDO } ].AsString := '';
  // FDMemTable.Fields[14 { CANCELADO_POR_ID } ].AsInteger := 0; //
  // FDMemTable.Fields[15 { CANCELADO_POR_APELIDO } ].AsString := ''; //
  // FDMemTable.Fields[16 { FINALIZADO_POR_ID } ].AsInteger := 0; //
  // FDMemTable.Fields[17 { FINALIZADO_POR_APELIDO } ].AsString := ''; //
end;

procedure TAppEstSaidaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //InsAction_DatasetTabSheet.Execute;
  //fdmemtable.next;
//  InsItemAction_DatasetTabSheet.Execute;
end;

procedure TAppEstSaidaDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(FinalizAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
