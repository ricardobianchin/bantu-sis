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

    iT_Ativo: integer;
    iQ_Ativo: integer;
  protected
    function GetNomeArqTabView: string; override;
    procedure QToMemTable(q: TDataSet); override;
    procedure RecordToEnt; override;
    procedure EntToRecord; override;
    function PergEd: boolean; override;
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

uses App.Pess.UI.Factory_u;

constructor TAppPessLojaDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  FPessLojaEnt := EntEdCastToPessLojaEnt(pEntEd);
  FPessLojaDBI := EntDBICastToPessLojaDBI(pEntDBI);

  iT_Ativo := 0;
  iT_PESSOA_ID := 1;
  iT_LOJA_ID := 2;
  iT_TERMINAL_ID := 3;
  iT_PESS_COD := 4;
  iT_NOME := 5;
  iT_NOME_FANTASIA := 6;
  iT_APELIDO := 7;
  iT_C := 8;
  iT_I := 9;
  iT_M := 10;
  iT_EMAIL := 11;
  iT_DT_NASC := 12;
  iT_PESS_CRIADO_EM := 13;
  iT_PESS_ALTERADO_EM := 14;
  iT_ENDER_ORDEM := 15;
  iT_LOGRADOURO := 16;
  iT_NUMERO := 17;
  iT_COMPLEMENTO := 18;
  iT_BAIRRO := 19;
  iT_MUNICIPIO_NOME := 20;
  iT_UF_SIGLA := 21;
  iT_CEP := 22;
  iT_DDD := 23;
  iT_FONE1 := 24;
  iT_FONE2 := 25;
  iT_FONE3 := 26;
  iT_CONTATO := 27;
  iT_REFERENCIA := 28;
  iT_MUNICIPIO_IBGE_ID := 29;
  iT_ENDER_CRIADO_EM := 30;
  iT_ENDER_ALTERADO_EM :=31;
  iT_ENDER_PRIMEIRO_CAMPO := iT_ENDER_ORDEM;

  iQ_Ativo := 31;

  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI,
    pModoDataSetForm, pIdPos);
end;

procedure TAppPessLojaDataSetForm.EntToRecord;
begin
  inherited;
  FDMemTable.Fields[iT_Ativo].AsBoolean := FPessLojaEnt.Ativo;
end;

function TAppPessLojaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews +
    'App\Config\Ambiente\tabview.config.ambi.pess.loja.csv';
  Result := sNomeArq;
end;

function TAppPessLojaDataSetForm.PergEd: boolean;
begin
  Result := PessLojaPerg(nil, AppInfo, FPessLojaEnt, FPessLojaDBI);
end;

procedure TAppPessLojaDataSetForm.QToMemTable(q: TDataSet);
begin
  inherited;
  FDMemTable.Fields[iT_Ativo].AsBoolean := q.Fields[iQ_Ativo].AsBoolean;
end;

procedure TAppPessLojaDataSetForm.RecordToEnt;
begin
  inherited;
//  FPessLojaEnt.Ativo := FDMemTable.Fields[iT_Ativo].AsBoolean;
end;

procedure TAppPessLojaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  AltAction_DatasetTabSheet.Execute;
  //
end;

end.
