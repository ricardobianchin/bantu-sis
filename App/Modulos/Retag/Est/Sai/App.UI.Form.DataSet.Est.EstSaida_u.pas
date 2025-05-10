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
  App.Retag.Est.EstSaida.Ent, App.Retag.Est.EstSaida.DBI;

type
  TAppEstSaidaDataSetForm = class(TAppEstDataSetForm)
    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FEstSaidaEnt: IEstSaidaEnt;
    FEstSaidaDBI: IEstSaidaDBI;
  protected
    procedure EstLeRegEInsere(q: TDataSet; pRecNo: integer); override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;

    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure CrieFiltroFrame; override;
    function PergEd: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  AppEstSaidaDataSetForm: TAppEstSaidaDataSetForm;

implementation

{$R *.dfm}

uses App.UI.Frame.Bas.EstFiltro_u, Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  App.Retag.Est.Factory, Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg,
  App.UI.Form.Retag.Excl_u, Sis.DB.DataSet.Utils, Sis.Entities.Types, Sis.Types,
  Sis.UI.Controls.Utils, Sis.Sis.Constants;

{ TAppEstSaidaDataSetForm }

procedure TAppEstSaidaDataSetForm.AltAction_DatasetTabSheetExecute(
  Sender: TObject);
begin
//  inherited;

end;

procedure TAppEstSaidaDataSetForm.AtuAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  // valores dth so sao lidos aqui pra poder testar
  // serao depois relidos por ForEach
  DtHIni: TDateTime;
  DtHFin: TDateTime;
  sMens: string;
begin
  EstFiltroFrame.DtHFaixaFrame.DtIniFrame.PreencheDtH(DtHIni, sMens);
  if sMens <> '' then
  begin // a mens de erro ja foi exibida dentro do dthframe
    exit;
  end;

  EstFiltroFrame.DtHFaixaFrame.DtFinFrame.PreencheDtH(DtHFin, sMens);
  if sMens <> '' then
  begin // a mens de erro ja foi exibida dentro do dthframe
    exit;
  end;

  if DtHIni >= DtHFin then
  begin
    EstFiltroFrame.ErroLabel.Caption :=
      'A data final deve ser maior do que a inicial';
  end;

  inherited;

end;

constructor TAppEstSaidaDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  inherited;
  FEstSaidaEnt := EntEdCastToEstSaidaEnt(pEntEd);
  FEstSaidaDBI := EntDBICastToEstSaidaDBI(pEntDBI);
end;

procedure TAppEstSaidaDataSetForm.CrieFiltroFrame;
begin
  inherited;
  EstFiltroFrame := TEstFiltroFrame.Create(Self, DoAtualizar);
  EstFiltroFrame.Align := alBottom;

//{$IFDEF DEBUG}
//  SetNameToHint(Self);
//{$ENDIF}
  // TitToolBar1_BasTabSheet

  // TitToolPanel_BasTabSheet.Height := TitToolPanel_BasTabSheet.Height +
  // EstFiltroFrame.Height;
  // TitToolBar1_BasTabSheet.Top := EstFiltroFrame.Top + EstFiltroFrame.Height;
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
  FDMemTable.Fields[6 { EST_SAIDA_MOTIVO_ID } ].AsInteger := FEstSaidaEnt.SaidaMotivoId; //
  FDMemTable.Fields[7 { EST_SAIDA_MOTIVO_DESCR } ].AsString := FEstSaidaEnt.SaidaMotivoDescr; //; //
  FDMemTable.Fields[8 { FINALIZADO } ].AsBoolean :=  FEstSaidaEnt.Finalizado; //;
  FDMemTable.Fields[9 { FINALIZADO_EM } ].AsDateTime := FEstSaidaEnt.FinalizadoEm; //
  FDMemTable.Fields[10 { CANCELADO } ].AsBoolean := FEstSaidaEnt.Cancelado; //
  FDMemTable.Fields[11 { CANCELADO_EM } ].AsDateTime := FEstSaidaEnt.CanceladoEm; //
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

function TAppEstSaidaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Sai\tabview.app.retag.est.sai.csv';

  Result := sNomeArq;
end;

function TAppEstSaidaDataSetForm.PergEd: boolean;
var
  rDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  oDBConnection := DBConnectionCreate('TAppEstSaidaDataSetForm.PergEd.conn',
    AppObj.SisConfig, rDBConnectionParams, ProcessLog, Output);

  Result := EstSaidaPerg(nil, AppObj, FEstSaidaEnt, FEstSaidaDBI,
    oDBConnection);
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
  FEstSaidaEnt.SaidaMotivoId := FDMemTable.Fields[6 { EST_SAIDA_MOTIVO_ID } ].AsInteger; //
  FEstSaidaEnt.SaidaMotivoDescr := FDMemTable.Fields[7 { EST_SAIDA_MOTIVO_DESCR } ].AsString; //
  FEstSaidaEnt.Finalizado := FDMemTable.Fields[8 { FINALIZADO } ].AsBoolean; //;
  FEstSaidaEnt.FinalizadoEm := FDMemTable.Fields[9 { FINALIZADO_EM } ].AsDateTime; //
  FEstSaidaEnt.Cancelado := FDMemTable.Fields[10 { CANCELADO } ].AsBoolean; //
  FEstSaidaEnt.CanceladoEm := FDMemTable.Fields[11 { CANCELADO_EM } ].AsDateTime; //
//  FDMemTable.Fields[12 { CRIADO_POR_ID } ].AsInteger := 0;
//  FDMemTable.Fields[13 { CRIADO_POR_APELIDO } ].AsString := '';
//  FDMemTable.Fields[14 { CANCELADO_POR_ID } ].AsInteger := 0; //
//  FDMemTable.Fields[15 { CANCELADO_POR_APELIDO } ].AsString := ''; //
//  FDMemTable.Fields[16 { FINALIZADO_POR_ID } ].AsInteger := 0; //
//  FDMemTable.Fields[17 { FINALIZADO_POR_APELIDO } ].AsString := ''; //
end;

procedure TAppEstSaidaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  InsAction_DatasetTabSheet.Execute;
end;

procedure TAppEstSaidaDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
