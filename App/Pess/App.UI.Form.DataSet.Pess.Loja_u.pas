unit App.UI.Form.DataSet.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Pess_u, Data.DB,
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

    iMemTab_Ativo: integer;
    iQ_Ativo: integer;
  protected
    function GetNomeArqTabView: string; override;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer); override;
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
var
  iAtual: integer;
begin
  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pPessLojaEnt, pPessLojaDBI,
    pModoDataSetForm, pIdPos);
  FPessLojaEnt := pPessLojaEnt;
  FPessLojaDBI := pPessLojaDBI;

  iAtual := 0;

  iMemTab_Ativo := iAtual; inc(iAtual);
  iMemTab_LOJA_ID := iAtual; inc(iAtual);
  iMemTab_TERMINAL_ID := iAtual; inc(iAtual);
  iMemTab_PESSOA_ID := iAtual; inc(iAtual);
  iMemTab_PESS_COD := iAtual; inc(iAtual);
  iMemTab_APELIDO := iAtual; inc(iAtual);
  iMemTab_NOME := iAtual; inc(iAtual);
  iMemTab_NOME_FANTASIA := iAtual; inc(iAtual);
  iMemTab_C := iAtual; inc(iAtual);
  iMemTab_I := iAtual; inc(iAtual);
  iMemTab_M := iAtual; inc(iAtual);
  iMemTab_M_UF := iAtual; inc(iAtual);
  iMemTab_EMAIL := iAtual; inc(iAtual);
  iMemTab_DT_NASC := iAtual; inc(iAtual);
  iMemTab_PESS_EDITADO_EM := iAtual; inc(iAtual);
  iMemTab_PESS_CRIADO_EM := iAtual; inc(iAtual);
  iMemTab_ENDER_ORDEM := iAtual; inc(iAtual);
  iMemTab_LOGRADOURO := iAtual; inc(iAtual);
  iMemTab_NUMERO := iAtual; inc(iAtual);
  iMemTab_COMPLEMENTO := iAtual; inc(iAtual);
  iMemTab_BAIRRO := iAtual; inc(iAtual);
  iMemTab_UF_SIGLA := iAtual; inc(iAtual);
  iMemTab_CEP := iAtual; inc(iAtual);
  iMemTab_MUNICIPIO_IBGE_ID := iAtual; inc(iAtual);
  iMemTab_MUNICIPIO_NOME := iAtual; inc(iAtual);
  iMemTab_DDD := iAtual; inc(iAtual);
  iMemTab_FONE1 := iAtual; inc(iAtual);
  iMemTab_FONE2 := iAtual; inc(iAtual);
  iMemTab_FONE3 := iAtual; inc(iAtual);
  iMemTab_CONTATO := iAtual; inc(iAtual);
  iMemTab_REFERENCIA := iAtual; inc(iAtual);
  iMemTab_ENDER_CRIADO_EM := iAtual; inc(iAtual);
  iMemTab_ENDER_ALTERADO_EM := iAtual; inc(iAtual);

  iQ_Ativo := 31;
end;

function TAppPessLojaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'App\Config\Ambiente\tabview.config.ambi.pess.loja.csv';
  Result := sNomeArq;
end;

procedure TAppPessLojaDataSetForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
begin
  inherited;
  FDMemTable.Fields[iMemTab_Ativo].AsBoolean := Q.Fields[iQ_Ativo].AsBoolean;
end;

procedure TAppPessLojaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//
end;

end.
