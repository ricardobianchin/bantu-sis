unit App.UI.Form.DataSet.Config.Ambi.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Config.Amb.Loja.Ent.Factory_u,
  App.Config.Amb.Loja.UI.Factory_u, Sis.DB.DBTypes, App.Pess.Loja.Ent,
  App.AppInfo, Sis.Config.SisConfig, Sis.UI.IO.Output, App.Pess.Loja.DBI,
  Sis.UI.IO.Output.ProcessLog, Sis.Usuario;

type
  TConfigAmbiLojaDataSetForm = class(TTabSheetDataSetBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPessLojaEnt: IPessLojaEnt;
    FPessLojaDBI: IPessLojaDBI;
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
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pPessLojaEnt: IPessLojaEnt; pPessLojaDBI: IPessLojaDBI;
      pModoForm: TModoForm; pIdPos: integer); reintroduce;
  end;

var
  ConfigAmbiLojaDataSetForm: TConfigAmbiLojaDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.DB.Factory;

constructor TConfigAmbiLojaDataSetForm.Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pPessLojaEnt: IPessLojaEnt; pPessLojaDBI: IPessLojaDBI;
      pModoForm: TModoForm; pIdPos: integer);
begin
  FPessLojaEnt := pPessLojaEnt;
  FPessLojaDBI := pPessLojaDBI;

  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pPessLojaEnt, pPessLojaDBI,
    pModoForm, pIdPos);
end;

procedure TConfigAmbiLojaDataSetForm.DoAlterar;
begin
  inherited;

end;

procedure TConfigAmbiLojaDataSetForm.DoAtualizar(Sender: TObject);
begin
end;

function TConfigAmbiLojaDataSetForm.DoInserir: boolean;
begin

end;

procedure TConfigAmbiLojaDataSetForm.DoLer;
begin
  inherited;

end;

procedure TConfigAmbiLojaDataSetForm.EntToRecord;
begin
  inherited;

end;

function TConfigAmbiLojaDataSetForm.GetNomeArqTabView: string;
begin

end;

procedure TConfigAmbiLojaDataSetForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
begin
  inherited;

end;

procedure TConfigAmbiLojaDataSetForm.RecordToEnt;
begin
  inherited;

end;

procedure TConfigAmbiLojaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);

end;

procedure TConfigAmbiLojaDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;

end;

end.
