unit App.UI.Form.DataSet.Pess.Cliente_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Pess_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Pess.Cliente.DBI, App.Pess.Cliente.Ent,
  App.AppInfo,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.Usuario, App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed,
  App.Ent.DBI, App.Pess.Cliente.Ent.Factory_u;

type
  TAppPessClienteDataSetForm = class(TAppPessDataSetForm)
  private
    { Private declarations }
    FPessClienteEnt: IPessClienteEnt;
    FPessClienteDBI: IPessClienteDBI;

    // FClienteIdUltima: integer;

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
  AppPessClienteDataSetForm: TAppPessClienteDataSetForm;

implementation

{$R *.dfm}

uses App.Pess.UI.Factory_u, App.Acesso.Cliente.UI.Factory_u;

{ TAppPessClienteDataSetForm }

constructor TAppPessClienteDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
begin
  inherited;
  // FClienteIdUltima := 0;

  FPessClienteEnt := EntEdCastToPessClienteEnt(pEntEd);
  FPessClienteDBI := EntDBICastToPessClienteDBI(pEntDBI);

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
  iT_C := 7;
  iT_I := 8;
  iT_M := 9;
  iT_M_UF := 10;
  iT_EMAIL := 11;
  iT_DT_NASC := 12;
  iT_ATIVO := 13;
  iT_PESS_CRIADO_EM := 14;
  iT_PESS_ALTERADO_EM := 15;
  iT_ENDER_ORDEM := 16;
  iT_LOGRADOURO := 17;
  iT_NUMERO := 18;
  iT_COMPLEMENTO := 19;
  iT_BAIRRO := 20;
  iT_MUNICIPIO_NOME := 21;
  iT_UF_SIGLA := 22;
  iT_CEP := 23;
  iT_DDD := 24;
  iT_FONE1 := 25;
  iT_FONE2 := 26;
  iT_FONE3 := 27;
  iT_CONTATO := 28;
  iT_REFERENCIA := 29;
  iT_MUNICIPIO_IBGE_ID := 30;
  iT_ENDER_CRIADO_EM := 31;
  iT_ENDER_ALTERADO_EM := 32;
  iT_ENDER_PRIMEIRO_CAMPO := iT_ENDER_ORDEM;

//  iQ_Selecionado := iQ_PESS_ENDER_ULTIMO_INDEX + 1;

end;

procedure TAppPessClienteDataSetForm.DoAntesAtualizar;
begin
  inherited;
//  FClienteIdUltima := FDMemTable.Fields[iT_Cliente_Id].AsInteger

end;

procedure TAppPessClienteDataSetForm.DoAposAtualizar;
//var
//  bResultado: boolean;
begin
  inherited;
//  bResultado := FDMemTable.locate('Cliente_ID', FClienteIdUltima, []);
end;

procedure TAppPessClienteDataSetForm.EntToRecord;
begin
  inherited;
//  FDMemTable.Fields[iT_Selecionado].AsBoolean := FPessClienteEnt.Selecionado;
end;

function TAppPessClienteDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews +
    'App\Retag\Est\Ven\tabview.config.ambi.pess.cliente';
  Result := sNomeArq;
end;

function TAppPessClienteDataSetForm.PergEd: boolean;
begin
  Result := ClientePerg(nil, AppInfo, FPessClienteEnt, FPessClienteDBI);
end;

procedure TAppPessClienteDataSetForm.QToMemTable(q: TDataSet);
//{$IFDEF DEBUG}
//var
//  S: string;
//{$ENDIF}
begin
//{$IFDEF DEBUG}
//  s := FDMemTable.Fields[iT_Selecionado].FieldName;
//  s := q.Fields[iQ_Selecionado].FieldName;
//{$ENDIF}
  inherited;

//  FDMemTable.Fields[iT_Selecionado].AsBoolean := q.Fields[iQ_Selecionado].AsBoolean;
end;

end.
