unit App.UI.Form.DataSet.Pess.Funcionario_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Pess_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Pess.Funcionario.DBI, App.Pess.Funcionario.Ent, App.AppInfo,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.Usuario, App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed,
  App.Ent.DBI, App.Pess.Funcionario.Ent.Factory_u;

type
  TAppPessFuncionarioDataSetForm = class(TAppPessDataSetForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPessFuncionarioEnt: IPessFuncionarioEnt;
    FPessFuncionarioDBI: IPessFuncionarioDBI;

  protected
    function GetNomeArqTabView: string; override;
    procedure QToMemTable(q: TDataSet); override;
    procedure EntToRecord; override;
    function PergEd: boolean; override;

    procedure DoAntesAtualizar; override;
    procedure DoAposAtualizar; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer); override;
  end;

var
  AppPessFuncionarioDataSetForm: TAppPessFuncionarioDataSetForm;

implementation

{$R *.dfm}

uses App.Pess.UI.Factory_u;

{ TAppPessFuncionarioDataSetForm }

constructor TAppPessFuncionarioDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  inherited;

end;

procedure TAppPessFuncionarioDataSetForm.DoAntesAtualizar;
begin
  inherited;

end;

procedure TAppPessFuncionarioDataSetForm.DoAposAtualizar;
begin
  inherited;

end;

procedure TAppPessFuncionarioDataSetForm.EntToRecord;
begin
  inherited;

end;

function TAppPessFuncionarioDataSetForm.GetNomeArqTabView: string;
begin

end;

function TAppPessFuncionarioDataSetForm.PergEd: boolean;
begin

end;

procedure TAppPessFuncionarioDataSetForm.QToMemTable(q: TDataSet);
begin
  inherited;

end;

procedure TAppPessFuncionarioDataSetForm.ShowTimer_BasFormTimer(
  Sender: TObject);
begin
  inherited;
//
end;

end.
