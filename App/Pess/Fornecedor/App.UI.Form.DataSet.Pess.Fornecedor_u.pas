unit App.UI.Form.DataSet.Pess.Fornecedor_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Pess_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, App.Pess.Fornecedor.DBI, App.Pess.Fornecedor.Ent,
  Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed, App.Ent.DBI,
  App.UI.TabSheet.DataSet.Types_u, App.AppObj, Vcl.StdCtrls;

type
  TAppPessFornecedorDataSetForm = class(TAppPessDataSetForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPessFornecedorEnt: IPessFornecedorEnt;
    FPessFornecedorDBI: IPessFornecedorDBI;
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
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
    { Public declarations }
  end;

var
  AppPessFornecedorDataSetForm: TAppPessFornecedorDataSetForm;

implementation

{$R *.dfm}

uses App.Acesso.Fornecedor.UI.Factory_u, App.Pess.Fornecedor.Ent.Factory_u;

{ TAppPessFornecedorDataSetForm }

constructor TAppPessFornecedorDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  FPessFornecedorEnt := EntEdCastToPessFornecedorEnt(pEntEd);
  FPessFornecedorDBI := EntDBICastToPessFornecedorDBI(pEntDBI);

  inherited Create(AOwner, pFormClassNamesSL, pUsuarioLog,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI,
    pModoDataSetForm, pIdPos, pAppObj);

  // AtualizaAposEd := True;
  // iT_Selecionado := 0;
  iT_PESSOA_ID := 0;
  iT_LOJA_ID := 1;
  iT_TERMINAL_ID := 2;
  iT_PESS_COD := 3;

  iT_NOME := 4;
  iT_NOME_FANTASIA := 5;
  iT_APELIDO := 6;

  iT_GENERO_ID := 7;
  iT_GENERO_DESCR := 8;
  iT_ESTADO_CIVIL_ID := 9;
  iT_ESTADO_CIVIL_DESCR := 10;

  iT_C := 11;
  iT_I := 12;
  iT_M := 13;
  iT_M_UF := 14;

  iT_EMAIL := 15;
  iT_DT_NASC := 16;
  iT_ATIVO := 17;

  iT_PESS_CRIADO_EM := 18;
  iT_PESS_ALTERADO_EM := 19;

  iT_ENDER_ORDEM := 20;
  iT_LOGRADOURO := 21;
  iT_NUMERO := 22;
  iT_COMPLEMENTO := 23;
  iT_BAIRRO := 24;
  iT_MUNICIPIO_NOME := 25;
  iT_UF_SIGLA := 26;
  iT_CEP := 27;
  iT_DDD := 28;
  iT_FONE1 := 29;
  iT_FONE2 := 30;
  iT_FONE3 := 31;
  iT_CONTATO := 32;
  iT_REFERENCIA := 33;
  iT_MUNICIPIO_IBGE_ID := 34;
  iT_ENDER_CRIADO_EM := 35;
  iT_ENDER_ALTERADO_EM := 36;

  iT_ENDER_PRIMEIRO_CAMPO := iT_ENDER_ORDEM;

  // iQ_Selecionado := iQ_PESS_ENDER_ULTIMO_INDEX + 1;

end;

procedure TAppPessFornecedorDataSetForm.DoAntesAtualizar;
begin
  inherited;
  // FFornecedorIdUltima := FDMemTable.Fields[iT_Fornecedor_Id].AsInteger
end;

procedure TAppPessFornecedorDataSetForm.DoAposAtualizar;
// var
// bResultado: boolean;
begin
  inherited;
  // bResultado := FDMemTable.locate('Fornecedor_ID', FFornecedorIdUltima, []);
end;

procedure TAppPessFornecedorDataSetForm.EntToRecord;
begin
  inherited;
  // FDMemTable.Fields[iT_Selecionado].AsBoolean := FPessFornecedorEnt.Selecionado;
end;

function TAppPessFornecedorDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Ent\tabview.config.ambi.pess.fornecedor.csv';
  Result := sNomeArq;
end;

function TAppPessFornecedorDataSetForm.PergEd: boolean;
begin
  Result := FornecedorPerg(nil, FPessFornecedorEnt, FPessFornecedorDBI, AppObj);
end;

procedure TAppPessFornecedorDataSetForm.QToMemTable(q: TDataSet);
// {$IFDEF DEBUG}
// var
// S: string;
// {$ENDIF}
begin
  // {$IFDEF DEBUG}
  // s := FDMemTable.Fields[iT_Selecionado].FieldName;
  // s := q.Fields[iQ_Selecionado].FieldName;
  // {$ENDIF}
  inherited;

  // FDMemTable.Fields[iT_Selecionado].AsBoolean := q.Fields[iQ_Selecionado].AsBoolean;
end;

procedure TAppPessFornecedorDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //InsAction_DatasetTabSheet.Execute;
//  AltAction_DatasetTabSheet
end;

end.
