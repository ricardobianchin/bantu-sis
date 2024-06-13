unit App.UI.Form.DataSet.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Pess_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Pess.Loja.DBI, App.Pess.Loja.Ent, App.AppInfo,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.Usuario, App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed,
  App.Ent.DBI, App.Pess.Ent.Factory_u;

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
    procedure QToMemTable(q: TDataSet); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer); override;
  end;

var
  AppPessLojaDataSetForm: TAppPessLojaDataSetForm;

implementation

{$R *.dfm}

constructor TAppPessLojaDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  FPessLojaEnt := EntEdCastToPessLojaEnt(pEntEd);
  FPessLojaDBI := EntDBICastToPessLojaDBI(pEntDBI);

  iMemTab_Ativo := 0;
  iMemTab_PESSOA_ID := 1;
  iMemTab_LOJA_ID := 2;
  iMemTab_TERMINAL_ID := 3;
  iMemTab_PESS_COD := 4;
  iMemTab_NOME := 5;
  iMemTab_NOME_FANTASIA := 6;
  iMemTab_APELIDO := 7;
  iMemTab_C := 8;
  iMemTab_I := 9;
  iMemTab_M := 10;
  iMemTab_EMAIL := 11;
  iMemTab_PESS_CRIADO_EM := 12;
  iMemTab_PESS_ALTERADO_EM := 13;
  iMemTab_LOGRADOURO := 14;
  iMemTab_NUMERO := 15;
  iMemTab_COMPLEMENTO := 16;
  iMemTab_BAIRRO := 17;
  iMemTab_MUNICIPIO_NOME := 18;
  iMemTab_UF_SIGLA := 19;
  iMemTab_CEP := 20;
  iMemTab_DDD := 21;
  iMemTab_FONE1 := 22;
  iMemTab_FONE2 := 23;
  iMemTab_FONE3 := 24;
  iMemTab_CONTATO := 25;
  iMemTab_REFERENCIA := 26;
  iMemTab_MUNICIPIO_IBGE_ID := 27;
  iMemTab_ENDER_CRIADO_EM := 28;
  iMemTab_ENDER_ALTERADO_EM := 29;

  iQ_Ativo := 31;
  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI,
    pModoDataSetForm, pIdPos);
end;

function TAppPessLojaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews +
    'App\Config\Ambiente\tabview.config.ambi.pess.loja.csv';
  Result := sNomeArq;
end;

procedure TAppPessLojaDataSetForm.QToMemTable(q: TDataSet);
begin
  inherited;
  FDMemTable.Fields[iMemTab_Ativo].AsBoolean := q.Fields[iQ_Ativo].AsBoolean;
end;

procedure TAppPessLojaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //
end;

end.
