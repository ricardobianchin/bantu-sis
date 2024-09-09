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

    iT_PerfilDeUsoDescrs: integer;
    iQ_PerfilDeUsoDescrs: integer;
  protected
    function GetNomeArqTabView: string; override;
    procedure QToMemTable(q: TDataSet); override;
    function PergEd: boolean; override;
    procedure ToolBar1CrieBotoes; override;

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

uses App.Pess.UI.Factory_u, App.Acesso.Funcionario.UI.Factory_u;

{ TAppPessFuncionarioDataSetForm }

constructor TAppPessFuncionarioDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  FPessFuncionarioEnt := EntEdCastToPessFuncionarioEnt(pEntEd);
  FPessFuncionarioDBI := EntDBICastToPessFuncionarioDBI(pEntDBI);

  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI,
    pModoDataSetForm, pIdPos);

//  AtualizaAposEd := True;
//  iT_Selecionado := 0;
  iT_PESSOA_ID := 0;
  iT_LOJA_ID := 1;
  iT_TERMINAL_ID := 2;
  iT_PESS_COD := 3;

  iT_NOME := 4;
  iT_NOME_FANTASIA := 5;
  iT_APELIDO := 6;

  iT_PerfilDeUsoDescrs := 7;

  iT_GENERO_ID := 8;
  iT_GENERO_DESCR := 9;
  iT_ESTADO_CIVIL_ID := 10;
  iT_ESTADO_CIVIL_DESCR := 11;

  iT_C := 12;
  iT_I := 13;
  iT_M := 14;
  iT_M_UF := 15;

  iT_EMAIL := 16;
  iT_DT_NASC := 17;
  iT_ATIVO := 18;

  iT_PESS_CRIADO_EM := 19;
  iT_PESS_ALTERADO_EM := 20;

  iT_ENDER_ORDEM := 21;
  iT_LOGRADOURO := 22;
  iT_NUMERO := 23;
  iT_COMPLEMENTO := 24;
  iT_BAIRRO := 25;
  iT_MUNICIPIO_NOME := 26;
  iT_UF_SIGLA := 27;
  iT_CEP := 28;
  iT_DDD := 29;
  iT_FONE1 := 30;
  iT_FONE2 := 31;
  iT_FONE3 := 32;
  iT_CONTATO := 33;
  iT_REFERENCIA := 34;
  iT_MUNICIPIO_IBGE_ID := 35;

  iT_ENDER_CRIADO_EM := 36;
  iT_ENDER_ALTERADO_EM := 37;

  iT_ENDER_PRIMEIRO_CAMPO := iT_ENDER_ORDEM;

  iQ_PerfilDeUsoDescrs := iQ_PESS_ENDER_ULTIMO_INDEX + 1;
end;

function TAppPessFuncionarioDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews +
    'App\Retag\Acesso\tabview.retag.acesso.pess.funcionario.csv';

  Result := sNomeArq;
end;

function TAppPessFuncionarioDataSetForm.PergEd: boolean;
begin

end;

procedure TAppPessFuncionarioDataSetForm.QToMemTable(q: TDataSet);
begin
  inherited;
  FDMemTable.Fields[iT_PerfilDeUsoDescrs].AsString := q.Fields[iQ_PerfilDeUsoDescrs].AsString.Trim;
end;

procedure TAppPessFuncionarioDataSetForm.ShowTimer_BasFormTimer(
  Sender: TObject);
begin
  inherited;
//
end;

procedure TAppPessFuncionarioDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
//  ToolBarAddButton(OpcaoSisAction_PerfilDeUsoDataSetForm, TitToolBar1_BasTabSheet);
end;

end.
