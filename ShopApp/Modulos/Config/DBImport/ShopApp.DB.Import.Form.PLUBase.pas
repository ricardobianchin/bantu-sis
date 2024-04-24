unit ShopApp.DB.Import.Form.PLUBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.DB.Import.Form_u, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, App.AppObj, System.Actions, Vcl.ActnList, Vcl.Buttons,
  Sis.UI.IO.Output, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog, Sis.Usuario,
  Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame, Vcl.ComCtrls;

type
  TShopDBImportFormPLUBase = class(TDBImportForm)
    MoldeFileSelectPanel: TPanel;
    procedure ExecuteAction_AppDBImportExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FNomeArq: string;
    FLinhaAtual: string;
    FFileSelectFrame: TFileSelectLabeledEditFrame;
    FLinhasSL: TStringList;
    iIndexErro: integer;
    iProdId: integer;

    sDescr, sDescrRed, sNCM: string;

    iProdTipoId: integer;
    sProdTipoDescr: string;
    sBarCod: string;
    cCusto: Currency;
    cPreco: Currency;

    ProdIdSL: TStringList;
    DescrSL: TStringList;
    DescrRedSL: TStringList;
    ProdTipoSL: TStringList;

    procedure GravarProdTipo;

    procedure LeiaLinhaAtual;
    procedure GravarLinhaAtual;
    function JaTemDescr(pDescr: string): boolean;
    function JaTemDescrRed(pDescr: string): boolean;
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pUsuario: IUsuario;
      pProcessLog: IProcessLog = nil);
  end;

var
  ShopDBImportFormPLUBase: TShopDBImportFormPLUBase;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, System.StrUtils, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.Types.Floats, Sis.Win.Utils_u;

{ TShopDBImportFormPLUBase }

constructor TShopDBImportFormPLUBase.Create(AOwner: TComponent;
  pAppObj: IAppObj; pUsuario: IUsuario; pProcessLog: IProcessLog = nil);
begin
  inherited;
  FFileSelectFrame := TFileSelectLabeledEditFrame.Create(TopoPanel);
  FFileSelectFrame.EditCaption := 'Arquivo PLUBASE.TXT';
  PegueFormatoDe(FFileSelectFrame, MoldeFileSelectPanel);
  iIndexErro := 0;
end;

procedure TShopDBImportFormPLUBase.ExecuteAction_AppDBImportExecute
  (Sender: TObject);
var
  bResultado: boolean;
  iLinhaAtual: integer;
begin
  inherited;
  StatusOutput.Exibir('Inicio');
  try
    FNomeArq := FFileSelectFrame.NomeArq;

    bResultado := FNomeArq <> '';
    if not bResultado then
    begin
      StatusOutput.ExibirPausa('Erro: Nome do Arquivo e´ obrigatorio',
        TMsgDlgType.mtError);
      Exit;
    end;

    bResultado := FileExists(FNomeArq);
    if not bResultado then
    begin
      StatusOutput.ExibirPausa('Erro: Arquivo nao existe: [' + FNomeArq + ']',
        TMsgDlgType.mtError);
      Exit;
    end;

    FLinhasSL := TStringList.Create;
    ProdIdSL := TStringList.Create;
    DescrSL := TStringList.Create;
    DescrRedSL := TStringList.Create;
    ProdTipoSL := TStringList.Create;


    ProdTipoSL.Add('NAO INDICADO');

    DestinoDBConnection.Abrir;

    DestinoDBConnection.ExecuteSQL('DELETE FROM PROD_TIPO WHERE PROD_TIPO_ID > 0;');
    ProgressBar1.Visible := true;
    try
      FLinhasSL.LoadFromFile(FNomeArq);
      FLinhasSL.Delete(0);
      StatusOutput.Exibir('Qtd linhas: ' + FLinhasSL.Count.ToString);
      ProgressBar1.Max := FLinhasSL.Count - 1;
      for iLinhaAtual := 0 to FLinhasSL.Count - 1 do
      begin
        ProgressBar1.Position := iLinhaAtual;
        FLinhaAtual := StrSemAcento( FLinhasSL[iLinhaAtual]);
        LeiaLinhaAtual;
        GravarLinhaAtual;
      end;
    finally
      DestinoDBConnection.Fechar;
      FLinhasSL.Free;
      ProdIdSL.Free;
      DescrSL.Free;
      DescrRedSL.Free;
      ProdTipoSL.Free;

      ProgressBar1.Visible := False;
    end;

  finally
    StatusOutput.Exibir('Fim');
    StatusOutput.Exibir('');
  end;
end;

procedure TShopDBImportFormPLUBase.GravarLinhaAtual;
var
  s: string;
begin
  GravarProdTipo;
  s :='EXECUTE PROCEDURE PROD_PA.INSERIR_EXISTENTE_DO('
    + iProdId.ToString //PROD_ID INTEGER NOT NULL
    +', ' + QuotedStr(sDescr) //DESCR           PROD_DESCR_DOM NOT NULL
    +', ' + QuotedStr(sDescrRed) //DESCR_RED     PROD_DESCR_RED_DOM NOT NULL

    +', 1'   //FABR_ID       ID_SHORT_DOM NOT NULL
    +', ' + iProdTipoId.ToString //PROD_TIPO_ID  ID_SHORT_DOM NOT NULL
    +', 1'   //UNID_ID       ID_SHORT_DOM NOT NULL
    +', 0'   //ICMS_ID       ID_SHORT_DOM NOT NULL

    +', ' + QuotedStr(#33) //PROD_NATU_ID  ID_CHAR_DOM NOT NULL

    +', 1'  //CAPAC_EMB     NUMERIC(8, 3) NOT NULL

    +', ' + QuotedStr(sNCM) //NCM           CHAR(8) NOT NULL

    +', ' + AppObj.Loja.Id.ToString //LOJA_ID            ID_SHORT_DOM NOT NULL
    +', ' + Usuario.id.ToString //USUARIO_ID         ID_DOM NOT NULL
    +', ' + AppObj.SisConfig.ServerMachineId.IdentId.ToString  //MACHINE_ID         ID_SHORT_DOM
    +', ' + CurrencyToStrPonto(cCusto) //CUSTO              CUSTO_DOM

    +', 1'   //PROD_PRECO_TABELA_ID ID_SHORT_DOM
    +', ' + CurrencyToStrPonto(cPreco) //PRECO              PRECO_DOM

    +', TRUE'   //ATIVO              BOOLEAN NOT NULL
    +', ' +  QuotedStr('') //LOCALIZ            NOME_CURTO_DOM NOT NULL
    +', 0'   //MARGEM             PERC_DOM

    +', 0'   //BAL_USO            SMALLINT NOT NULL
    +', 001'   //BAL_DPTO           CHAR(3)  NOT NULL
    +', 0'   //BAL_VALIDADE_DIAS  SMALLINT  NOT NULL
    +', ' +   QuotedStr('') //BAL_TEXTO_ETIQ     VARCHAR(400)  NOT NULL

    +', ' +   QuotedStr(sBarCod) //CODIGOS_DE_BARRA VARCHAR(2000)
    +');';
  StatusOutput.Exibir(iProdId.ToString);
  //SetClipboardText(s);
  DestinoDBConnection.ExecuteSQL(s);

{
PROCEDURE INSERIR_EXISTENTE_DO
  (
    PROD_ID INTEGER NOT NULL
    , DESCR           PROD_DESCR_DOM NOT NULL
    , DESCR_RED     PROD_DESCR_RED_DOM NOT NULL

    , FABR_ID       ID_SHORT_DOM NOT NULL
    , PROD_TIPO_ID  ID_SHORT_DOM NOT NULL
    , UNID_ID       ID_SHORT_DOM NOT NULL
    , ICMS_ID       ID_SHORT_DOM NOT NULL

    , PROD_NATU_ID  ID_CHAR_DOM NOT NULL

    , CAPAC_EMB     NUMERIC(8, 3) NOT NULL

    , NCM           CHAR(8) NOT NULL

    , LOJA_ID            ID_SHORT_DOM NOT NULL
    , USUARIO_ID         ID_DOM NOT NULL
    , MACHINE_ID         ID_SHORT_DOM
    , CUSTO              CUSTO_DOM

    , PROD_PRECO_TABELA_ID ID_SHORT_DOM
    , PRECO              PRECO_DOM

    , ATIVO              BOOLEAN NOT NULL
    , LOCALIZ            NOME_CURTO_DOM NOT NULL
    , MARGEM             PERC_DOM

    , BAL_USO            SMALLINT NOT NULL
    , BAL_DPTO           CHAR(3)  NOT NULL
    , BAL_VALIDADE_DIAS  SMALLINT  NOT NULL
    , BAL_TEXTO_ETIQ     VARCHAR(400)  NOT NULL

    , CODIGOS_DE_BARRA VARCHAR(2000)

}
end;

procedure TShopDBImportFormPLUBase.GravarProdTipo;
var
  s: string;
begin
  iProdTipoId := ProdTipoSL.IndexOf(sProdTipoDescr);
  if iProdTipoId = -1 then
  begin
    ProdTipoSL.Add(sProdTipoDescr);
    iProdTipoId := ProdTipoSL.Count - 1;
    s := 'insert into prod_tipo('
      + 'PROD_TIPO_ID, DESCR'
      + ') VALUES ('
      + iProdTipoId.ToString
      +', '
      +QuotedStr(sProdTipoDescr)
      +');';

    DestinoDBConnection.ExecuteSQL(s);
  end;
end;

function TShopDBImportFormPLUBase.JaTemDescr(pDescr: string): boolean;
begin
  Result := DescrSL.IndexOf(pDescr) > -1;
end;

function TShopDBImportFormPLUBase.JaTemDescrRed(pDescr: string): boolean;
begin
  Result := DescrRedSL.IndexOf(pDescr) > -1;
end;

procedure TShopDBImportFormPLUBase.LeiaLinhaAtual;
var
  s: string;
begin
  s := Copy(FLinhaAtual, 1, 7);
  iProdId := StrToInt(s);

  // descr
  s := StrSemCharRepetido( Copy(FLinhaAtual, 21, 40));
  if JaTemDescr(s) then
  begin
    inc(iIndexErro);
    while Length(s + ' _ERR' + IntToStr(iIndexErro)) > 120 do
    begin
      s := Trim(StrDeleteNoFim(s, 1));
    end;
    s := s + '_ERR' + IntToStr(iIndexErro);
  end;
  sDescr := s;
  DescrSL.Add(sDescr);

  // descr red
  s := StrSemCharRepetido( LeftStr(sDescr, 29));
  if JaTemDescrRed(s) then
  begin
    inc(iIndexErro);
    while Length(s + ' _ERR' + IntToStr(iIndexErro)) > 29 do
    begin
      s := Trim(StrDeleteNoFim(s, 1));
    end;
    s := s + ' _ERR' + IntToStr(iIndexErro);
  end;
  sDescrRed := s;
  DescrRedSL.Add(sDescrRed);

  sNCM := Trim(Copy(FLinhaAtual, 168, 8));

  sProdTipoDescr := 'SETOR '+Copy(FLinhaAtual ,85,2);

  sBarCod := StrToIntStr(Copy(FLinhaAtual ,8,13));

  if sBarCod = '0' then
    sBarCod := '';

  // custo
  s := Copy(FLinhaAtual ,138,10);
  Insert('.', s, 9);
  cCusto := StrToCurrency(s);

  if cCusto = 0 then
    cCusto := 0.01;

  // preco
  s := Copy(FLinhaAtual ,61,10);
  Insert('.', s, 9);
  cPreco := StrToCurrency(s);

  if cPreco < 0.01 then
    cPreco := 0.01;

  {
    s :=
    sDescr, sDescrRed, sNCM: string;
    ProdCodStr:=substr(Linha, 1, 7);
  }
end;

procedure TShopDBImportFormPLUBase.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//{$IFDEF DEBUG}
//  FFileSelectFrame.NomeArq := 'X:\Doc\Bantu\Clientes\Daros\PLUBASE.TXT';
//  ExecuteAction_AppDBImport.Execute;
//{$ENDIF}
end;

end.
