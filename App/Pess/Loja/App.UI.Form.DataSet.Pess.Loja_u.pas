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
  App.Ent.DBI, App.Pess.Loja.Ent.Factory_u, App.AppObj;

type
  TAppPessLojaDataSetForm = class(TAppPessDataSetForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPessLojaEnt: IPessLojaEnt;
    FPessLojaDBI: IPessLojaDBI;

    iT_Selecionado: integer;
    iQ_Selecionado: integer;

    FLojaIdUltima: integer;

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
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pAppObj: IAppObj); override;
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
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pAppObj: IAppObj);
begin
  FLojaIdUltima := 0;
  FPessLojaEnt := EntEdCastToPessLojaEnt(pEntEd);
  FPessLojaDBI := EntDBICastToPessLojaDBI(pEntDBI);

  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI,
    pModoDataSetForm, pIdPos, pAppObj);

  AtualizaAposEd := True;
  iT_Selecionado := 0;
  iT_PESSOA_ID := 1;
  iT_LOJA_ID := 2;
  iT_TERMINAL_ID := 3;
  iT_PESS_COD := 4;
  iT_NOME := 5;
  iT_NOME_FANTASIA := 6;
  iT_APELIDO := 7;

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

  iQ_Selecionado := iQ_PESS_ENDER_ULTIMO_INDEX + 1;
end;

procedure TAppPessLojaDataSetForm.DoAntesAtualizar;
begin
  inherited;
  FLojaIdUltima := FDMemTable.Fields[iT_Loja_Id].AsInteger

end;

procedure TAppPessLojaDataSetForm.DoAposAtualizar;
var
  bResultado: boolean;
begin
  inherited;
  bResultado := FDMemTable.locate('LOJA_ID', FLojaIdUltima, []);
end;

procedure TAppPessLojaDataSetForm.EntToRecord;
begin
  inherited;
  FDMemTable.Fields[iT_Selecionado].AsBoolean := FPessLojaEnt.Selecionado;
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
{$IFDEF DEBUG}
var
  S: string;
{$ENDIF}
begin
{$IFDEF DEBUG}
  s := FDMemTable.Fields[iT_Selecionado].FieldName;
  s := q.Fields[iQ_Selecionado].FieldName;
{$ENDIF}
  inherited;

  FDMemTable.Fields[iT_Selecionado].AsBoolean := q.Fields[iQ_Selecionado].AsBoolean;
end;

procedure TAppPessLojaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //AltAction_DatasetTabSheet.Execute;
  //
end;

end.
