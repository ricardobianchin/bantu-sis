unit App.UI.Form.DataSet.Acesso.PerfilDeUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Acesso.PerfilDeUso.Ent.Factory_u,
  App.Acesso.PerfilDeUso.Ent, App.AppInfo, Sis.Config.SisConfig, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI, App.UI.TabSheet.DataSet.Types_u;

type
  TPerfilDeUsoDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    FPerfilDeUsoEnt: IPerfilDeUsoEnt;
  protected
    function GetNomeArqTabView: string; override;

    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

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
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews +
    'App\Config\Ambiente\tabview.config.ambi.pess.loja.csv';
  Result := sNomeArq;
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
