unit App.UI.Form.DataSet.Pess.PerfilUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Pess.PerfilUso.Ent.Factory_u,
  App.Pess.PerfilUso.Ent, App.AppInfo, Sis.Config.SisConfig, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI, App.UI.TabSheet.DataSet.Types_u;

type
  TPerfilUsoDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    FPerfilUsoEnt: IPerfilUsoEnt;
  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer); virtual;
  end;

var
  PerfilUsoDataSetForm: TPerfilUsoDataSetForm;

implementation

{$R *.dfm}

{ TPerfilUsoDataSetForm }

constructor TPerfilUsoDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  inherited;
  FPerfilUsoEnt :=EntEdCastToPerfilUsoEnt(pEntEd);
end;

procedure TPerfilUsoDataSetForm.DoAlterar;
begin
  inherited;

end;

procedure TPerfilUsoDataSetForm.DoAtualizar(Sender: TObject);
begin
  inherited;

end;

function TPerfilUsoDataSetForm.DoInserir: boolean;
begin

end;

function TPerfilUsoDataSetForm.GetNomeArqTabView: string;
begin

end;

procedure TPerfilUsoDataSetForm.RecordToEnt;
begin
  inherited;

end;

procedure TPerfilUsoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;

end;

end.
