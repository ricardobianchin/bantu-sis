unit App.UI.Form.Bas.DataSet.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Sis.Config.SisConfig, Sis.Usuario_u, Sis.Types,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario, Sis.DB.DBTypes,
  App.AppInfo, App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed, App.Ent.DBI,
  App.Pess.Ent, App.Pess.DBI, FireDAC.Comp.Client, App.AppObj;

type
  TAppPessDataSetForm = class(TTabSheetDataSetBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;

  protected
    { Protected declarations }

    iT_LOJA_ID: integer;
    iT_TERMINAL_ID: integer;
    iT_PESSOA_ID: integer;
    iT_PESS_COD: integer;
    iT_APELIDO: integer;
    iT_NOME: integer;
    iT_NOME_FANTASIA: integer;

    iT_GENERO_ID: integer;
    iT_GENERO_DESCR: integer;
    iT_ESTADO_CIVIL_ID: integer;
    iT_ESTADO_CIVIL_DESCR: integer;

    iT_C: integer;
    iT_I: integer;
    iT_M: integer;
    iT_M_UF: integer;
    iT_EMAIL: integer;
    iT_DT_NASC: integer;
    iT_ATIVO: integer;
    iT_PESS_CRIADO_EM: integer;
    iT_PESS_ALTERADO_EM: integer;
    iT_ENDER_ORDEM: integer;
    iT_LOGRADOURO: integer;
    iT_NUMERO: integer;
    iT_COMPLEMENTO: integer;
    iT_BAIRRO: integer;
    iT_UF_SIGLA: integer;
    iT_CEP: integer;
    iT_MUNICIPIO_IBGE_ID: integer;
    iT_MUNICIPIO_NOME: integer;
    iT_DDD: integer;
    iT_FONE1: integer;
    iT_FONE2: integer;
    iT_FONE3: integer;
    iT_CONTATO: integer;
    iT_REFERENCIA: integer;
    iT_ENDER_CRIADO_EM: integer;
    iT_ENDER_ALTERADO_EM: integer;

    iT_ENDER_PRIMEIRO_CAMPO: integer;

    iQ_LOJA_ID: integer;
    iQ_TERMINAL_ID: integer;
    iQ_PESSOA_ID: integer;
    iQ_APELIDO: integer;
    iQ_NOME: integer;
    iQ_NOME_FANTASIA: integer;

    iQ_GENERO_ID: integer;
    iQ_GENERO_DESCR: integer;
    iQ_ESTADO_CIVIL_ID: integer;
    iQ_ESTADO_CIVIL_DESCR: integer;

    iQ_C: integer;
    iQ_I: integer;
    iQ_M: integer;
    iQ_M_UF: integer;
    iQ_EMAIL: integer;
    iQ_DT_NASC: integer;
    iQ_ATIVO: integer;
    iQ_PESS_CRIADO_EM: integer;
    iQ_PESS_ALTERADO_EM: integer;
    iQ_ENDER_ORDEM: integer;
    iQ_LOGRADOURO: integer;
    iQ_NUMERO: integer;
    iQ_COMPLEMENTO: integer;
    iQ_BAIRRO: integer;
    iQ_UF_SIGLA: integer;
    iQ_CEP: integer;
    iQ_MUNICIPIO_IBGE_ID: integer;
    iQ_MUNICIPIO_NOME: integer;
    iQ_DDD: integer;
    iQ_FONE1: integer;
    iQ_FONE2: integer;
    iQ_FONE3: integer;
    iQ_CONTATO: integer;
    iQ_REFERENCIA: integer;
    iQ_ENDER_CRIADO_EM: integer;
    iQ_ENDER_ALTERADO_EM: integer;
    iQ_PESS_ENDER_ULTIMO_INDEX: integer;
    iQ_ENDER_PRIMEIRO_CAMPO: integer;

    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoLer; override;
    procedure DoAlterar; override;

    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
    procedure EntToRecord; override;

    procedure LeRegEInsere(q: TDataSet; pRecNo: integer); override;

    procedure QToMemTable(q: TDataSet); virtual;
    function PergEd: boolean; virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  AppPessDataSetForm: TAppPessDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.Controls.TDBGrid,
  Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Pess.Utils, Sis.DB.Factory,
  App.DB.Utils, Sis.UI.IO.Input.Perg, Sis.Types.Bool_u, App.PessEnder,
  Sis.Types.strings_u, App.Pess.Ent.Factory_u;

constructor TAppPessDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  FPessEnt := EntEdCastToPessEnt(pEntEd);
  FPessDBI := EntDBICastToPessDBI(pEntDBI);

  if FPessEnt.EnderQuantidadePermitida = TEnderQuantidadePermitida.endqtdUm then
  begin
    iQ_LOJA_ID := 0;
    iQ_TERMINAL_ID := 1;
    iQ_PESSOA_ID := 2;
    iQ_APELIDO := 3;
    iQ_NOME := 4;
    iQ_NOME_FANTASIA := 5;

    iQ_GENERO_ID := 6;
    iQ_GENERO_DESCR := 7;
    iQ_ESTADO_CIVIL_ID := 8;
    iQ_ESTADO_CIVIL_DESCR := 9;

    iQ_C := 10;
    iQ_I := 11;
    iQ_M := 12;
    iQ_M_UF := 13;

    iQ_EMAIL := 14;
    iQ_DT_NASC := 15;
    iQ_ATIVO := 16;

    iQ_PESS_CRIADO_EM := 17;
    iQ_PESS_ALTERADO_EM := 18;

    iQ_ENDER_ORDEM := 19;
    iQ_LOGRADOURO := 20;
    iQ_NUMERO := 21;
    iQ_COMPLEMENTO := 22;
    iQ_BAIRRO := 23;
    iQ_UF_SIGLA := 24;
    iQ_CEP := 25;

    iQ_MUNICIPIO_IBGE_ID := 26;
    iQ_MUNICIPIO_NOME := 27;

    iQ_DDD := 28;
    iQ_FONE1 := 29;
    iQ_FONE2 := 30;
    iQ_FONE3 := 31;
    iQ_CONTATO := 32;
    iQ_REFERENCIA := 33;
    iQ_ENDER_CRIADO_EM := 34;
    iQ_ENDER_ALTERADO_EM := 35;
    iQ_PESS_ENDER_ULTIMO_INDEX := iQ_ENDER_ALTERADO_EM;
    iQ_ENDER_PRIMEIRO_CAMPO := iQ_ENDER_ORDEM;
  end;

  inherited Create(AOwner, pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pModoDataSetForm,
    pIdPos, pAppObj);
end;

procedure TAppPessDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := PergEd;

  if not Resultado then
    exit;

  FDMemTable.Edit;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TAppPessDataSetForm.DoAtualizar(Sender: TObject);
var
  Resultado: boolean;
  aValores: variant;
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    aValores := VarArrayCreate([0, 2], varInteger);
    aValores[0] := 0;
    aValores[1] := 0;
    aValores[2] := 0;

    EntDBI.PreencherDataSet(aValores, LeRegEInsere);
  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TAppPessDataSetForm.DoInserir: boolean;
var
  Resultado: boolean;
begin
  Resultado := PergEd;

  if not Resultado then
    exit;

  FDMemTable.Append;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TAppPessDataSetForm.DoLer;
begin
  // inherited;
  EntDBI.Ler;
end;

procedure TAppPessDataSetForm.EntToRecord;
var
  sFormat: string;
  sCod: string;
  Tab: TFDMemTable;
  oEnder: IPessEnder;
  iOrdem: integer;
begin
  inherited;
  Tab := FDMemTable;

  Tab.Fields[iT_LOJA_ID].AsInteger := FPessEnt.LojaId;
  Tab.Fields[iT_TERMINAL_ID].AsInteger := FPessEnt.TerminalId;
  Tab.Fields[iT_PESSOA_ID].AsInteger := FPessEnt.Id;

  if FPessEnt.CodUsaTerminalId then
  begin
    sFormat := '%.2d-%.2d-%.7d';
    sCod := Format(sFormat, [Tab.Fields[iT_LOJA_ID].AsInteger,
      Tab.Fields[iT_TERMINAL_ID].AsInteger,
      Tab.Fields[iT_PESSOA_ID].AsInteger]);
  end
  else
  begin
    sFormat := '%.2d-%.7d';
    sCod := Format(sFormat, [Tab.Fields[iT_LOJA_ID].AsInteger,
      Tab.Fields[iT_PESSOA_ID].AsInteger]);
  end;
  Tab.Fields[iT_PESS_COD].AsString := sCod;

  Tab.Fields[iT_APELIDO].AsString := FPessEnt.Apelido;
  Tab.Fields[iT_NOME].AsString := FPessEnt.Nome;
  Tab.Fields[iT_NOME_FANTASIA].AsString := FPessEnt.NomeFantasia;
  Tab.Fields[iT_C].AsString := FPessEnt.C;
  Tab.Fields[iT_I].AsString := FPessEnt.I;
  Tab.Fields[iT_M].AsString := FPessEnt.M;
  Tab.Fields[iT_M_UF].AsString := FPessEnt.MUF;
  Tab.Fields[iT_EMAIL].AsString := FPessEnt.EMail;
  Tab.Fields[iT_DT_NASC].AsDateTime := FPessEnt.DtNasc;
  Tab.Fields[iT_ATIVO].AsBoolean := FPessEnt.Ativo;

  Tab.Fields[iT_PESS_CRIADO_EM].AsDateTime := FPessEnt.CriadoEm;
  Tab.Fields[iT_PESS_ALTERADO_EM].AsDateTime := FPessEnt.AlteradoEm;

  iOrdem := 0;
  oEnder := FPessEnt.PessEnderList[iOrdem];
  Tab.Fields[iT_ENDER_ORDEM].AsInteger := iOrdem;

  Tab.Fields[iT_LOGRADOURO].AsString := oEnder.Logradouro;
  Tab.Fields[iT_NUMERO].AsString := oEnder.Numero;
  Tab.Fields[iT_COMPLEMENTO].AsString := oEnder.Complemento;
  Tab.Fields[iT_BAIRRO].AsString := oEnder.Bairro;
  Tab.Fields[iT_UF_SIGLA].AsString := oEnder.UFSigla;
  Tab.Fields[iT_CEP].AsString := StrToOnlyDigit(oEnder.CEP);

  if oEnder.MunicipioIbgeId = '' then
    oEnder.MunicipioIbgeId := '       ';

  Tab.Fields[iT_MUNICIPIO_IBGE_ID].AsString := oEnder.MunicipioIbgeId;
  Tab.Fields[iT_MUNICIPIO_NOME].AsString := oEnder.MunicipioNome;

  Tab.Fields[iT_DDD].AsString := oEnder.DDD;
  Tab.Fields[iT_FONE1].AsString := oEnder.Fone1;
  Tab.Fields[iT_FONE2].AsString := oEnder.Fone2;
  Tab.Fields[iT_FONE3].AsString := oEnder.Fone3;

  Tab.Fields[iT_CONTATO].AsString := oEnder.Contato;
  Tab.Fields[iT_REFERENCIA].AsString := oEnder.Referencia;

  Tab.Fields[iT_ENDER_CRIADO_EM].AsDateTime := oEnder.CriadoEm;
  Tab.Fields[iT_ENDER_ALTERADO_EM].AsDateTime := oEnder.AlteradoEm;
end;

procedure TAppPessDataSetForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  I: integer;
begin
  if pRecNo = -1 then
    exit;

  FDMemTable.Append;
  QToMemTable(q);
  FDMemTable.Post;
end;

procedure TAppPessDataSetForm.QToMemTable(q: TDataSet);
var
{$IFDEF DEBUG}
  S: string;
{$ENDIF}
  Tab: TFDMemTable;
  iPessoaId: integer;
begin
  inherited;
  Tab := FDMemTable;

{$IFDEF DEBUG}
  S := Tab.Fields[iT_LOJA_ID].FieldName;
  S := Tab.Fields[iT_DT_NASC].FieldName;

  S := Tab.Fields[iT_ATIVO].FieldName;
  S := q.Fields[iQ_ATIVO].FieldName;

  S := Tab.Fields[iT_PESS_CRIADO_EM].FieldName;
  S := q.Fields[iQ_PESS_CRIADO_EM].FieldName;

  S := Tab.Fields[iT_PESS_ALTERADO_EM].FieldName;
  S := q.Fields[iQ_PESS_ALTERADO_EM].FieldName;

{$ENDIF}
  Tab.Fields[iT_LOJA_ID].AsInteger := q.Fields[iQ_LOJA_ID].AsInteger; //
  Tab.Fields[iT_TERMINAL_ID].AsInteger := q.Fields[iQ_TERMINAL_ID].AsInteger; //
  Tab.Fields[iT_PESSOA_ID].AsInteger := q.Fields[iQ_PESSOA_ID].AsInteger; //
  iPessoaId := q.Fields[iQ_PESSOA_ID].AsInteger;

  Tab.Fields[iT_PESS_COD].AsString := //
    CodsToCodAsString(q.Fields[iQ_LOJA_ID].AsInteger, //
    q.Fields[iQ_TERMINAL_ID].AsInteger, q.Fields[iQ_PESSOA_ID].AsInteger, //
    FPessEnt.CodUsaTerminalId); //

  Tab.Fields[iT_APELIDO].AsString := q.Fields[iQ_APELIDO].AsString; //
  Tab.Fields[iT_NOME].AsString := q.Fields[iQ_NOME].AsString; //
  Tab.Fields[iT_NOME_FANTASIA].AsString := q.Fields[iQ_NOME_FANTASIA].AsString;
  //
  Tab.Fields[iT_C].AsString := q.Fields[iQ_C].AsString; //
  Tab.Fields[iT_I].AsString := q.Fields[iQ_I].AsString; //
  Tab.Fields[iT_M].AsString := q.Fields[iQ_M].AsString; //
  Tab.Fields[iT_M_UF].AsString := q.Fields[iQ_M_UF].AsString; //
  Tab.Fields[iT_EMAIL].AsString := q.Fields[iQ_EMAIL].AsString; //
  Tab.Fields[iT_DT_NASC].AsDateTime := q.Fields[iQ_DT_NASC].AsDateTime; //

  Tab.Fields[iT_ATIVO].AsBoolean := Iif(iPessoaId = 0, True,
    q.Fields[iQ_ATIVO].AsBoolean); //

  Tab.Fields[iT_PESS_CRIADO_EM].AsDateTime := q.Fields[iQ_PESS_CRIADO_EM]
    .AsDateTime; //
  Tab.Fields[iT_PESS_ALTERADO_EM].AsDateTime := q.Fields[iQ_PESS_ALTERADO_EM]
    .AsDateTime; //

  if Tab.Fields[iT_PESS_CRIADO_EM].AsDateTime = 0 then
    Tab.Fields[iT_PESS_CRIADO_EM].AsDateTime := now;

  Tab.Fields[iT_ENDER_ORDEM].AsInteger := q.Fields[iQ_ENDER_ORDEM].AsInteger; //
  Tab.Fields[iT_LOGRADOURO].AsString := q.Fields[iQ_LOGRADOURO].AsString; //
  Tab.Fields[iT_NUMERO].AsString := q.Fields[iQ_NUMERO].AsString; //
  Tab.Fields[iT_COMPLEMENTO].AsString := q.Fields[iQ_COMPLEMENTO].AsString; //
  Tab.Fields[iT_BAIRRO].AsString := q.Fields[iQ_BAIRRO].AsString; //
  Tab.Fields[iT_UF_SIGLA].AsString := q.Fields[iQ_UF_SIGLA].AsString; //
  Tab.Fields[iT_CEP].AsString := StrToOnlyDigit(q.Fields[iQ_CEP].AsString); //
  Tab.Fields[iT_MUNICIPIO_IBGE_ID].AsString := q.Fields[iQ_MUNICIPIO_IBGE_ID]
    .AsString; //
  Tab.Fields[iT_MUNICIPIO_NOME].AsString := q.Fields[iQ_MUNICIPIO_NOME]
    .AsString; //
  Tab.Fields[iT_DDD].AsString := q.Fields[iQ_DDD].AsString; //
  Tab.Fields[iT_FONE1].AsString := q.Fields[iQ_FONE2].AsString; //
  Tab.Fields[iT_FONE2].AsString := q.Fields[iQ_FONE2].AsString; //
  Tab.Fields[iT_FONE3].AsString := q.Fields[iQ_FONE3].AsString; //
  Tab.Fields[iT_CONTATO].AsString := q.Fields[iQ_CONTATO].AsString; //
  Tab.Fields[iT_REFERENCIA].AsString := q.Fields[iQ_REFERENCIA].AsString; //

  Tab.Fields[iT_ENDER_CRIADO_EM].AsDateTime := q.Fields[iQ_ENDER_CRIADO_EM]
    .AsDateTime; //
  Tab.Fields[iT_ENDER_ALTERADO_EM].AsDateTime := q.Fields[iQ_ENDER_ALTERADO_EM]
    .AsDateTime; //

  if Tab.Fields[iT_ENDER_CRIADO_EM].AsDateTime = 0 then
    Tab.Fields[iT_ENDER_CRIADO_EM].AsDateTime := now;

end;

procedure TAppPessDataSetForm.RecordToEnt;
var
  iOrdem: integer;
begin
  FPessEnt.LojaId := FDMemTable.Fields[iT_LOJA_ID].AsInteger;
  FPessEnt.TerminalId := FDMemTable.Fields[iT_TERMINAL_ID].AsInteger;
  FPessEnt.Id := FDMemTable.Fields[iT_PESSOA_ID].AsInteger;
  FPessEnt.Apelido := FDMemTable.Fields[iT_APELIDO].AsString;

  if FPessEnt.EnderQuantidadePermitida <> TEnderQuantidadePermitida.endqtdNenhum
  then
  begin
    PessEnderListGarantirUmItem(FPessEnt.PessEnderList);
  end;
  {
    iOrdem := 0;
    // nao é aqui: FDMemTable.Fields[iT_ENDER_ORDEM].AsInteger := iOrdem;

    FPessEnt.PessEnderList[iOrdem].Logradouro := FDMemTable.Fields[iT_LOGRADOURO].AsString;
    FPessEnt.PessEnderList[iOrdem].Numero := FDMemTable.Fields[iT_NUMERO].AsString;
    FPessEnt.PessEnderList[iOrdem].Complemento := FDMemTable.Fields[iT_COMPLEMENTO].AsString;
    FPessEnt.PessEnderList[iOrdem].Bairro := FDMemTable.Fields[iT_BAIRRO].AsString;
    FPessEnt.PessEnderList[iOrdem].UFSigla := FDMemTable.Fields[iT_UF_SIGLA].AsString;
    FPessEnt.PessEnderList[iOrdem].CEP := FDMemTable.Fields[iT_CEP].AsString;
    FPessEnt.PessEnderList[iOrdem].MunicipioIbgeId := FDMemTable.Fields[iT_MUNICIPIO_IBGE_ID].AsString;
    FPessEnt.PessEnderList[iOrdem].MunicipioNome := FDMemTable.Fields[iT_MUNICIPIO_NOME].AsString;
    FPessEnt.PessEnderList[iOrdem].DDD := FDMemTable.Fields[iT_DDD].AsString;
    FPessEnt.PessEnderList[iOrdem].Fone1 := FDMemTable.Fields[iT_FONE1].AsString;
    FPessEnt.PessEnderList[iOrdem].Fone2 := FDMemTable.Fields[iT_FONE2].AsString;
    FPessEnt.PessEnderList[iOrdem].Fone3 := FDMemTable.Fields[iT_FONE3].AsString;
    FPessEnt.PessEnderList[iOrdem].Contato := FDMemTable.Fields[iT_CONTATO].AsString;
    FPessEnt.PessEnderList[iOrdem].Referencia := FDMemTable.Fields[iT_REFERENCIA].AsString;
    FPessEnt.PessEnderList[iOrdem].CriadoEm := FDMemTable.Fields[iT_ENDER_CRIADO_EM].AsDateTime;
    FPessEnt.PessEnderList[iOrdem].AlteradoEm := FDMemTable.Fields[iT_ENDER_ALTERADO_EM].AsDateTime;
  }
end;

procedure TAppPessDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);
end;

procedure TAppPessDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
