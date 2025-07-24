unit App.UI.Form.DataSet.Est.Entrada_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Est_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo,
  App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.Entrada.Ent, App.Retag.Est.Entrada.DBI,
  App.UI.Frame.DBGrid.Est.EntradaItem_u, App.Retag.Est.EntradaItem.DBI_u,
  Sis.DBI, App.UI.Form.Perg_u;

type
  TAppEntradaDataSetForm = class(TAppEstDataSetForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FEntradaEnt: IEntradaEnt;
    FEntradaDBI: IEntradaDBI;
    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;
    FEntradaItemDBI: IDBI;
    FEntradaItemDBGridFrame: TEntradaItemDBGridFrame;
    FDMemTableFORNECEDOR_ID: TField;
    FDMemTableFORNECEDOR_APELIDO: TField;
    FDMemTableNDOC: TField;
    FDMemTableSERIE: TField;

    procedure DataSetToEntradaItems(q: TDataSet; pRecNo: integer);
    procedure ItemDBGridDblClick(Sender: TObject);
  protected
    procedure ActionAlt; override;

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
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  AppEntradaDataSetForm: TAppEntradaDataSetForm;

implementation

{$R *.dfm}

uses App.UI.Frame.Bas.EstFiltro_u, Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  App.Retag.Est.Factory, Sis.DB.Factory, App.DB.Utils,
  App.UI.Form.Retag.Excl_u, Sis.DB.DataSet.Utils, Sis.Entities.Types, Sis.Types,
  Sis.UI.Controls.Utils, Sis.Sis.Constants, Sis.Types.Utils_u,
  App.Retag.Est.EntradaItem;

procedure TAppEntradaDataSetForm.ActionAlt;
var
  Result: boolean;
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

function TAppEntradaDataSetForm.AtuPode: Boolean;
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

constructor TAppEntradaDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  inherited;
  // FEntradaEnt := pEntEd as IEntradaEnt; //EntEdCastToEntradaEnt(pEntEd);
  FEntradaEnt := EntEdCastToEntradaEnt(pEntEd);
  FEntradaDBI := EntDBICastToEntradaDBI(pEntDBI);

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppEntradaDataSetForm.PergEd.conn',
    AppObj.SisConfig, FDBConnectionParams, ProcessLog, Output);

  FEntradaItemDBI := TEntradaItemDBI.Create(FDBConnection);
  FEntradaItemDBGridFrame := TEntradaItemDBGridFrame.Create(DetailPanel,
    FEntradaItemDBI);
  ItemsDBGridFrame := FEntradaItemDBGridFrame;
  FEntradaItemDBGridFrame.DBGrid1.OnDblClick := ItemDBGridDblClick;

  FEntradaItemDBGridFrame.Align := alClient;

  FDMemTableFORNECEDOR_ID := FDMemTable.FindField('FORNECEDOR_ID');
  FDMemTableFORNECEDOR_APELIDO := FDMemTable.FindField('FORNECEDOR_APELIDO');
  FDMemTableNDOC := FDMemTable.FindField('NDOC');
  FDMemTableSERIE := FDMemTable.FindField('SERIE');
end;

procedure TAppEntradaDataSetForm.CrieFiltroFrame;
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

procedure TAppEntradaDataSetForm.DataSetToEntradaItems(q: TDataSet;
  pRecNo: integer);
var
  oItem: IRetagEntradaItem;
  g: TEntradaItemDBGridFrame;
begin
  if pRecNo = -1 then
    exit;

  g := FEntradaItemDBGridFrame;

  oItem := App.Retag.Est.Factory.RetagEntradaItemCreate( //
    g.FieldORDEM.AsInteger, //
    g.FieldPROD_ID.AsInteger, //

    g.FieldDESCR_RED.AsString, //
    g.FieldFABR_NOME.AsString, //
    g.FieldUNID_SIGLA.AsString, //

    g.FieldNITEM.AsInteger, //
    g.FieldPROD_ID_DELES.AsString, //

    g.FieldQTD.AsCurrency, //
    g.FieldCUSTO.AsCurrency, //
    g.FieldMARGEM.AsCurrency, //
    g.FieldPRECO.AsCurrency, //

    g.FieldCRIADO_EM.AsDateTime, //
    g.FieldCANCELADO.AsBoolean //
    );

  FEntradaEnt.Items.Add(oItem);
end;

procedure TAppEntradaDataSetForm.DetailCarregar;
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

  FEntradaItemDBGridFrame.Carregar(iLojaId, iTerminalId, iEstMovId);
end;

procedure TAppEntradaDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := PergEd;
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTableFORNECEDOR_ID.AsInteger := FEntradaEnt.FornecedorId;
  FDMemTableFORNECEDOR_APELIDO.AsString := FEntradaEnt.FornecedorApelido;
  FDMemTableNDOC.AsInteger := FEntradaEnt.NDoc;
  FDMemTableSERIE.AsInteger := FEntradaEnt.Serie;
  FDMemTable.Post;
  DetailCarregar;
end;

procedure TAppEntradaDataSetForm.EntToRecord;
var
  i: integer;
  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iId: TId;
  sCod: string;
begin
  inherited;

  iLojaId := FEntradaEnt.Loja.Id;
  iTerminalId := FEntradaEnt.TerminalId;
  iId := FEntradaEnt.EntradaId;

  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := iLojaId;
  FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger := iTerminalId;
  FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt := FEntradaEnt.EstMovId;
  FDMemTable.Fields[3 { ENTRADA_ID } ].AsInteger := iId;

  sCod := FEntradaEnt.NomeEntAbrev + '-' + CodsToCodAsString(iLojaId,
    iTerminalId, iId, False);
  FDMemTable.Fields[4 { COD } ].AsString := sCod;

  FDMemTable.Fields[5 { NDOC } ].AsInteger := FEntradaEnt.NDoc;
  FDMemTable.Fields[6 { SERIE } ].AsInteger := FEntradaEnt.Serie;

  FDMemTable.Fields[7 { CRIADO_EM } ].AsDateTime := FEntradaEnt.CriadoEm; //
  FDMemTable.Fields[8 { FORNECEDOR_ID } ].AsInteger := FEntradaEnt.FornecedorId;
  //
  FDMemTable.Fields[9 { FORNECEDOR_APELIDO } ].AsString :=
    FEntradaEnt.FornecedorApelido; // ; //
  FDMemTable.Fields[10 { FINALIZADO } ].AsBoolean := FEntradaEnt.Finalizado;
  // ;
  FDMemTable.Fields[11 { FINALIZADO_EM } ].AsDateTime :=
    FEntradaEnt.FinalizadoEm; //
  FDMemTable.Fields[12 { CANCELADO } ].AsBoolean := FEntradaEnt.Cancelado; //
  FDMemTable.Fields[13 { CANCELADO_EM } ].AsDateTime := FEntradaEnt.CanceladoEm;
  //
  FDMemTable.Fields[14 { CRIADO_POR_ID } ].AsInteger := 0;
  FDMemTable.Fields[15 { CRIADO_POR_APELIDO } ].AsString := '';
  FDMemTable.Fields[16 { CANCELADO_POR_ID } ].AsInteger := 0; //
  FDMemTable.Fields[17 { CANCELADO_POR_APELIDO } ].AsString := ''; //
  FDMemTable.Fields[18 { FINALIZADO_POR_ID } ].AsInteger := 0; //
  FDMemTable.Fields[19 { FINALIZADO_POR_APELIDO } ].AsString := ''; //

  DetailCarregar;
end;

procedure TAppEntradaDataSetForm.EstLeRegEInsere(q: TDataSet; pRecNo: integer);
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
  iId := q.Fields[3 { ENTRADA_ID } ].AsInteger;

  FDMemTable.Fields[0 { LOJA_ID } ].AsInteger := iLojaId;
  FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger := iTerminalId;
  FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt := q.Fields[2 { EST_MOV_ID } ]
    .AsLargeInt;
  FDMemTable.Fields[3 { ENTRADA_ID } ].AsInteger := iId;

  sCod := FEntradaEnt.NomeEntAbrev + '-' + CodsToCodAsString(iLojaId,
    iTerminalId, iId, False);

  FDMemTable.Fields[4 { COD } ].AsString := sCod;

  FDMemTable.Fields[5 { NDOC } ].AsInteger := q.Fields[5 { NDOC } ].AsInteger;
  //

  FDMemTable.Fields[6 { SERIE } ].AsInteger := q.Fields[6 { SERIE } ].AsInteger;
  //

  FDMemTable.Fields[7 { CRIADO_EM } ].AsDateTime := q.Fields[7 { CRIADO_EM } ]
    .AsDateTime; //
  FDMemTable.Fields[8 { EST_SAIDA_MOTIVO_ID } ].AsInteger :=
    q.Fields[8 { EST_SAIDA_MOTIVO_ID } ].AsInteger; //
  FDMemTable.Fields[9 { EST_SAIDA_MOTIVO_DESCR } ].AsString :=
    q.Fields[9 { EST_SAIDA_MOTIVO_DESCR } ].AsString; //
  FDMemTable.Fields[10 { FINALIZADO } ].AsBoolean :=
    q.Fields[10 { FINALIZADO } ].AsBoolean; //
  FDMemTable.Fields[11 { FINALIZADO_EM } ].AsDateTime :=
    q.Fields[11 { FINALIZADO_EM } ].AsDateTime; //
  FDMemTable.Fields[12 { CANCELADO } ].AsBoolean := q.Fields[12 { CANCELADO } ]
    .AsBoolean; //
  FDMemTable.Fields[13 { CANCELADO_EM } ].AsDateTime :=
    q.Fields[13 { CANCELADO_EM } ].AsDateTime; //
  FDMemTable.Fields[14 { CRIADO_POR_ID } ].AsInteger :=
    q.Fields[14 { CRIADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[15 { CRIADO_POR_APELIDO } ].AsString :=
    q.Fields[15 { CRIADO_POR_APELIDO } ].AsString; //
  FDMemTable.Fields[16 { CANCELADO_POR_ID } ].AsInteger :=
    q.Fields[16 { CANCELADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[17 { CANCELADO_POR_APELIDO } ].AsString :=
    q.Fields[17 { CANCELADO_POR_APELIDO } ].AsString; //
  FDMemTable.Fields[18 { FINALIZADO_POR_ID } ].AsInteger :=
    q.Fields[18 { FINALIZADO_POR_ID } ].AsInteger; //
  FDMemTable.Fields[19 { FINALIZADO_POR_APELIDO } ].AsString :=
    q.Fields[19 { FINALIZADO_POR_APELIDO } ].AsString; //


  // RecordToFDMemTable(q, FDMemTable);

  FDMemTable.Post;
end;

function TAppEntradaDataSetForm.FinalizPode: boolean;
var
  s: string;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := FDMemTableFORNECEDOR_ID.AsInteger > 0;
  if not Result then
  begin
    s := 'O campo ''Fornecedor'' � obrigat�rio para finalizar uma Nota de Entrada';
    ShowMessage(s);
    exit;
  end;
end;

function TAppEntradaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Ent\tabview.app.retag.est.ent.csv';

  Result := sNomeArq;
end;

procedure TAppEntradaDataSetForm.ItemDBGridDblClick(Sender: TObject);
begin
  AltItemAction_DatasetTabSheet.Execute;
end;

function TAppEntradaDataSetForm.PergEd: boolean;
begin
  Result := EntradaPerg(nil, AppObj, FEntradaEnt, FEntradaDBI, FDBConnection,
    UsuarioLog, DBMS);
end;

procedure TAppEntradaDataSetForm.RecordToEnt;
var
  i: integer;
  sCod: string;
  oItem: IRetagEntradaItem;
  g: TEntradaItemDBGridFrame;
begin
  inherited;
  FEntradaEnt.Loja.Id := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  FEntradaEnt.TerminalId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;
  FEntradaEnt.EstMovId := FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt;
  FEntradaEnt.EntradaId := FDMemTable.Fields[3 { ENTRADA_ID } ].AsInteger;

  FEntradaEnt.NDoc := FDMemTable.Fields[5 { NDOC } ].AsInteger;
  FEntradaEnt.Serie := FDMemTable.Fields[6 { SERIE } ].AsInteger;

  FEntradaEnt.CriadoEm := FDMemTable.Fields[7 { CRIADO_EM } ].AsDateTime; //
  FEntradaEnt.FornecedorId := FDMemTable.Fields[8 { FORNECEDOR_ID } ].AsInteger;
  //
  FEntradaEnt.FornecedorApelido := FDMemTable.Fields[9 { FORNECEDOR_APELIDO } ]
    .AsString; //
  FEntradaEnt.Finalizado := FDMemTable.Fields[10 { FINALIZADO } ].AsBoolean;
  // ;
  FEntradaEnt.FinalizadoEm := FDMemTable.Fields[11 { FINALIZADO_EM } ]
    .AsDateTime; //
  FEntradaEnt.Cancelado := FDMemTable.Fields[12 { CANCELADO } ].AsBoolean; //
  FEntradaEnt.CanceladoEm := FDMemTable.Fields[13 { CANCELADO_EM } ].AsDateTime;

  g := FEntradaItemDBGridFrame;
  if g.FDMemTable1.IsEmpty then
    FEntradaEnt.ItemIndex := -1
  else
    FEntradaEnt.ItemIndex := g.FieldORDEM.AsInteger - 1;

  FEntradaEnt.Items.Clear;
  Sis.DB.DataSet.Utils.DataSetForEach(FEntradaItemDBGridFrame.FDMemTable1,
    DataSetToEntradaItems);
end;

procedure TAppEntradaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //AltItemAction_DatasetTabSheet.Execute;
  // InsItemAction_DatasetTabSheet.Execute;
  // InsAction_DatasetTabSheet.Execute;
  // AltAction_DatasetTabSheet.Execute;
  // fdmemtable.next;
  // InsItemAction_DatasetTabSheet.Execute;

end;

procedure TAppEntradaDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(CancItemAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(FinalizAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
