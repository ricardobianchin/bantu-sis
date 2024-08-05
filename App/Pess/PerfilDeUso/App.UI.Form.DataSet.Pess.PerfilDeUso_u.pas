unit App.UI.Form.DataSet.Pess.PerfilDeUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Pess.PerfilDeUso.Ent.Factory_u,
  App.Pess.PerfilDeUso.Ent, App.AppInfo, Sis.Config.SisConfig, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI, App.UI.TabSheet.DataSet.Types_u;

type
  TPerfilDeUsoDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    FPerfilDeUsoEnt: IPerfilDeUsoEnt;
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
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer); override;
  end;

var
  PerfilDeUsoDataSetForm: TPerfilDeUsoDataSetForm;

implementation

{$R *.dfm}

{ TPerfilDeUsoDataSetForm }

constructor TPerfilDeUsoDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  inherited;
  FPerfilDeUsoEnt :=EntEdCastToPerfilDeUsoEnt(pEntEd);
end;

procedure TPerfilDeUsoDataSetForm.DoAlterar;
begin
  inherited;

end;

procedure TPerfilDeUsoDataSetForm.DoAtualizar(Sender: TObject);
begin
  inherited;

end;

function TPerfilDeUsoDataSetForm.DoInserir: boolean;
begin

end;

function TPerfilDeUsoDataSetForm.GetNomeArqTabView: string;
begin

end;

procedure TPerfilDeUsoDataSetForm.RecordToEnt;
begin
  inherited;

end;

procedure TPerfilDeUsoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;

end;

end.
