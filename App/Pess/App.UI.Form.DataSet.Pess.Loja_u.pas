unit App.UI.Form.DataSet.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.DataSet.Pess_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Pess.Loja.DBI, App.Pess.Loja.Ent, App.AppInfo,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.Usuario, App.UI.TabSheet.DataSet.Types_u;

type
  TAppPessLojaDataSetForm = class(TAppPessDataSetForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPessLojaEnt: IPessLojaEnt;
    FPessLojaDBI: IPessLojaDBI;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pPessLojaEnt: IPessLojaEnt; pPessLojaDBI: IPessLojaDBI;
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer); reintroduce;
  end;

var
  AppPessLojaDataSetForm: TAppPessLojaDataSetForm;

implementation

{$R *.dfm}

constructor TAppPessLojaDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pPessLojaEnt: IPessLojaEnt;
  pPessLojaDBI: IPessLojaDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer);
begin
  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pPessLojaEnt, pPessLojaDBI,
    pModoDataSetForm, pIdPos);
  FPessLojaEnt := pPessLojaEnt;
  FPessLojaDBI := pPessLojaDBI;
end;

procedure TAppPessLojaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//
end;

end.
