unit App.UI.Form.Bas.DataSet.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Sis.Config.SisConfig, Sis.Usuario_u, App.Pess.Types,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario, Sis.DB.DBTypes,
  App.AppInfo, App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed, App.Ent.DBI,
  App.Pess.Ent, App.Pess.DBI;

type
  TAppPessDataSetForm = class(TTabSheetDataSetBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;

  protected
    { Protected declarations }

    iMemTab_LOJA_ID: integer;
    iMemTab_TERMINAL_ID: integer;
    iMemTab_PESSOA_ID: integer;
    iMemTab_PESS_COD: integer;
    iMemTab_APELIDO: integer;
    iMemTab_NOME: integer;
    iMemTab_NOME_FANTASIA: integer;
    iMemTab_C: integer;
    iMemTab_I: integer;
    iMemTab_M: integer;
    iMemTab_M_UF: integer;
    iMemTab_EMAIL: integer;
    iMemTab_DT_NASC: integer;
    iMemTab_PESS_CRIADO_EM: integer;
    iMemTab_PESS_ALTERADO_EM: integer;
    iMemTab_ENDER_ORDEM: integer;
    iMemTab_LOGRADOURO: integer;
    iMemTab_NUMERO: integer;
    iMemTab_COMPLEMENTO: integer;
    iMemTab_BAIRRO: integer;
    iMemTab_UF_SIGLA: integer;
    iMemTab_CEP: integer;
    iMemTab_MUNICIPIO_IBGE_ID: integer;
    iMemTab_MUNICIPIO_NOME: integer;
    iMemTab_DDD: integer;
    iMemTab_FONE1: integer;
    iMemTab_FONE2: integer;
    iMemTab_FONE3: integer;
    iMemTab_CONTATO: integer;
    iMemTab_REFERENCIA: integer;
    iMemTab_ENDER_CRIADO_EM: integer;
    iMemTab_ENDER_ALTERADO_EM: integer;


    iQ_LOJA_ID: integer;
    iQ_TERMINAL_ID: integer;
    iQ_PESSOA_ID: integer;
    iQ_APELIDO: integer;
    iQ_NOME: integer;
    iQ_NOME_FANTASIA: integer;
    iQ_C: integer;
    iQ_I: integer;
    iQ_M: integer;
    iQ_M_UF: integer;
    iQ_EMAIL: integer;
    iQ_DT_NASC: integer;
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
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pModoDataSetForm: TModoDataSetForm; pIdPos: integer); override;
  end;

var
  AppPessDataSetForm: TAppPessDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.Controls.TDBGrid, App.Pess.Ent.Factory_u,
  Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg,
  Sis.Types.Bool_u;

constructor TAppPessDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pModoDataSetForm: TModoDataSetForm; pIdPos: integer);
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
    iQ_C := 6;
    iQ_I := 7;
    iQ_M := 8;
    iQ_M_UF := 9;
    iQ_EMAIL := 10;
    iQ_DT_NASC := 11;
    iQ_PESS_CRIADO_EM := 12;
    iQ_PESS_ALTERADO_EM := 13;

    iQ_ENDER_ORDEM := 14;
    iQ_LOGRADOURO := 15;
    iQ_NUMERO := 16;
    iQ_COMPLEMENTO := 17;
    iQ_BAIRRO := 18;
    iQ_UF_SIGLA := 19;
    iQ_CEP := 20;
    iQ_MUNICIPIO_IBGE_ID := 21;
    iQ_MUNICIPIO_NOME := 22;
    iQ_DDD := 23;
    iQ_FONE1 := 24;
    iQ_FONE2 := 25;
    iQ_FONE3 := 26;
    iQ_CONTATO := 27;
    iQ_REFERENCIA := 28;
    iQ_ENDER_CRIADO_EM := 29;
    iQ_ENDER_ALTERADO_EM := 30;
  end;

  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig,
    pUsuario, pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd, pEntDBI,
    pModoDataSetForm, pIdPos);
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
begin

end;

procedure TAppPessDataSetForm.DoLer;
begin
  inherited;

end;

procedure TAppPessDataSetForm.EntToRecord;
var
  sFormat: string;
  sCod: string;
begin
  inherited;
  FDMemTable.Fields[iMemTab_LOJA_ID].AsInteger := FPessEnt.LojaId;
  FDMemTable.Fields[iMemTab_TERMINAL_ID].AsInteger := FPessEnt.TerminalId;
  FDMemTable.Fields[iMemTab_PESSOA_ID].AsInteger := FPessEnt.Id;

  if FPessEnt.CodUsaTerminalId then
  begin
    sFormat := '%.2d-%.2d-%.7d';
    sCod := Format(sFormat, [FDMemTable.Fields[iMemTab_LOJA_ID].AsInteger,
      FDMemTable.Fields[iMemTab_TERMINAL_ID].AsInteger,
      FDMemTable.Fields[iMemTab_PESSOA_ID].AsInteger]);
  end
  else
  begin
    sFormat := '%.2d-%.7d';
    sCod := Format(sFormat, [FDMemTable.Fields[iMemTab_LOJA_ID].AsInteger,
      FDMemTable.Fields[iMemTab_PESSOA_ID].AsInteger]);
  end;
  FDMemTable.Fields[iMemTab_PESS_COD].AsString := sCod;

  FDMemTable.Fields[iMemTab_APELIDO].AsString := FPessEnt.Apelido;
  FDMemTable.Fields[iMemTab_NOME].AsString := FPessEnt.Nome;
  FDMemTable.Fields[iMemTab_NOME_FANTASIA].AsString := FPessEnt.NomeFantasia;
  FDMemTable.Fields[iMemTab_C].AsString := FPessEnt.C;
  FDMemTable.Fields[iMemTab_I].AsString := FPessEnt.I;
  FDMemTable.Fields[iMemTab_M].AsString := FPessEnt.M;
  FDMemTable.Fields[iMemTab_M_UF].AsString := FPessEnt.MUF;
  FDMemTable.Fields[iMemTab_EMAIL].AsString := FPessEnt.EMail;
  FDMemTable.Fields[iMemTab_DT_NASC].AsDateTime := FPessEnt.DtNasc;
  FDMemTable.Fields[iMemTab_PESS_CRIADO_EM].AsDateTime := FPessEnt.CriadoEm;
  FDMemTable.Fields[iMemTab_PESS_ALTERADO_EM].AsDateTime := FPessEnt.AlteradoEm;

  FDMemTable.Fields[iMemTab_ENDER_ORDEM].AsInteger := 0;
  FDMemTable.Fields[iMemTab_LOGRADOURO].AsString := FPessEnt.PessEnderList[1].Logradouro;
  FDMemTable.Fields[iMemTab_NUMERO].AsString := FPessEnt.PessEnderList[1].Numero;
  FDMemTable.Fields[iMemTab_COMPLEMENTO].AsString := FPessEnt.PessEnderList[1].Complemento;
  FDMemTable.Fields[iMemTab_BAIRRO].AsString := FPessEnt.PessEnderList[1].Bairro;
  FDMemTable.Fields[iMemTab_UF_SIGLA].AsString := FPessEnt.PessEnderList[1].UFSigla;
  FDMemTable.Fields[iMemTab_CEP].AsString := FPessEnt.PessEnderList[1].CEP;
  FDMemTable.Fields[iMemTab_MUNICIPIO_IBGE_ID].AsString := FPessEnt.PessEnderList[1].MunicipioIbgeId;
  FDMemTable.Fields[iMemTab_MUNICIPIO_NOME].AsString := FPessEnt.PessEnderList[1].MunicipioNome;
  FDMemTable.Fields[iMemTab_DDD].AsString := FPessEnt.PessEnderList[1].DDD;
  FDMemTable.Fields[iMemTab_FONE1].AsString := FPessEnt.PessEnderList[1].Fone1;
  FDMemTable.Fields[iMemTab_FONE2].AsString := FPessEnt.PessEnderList[1].Fone2;
  FDMemTable.Fields[iMemTab_FONE3].AsString := FPessEnt.PessEnderList[1].Fone3;
  FDMemTable.Fields[iMemTab_CONTATO].AsString := FPessEnt.PessEnderList[1].Contato;
  FDMemTable.Fields[iMemTab_REFERENCIA].AsString := FPessEnt.PessEnderList[1].Referencia;
  FDMemTable.Fields[iMemTab_ENDER_CRIADO_EM].AsDateTime := FPessEnt.PessEnderList[1].CriadoEm;
  FDMemTable.Fields[iMemTab_ENDER_ALTERADO_EM].AsDateTime := FPessEnt.PessEnderList[1].AlteradoEm;
end;

procedure TAppPessDataSetForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
begin
  if pRecno = -1 then
    exit;

  FDMemTable.Append;
  QToMemTable(q);
  FDMemTable.Post;
end;

procedure TAppPessDataSetForm.QToMemTable(q: TDataSet);
var
  sFormat: string;
  sCod: string;
begin
  inherited;
  FDMemTable.Fields[iMemTab_LOJA_ID].AsInteger := Q.Fields[iQ_LOJA_ID].AsInteger;
  FDMemTable.Fields[iMemTab_TERMINAL_ID].AsInteger := Q.Fields[iQ_TERMINAL_ID].AsInteger;
  FDMemTable.Fields[iMemTab_PESSOA_ID].AsInteger := Q.Fields[iQ_PESSOA_ID].AsInteger;

  if FPessEnt.CodUsaTerminalId then
  begin
    sFormat := '%.2d-%.2d-%.7d';
    sCod := Format(sFormat, [FDMemTable.Fields[iMemTab_LOJA_ID].AsInteger,
      FDMemTable.Fields[iMemTab_TERMINAL_ID].AsInteger,
      FDMemTable.Fields[iMemTab_PESSOA_ID].AsInteger]);
  end
  else
  begin
    sFormat := '%.2d-%.7d';
    sCod := Format(sFormat, [FDMemTable.Fields[iMemTab_LOJA_ID].AsInteger,
      FDMemTable.Fields[iMemTab_PESSOA_ID].AsInteger]);
  end;
  FDMemTable.Fields[iMemTab_PESS_COD].AsString := sCod;

  FDMemTable.Fields[iMemTab_APELIDO].AsString := Q.Fields[iQ_APELIDO].AsString;
  FDMemTable.Fields[iMemTab_NOME].AsString := Q.Fields[iQ_NOME].AsString;
  FDMemTable.Fields[iMemTab_NOME_FANTASIA].AsString := Q.Fields[iQ_NOME_FANTASIA].AsString;
  FDMemTable.Fields[iMemTab_C].AsString := Q.Fields[iQ_C].AsString;
  FDMemTable.Fields[iMemTab_I].AsString := Q.Fields[iQ_I].AsString;
  FDMemTable.Fields[iMemTab_M].AsString := Q.Fields[iQ_M].AsString;
  FDMemTable.Fields[iMemTab_M_UF].AsString := Q.Fields[iQ_M_UF].AsString;
  FDMemTable.Fields[iMemTab_EMAIL].AsString := Q.Fields[iQ_EMAIL].AsString;
  FDMemTable.Fields[iMemTab_DT_NASC].AsDateTime := Q.Fields[iQ_DT_NASC].AsDateTime;

  FDMemTable.Fields[iMemTab_PESS_CRIADO_EM].AsDateTime := Q.Fields[iQ_PESS_CRIADO_EM].AsDateTime;
  FDMemTable.Fields[iMemTab_PESS_ALTERADO_EM].AsDateTime := Q.Fields[iQ_PESS_ALTERADO_EM].AsDateTime;

  FDMemTable.Fields[iMemTab_ENDER_ORDEM].AsInteger := Q.Fields[iQ_ENDER_ORDEM].AsInteger;
  FDMemTable.Fields[iMemTab_LOGRADOURO].AsString := Q.Fields[iQ_LOGRADOURO].AsString;
  FDMemTable.Fields[iMemTab_NUMERO].AsString := Q.Fields[iQ_NUMERO].AsString;
  FDMemTable.Fields[iMemTab_COMPLEMENTO].AsString := Q.Fields[iQ_COMPLEMENTO].AsString;
  FDMemTable.Fields[iMemTab_BAIRRO].AsString := Q.Fields[iQ_BAIRRO].AsString;
  FDMemTable.Fields[iMemTab_UF_SIGLA].AsString := Q.Fields[iQ_UF_SIGLA].AsString;
  FDMemTable.Fields[iMemTab_CEP].AsString := Q.Fields[iQ_CEP].AsString;
  FDMemTable.Fields[iMemTab_MUNICIPIO_IBGE_ID].AsString := Q.Fields[iQ_MUNICIPIO_IBGE_ID].AsString;
  FDMemTable.Fields[iMemTab_MUNICIPIO_NOME].AsString := Q.Fields[iQ_MUNICIPIO_NOME].AsString;
  FDMemTable.Fields[iMemTab_DDD].AsString := Q.Fields[iQ_DDD].AsString;
  FDMemTable.Fields[iMemTab_FONE1].AsString := Q.Fields[iQ_FONE2].AsString;
  FDMemTable.Fields[iMemTab_FONE2].AsString := Q.Fields[iQ_FONE2].AsString;
  FDMemTable.Fields[iMemTab_FONE3].AsString := Q.Fields[iQ_FONE3].AsString;
  FDMemTable.Fields[iMemTab_CONTATO].AsString := Q.Fields[iQ_CONTATO].AsString;
  FDMemTable.Fields[iMemTab_REFERENCIA].AsString := Q.Fields[iQ_REFERENCIA].AsString;
  FDMemTable.Fields[iMemTab_ENDER_CRIADO_EM].AsDateTime := Q.Fields[iQ_ENDER_CRIADO_EM].AsDateTime;
  FDMemTable.Fields[iMemTab_ENDER_ALTERADO_EM].AsDateTime := Q.Fields[iQ_ENDER_ALTERADO_EM].AsDateTime;
end;

procedure TAppPessDataSetForm.RecordToEnt;
var
  iOrdem: integer;
begin
  FPessEnt.LojaId := FDMemTable.Fields[iMemTab_LOJA_ID].AsInteger;
  FPessEnt.TerminalId := FDMemTable.Fields[iMemTab_TERMINAL_ID].AsInteger;
  FPessEnt.Id := FDMemTable.Fields[iMemTab_PESSOA_ID].AsInteger;
{  FPessEnt.Apelido := FDMemTable.Fields[iMemTab_APELIDO].AsString;
  FPessEnt.Nome := FDMemTable.Fields[iMemTab_NOME].AsString;
  FPessEnt.NomeFantasia := FDMemTable.Fields[iMemTab_NOME_FANTASIA].AsString;
  FPessEnt.C := FDMemTable.Fields[iMemTab_C].AsString;
  FPessEnt.I := FDMemTable.Fields[iMemTab_I].AsString;
  FPessEnt.M := FDMemTable.Fields[iMemTab_M].AsString;
  FPessEnt.MUF := FDMemTable.Fields[iMemTab_M_UF].AsString;
  FPessEnt.EMail := FDMemTable.Fields[iMemTab_EMAIL].AsString;
  FPessEnt.DtNasc := FDMemTable.Fields[iMemTab_DT_NASC].AsDateTime;
  FPessEnt.CriadoEm := FDMemTable.Fields[iMemTab_PESS_CRIADO_EM].AsDateTime;
  FPessEnt.AlteradoEm := FDMemTable.Fields[iMemTab_PESS_ALTERADO_EM].AsDateTime;
}
  if FPessEnt.EnderQuantidadePermitida <> TEnderQuantidadePermitida.endqtdNenhum
  then
  begin
    PessEnderListGarantirUmItem(FPessEnt.PessEnderList);
  end;
 {
  iOrdem := 0;
  // nao é aqui: FDMemTable.Fields[iMemTab_ENDER_ORDEM].AsInteger := iOrdem;

  FPessEnt.PessEnderList[iOrdem].Logradouro := FDMemTable.Fields[iMemTab_LOGRADOURO].AsString;
  FPessEnt.PessEnderList[iOrdem].Numero := FDMemTable.Fields[iMemTab_NUMERO].AsString;
  FPessEnt.PessEnderList[iOrdem].Complemento := FDMemTable.Fields[iMemTab_COMPLEMENTO].AsString;
  FPessEnt.PessEnderList[iOrdem].Bairro := FDMemTable.Fields[iMemTab_BAIRRO].AsString;
  FPessEnt.PessEnderList[iOrdem].UFSigla := FDMemTable.Fields[iMemTab_UF_SIGLA].AsString;
  FPessEnt.PessEnderList[iOrdem].CEP := FDMemTable.Fields[iMemTab_CEP].AsString;
  FPessEnt.PessEnderList[iOrdem].MunicipioIbgeId := FDMemTable.Fields[iMemTab_MUNICIPIO_IBGE_ID].AsString;
  FPessEnt.PessEnderList[iOrdem].MunicipioNome := FDMemTable.Fields[iMemTab_MUNICIPIO_NOME].AsString;
  FPessEnt.PessEnderList[iOrdem].DDD := FDMemTable.Fields[iMemTab_DDD].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone1 := FDMemTable.Fields[iMemTab_FONE1].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone2 := FDMemTable.Fields[iMemTab_FONE2].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone3 := FDMemTable.Fields[iMemTab_FONE3].AsString;
  FPessEnt.PessEnderList[iOrdem].Contato := FDMemTable.Fields[iMemTab_CONTATO].AsString;
  FPessEnt.PessEnderList[iOrdem].Referencia := FDMemTable.Fields[iMemTab_REFERENCIA].AsString;
  FPessEnt.PessEnderList[iOrdem].CriadoEm := FDMemTable.Fields[iMemTab_ENDER_CRIADO_EM].AsDateTime;
  FPessEnt.PessEnderList[iOrdem].AlteradoEm := FDMemTable.Fields[iMemTab_ENDER_ALTERADO_EM].AsDateTime;
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
