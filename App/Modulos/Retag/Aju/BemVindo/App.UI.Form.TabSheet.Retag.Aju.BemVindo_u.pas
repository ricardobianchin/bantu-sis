unit App.UI.Form.TabSheet.Retag.Aju.BemVindo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, App.AppInfo, Sis.DB.DBTypes, Vcl.Buttons,
  App.DB.Term.Carga.Frame_u,
  Sis.UI.Form.Bas.TabSheet_u, Sis.Config.SisConfig,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario;

type
  TRetagAjuBemVindoForm = class(TTabSheetAppBasForm)
    SaudacaoLabel: TLabel;
    DireitaPanel: TPanel;
    ProdutosGroupBox: TGroupBox;
    ProdQtdTitLabel: TLabel;
    ProdQtdLabel: TLabel;
    AtualizarAction: TAction;
    DireitaBasePanel: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    Label2: TLabel;
    TerminaisGroupBox: TGroupBox;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AtualizarActionExecute(Sender: TObject);
  private
    { Private declarations }
    FTermCargaFrameFrame: TTermCargaFrameFrame;

    ProdQtd: integer;
    procedure InicieControles;
    procedure InicieSaudacao;
  protected
    function GetTitulo: string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput); override;
  end;

var
  RetagAjuBemVindoForm: TRetagAjuBemVindoForm;

implementation

{$R *.dfm}

uses Sis.Types.Dates, App.DB.Utils, Sis.DB.Factory, Data.DB, Sis.Sis.Constants;

{ TRetagAjuBemVindoForm }

procedure TRetagAjuBemVindoForm.AtualizarActionExecute(Sender: TObject);
var
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  q: TDataSet;
  sSql: string;
begin
  inherited;
  // SisConfig.

  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppInfo, SisConfig);

  oDBConnection := DBConnectionCreate('Retag.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  sSql := 'SELECT PROD_RECORD_COUNT_RET FROM EST_STAT_PA.STAT_GET;';
  oDBConnection.Abrir;
  try
    oDBConnection.QueryDataSet(sSql, q);
    ProdQtd := q.Fields[0].AsInteger;
    ProdQtdLabel.Caption := ProdQtd.ToString;
    // if ProdQtd = 0 then
    // ProdQtdZeroNotifyItemPanel.Visible := True;
  finally
    oDBConnection.Fechar;
  end;
end;

constructor TRetagAjuBemVindoForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput);
begin
  inherited;
//  FTermCargaFrameFrame := TTermCargaFrameFrame.Create(TerminaisGroupBox);
end;

procedure TRetagAjuBemVindoForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  AtualizarAction.Execute;
end;

function TRetagAjuBemVindoForm.GetTitulo: string;
begin
  Result := 'Bem-Vindo';
end;

procedure TRetagAjuBemVindoForm.InicieControles;
begin
  InicieSaudacao;
end;

procedure TRetagAjuBemVindoForm.InicieSaudacao;
var
  vAgora: TDateTime;
  sCaption: string;
begin
  vAgora := Now;
  sCaption := DateTimeToSaudacao(vAgora);
  SaudacaoLabel.Caption := sCaption;
end;

procedure TRetagAjuBemVindoForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  InicieControles;
  AtualizarAction.Execute;
end;

end.
