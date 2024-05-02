unit ShopApp.DB.Import.Form.PLUBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.DB.Import.Form_u, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, App.AppObj, System.Actions, Vcl.ActnList, Vcl.Buttons,
  Sis.UI.IO.Output, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog, Sis.Usuario,
  Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame, Vcl.ComCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.FDDataSetManager,
  Sis.DB.DataSet.Utils;

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

    iProdFabrId: integer;
    iProdTipoId: integer;
    iProdUnidId: integer;
    iProdIcmsId: integer;

    sProdFabrDescr: string;
    sProdTipoDescr: string;
    sProdUnidDescr: string;
    sProdIcmsDescr: string;

    sBarCod: string;
    cCusto: Currency;
    cPreco: Currency;

    ProdIdSL: TStringList;
    DescrSL: TStringList;
    DescrRedSL: TStringList;
    ProdFabrSL: TStringList;
    ProdTipoSL: TStringList;
    ProdUnidSL: TStringList;
    ProdIcmsSL: TStringList;

    function GravarTabExtrangeira(pNomeTab, pDescrVal: string;
      pValoresSL: TStrings): integer;
    procedure GravarProd;
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
  Sis.Types.Integers, Sis.Types.Floats, Sis.Win.Utils_u,
  Sis.Types.strings.abrev_u, Sis.DB.Factory;

{ TShopDBImportFormPLUBase }

constructor TShopDBImportFormPLUBase.Create(AOwner: TComponent;
  pAppObj: IAppObj; pUsuario: IUsuario; pProcessLog: IProcessLog);
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
  sSql: string;
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

    ProdFabrSL := TStringList.Create;
    ProdTipoSL := TStringList.Create;
    ProdUnidSL := TStringList.Create;
    ProdIcmsSL := TStringList.Create;

    ProdFabrSL.Add('NAO INDICADO');
    ProdTipoSL.Add('NAO INDICADO');
    ProdUnidSL.Add('NAO INDICADO');
    ProdIcmsSL.Add('NAO INDICADO');

    begin // especifico plubase
      sProdFabrDescr := 'PADRAO';
      sProdIcmsDescr := 'NAO INDICADO';
    end;

    DestinoDBConnection.Abrir;
    ProgressBar1.Visible := true;

    try
      bResultado := ZereDados(DestinoDBConnection);
      if not bResultado then
        Exit;

      FLinhasSL.LoadFromFile(FNomeArq);
      FLinhasSL.Delete(0);
      StatusOutput.Exibir('Qtd linhas: ' + FLinhasSL.Count.ToString);
      ProgressBar1.Max := FLinhasSL.Count - 1;
      try
        for iLinhaAtual := 0 to FLinhasSL.Count - 1 do
        begin
          ProgressBar1.Position := iLinhaAtual;
          if (iLinhaAtual mod 120) = 0 then
            Application.ProcessMessages;

          FLinhaAtual := StrSemAcento(FLinhasSL[iLinhaAtual]);
          LeiaLinhaAtual;
          GravarLinhaAtual;
        end;
      except
        on E: Exception do
          showmessage(E.Message);
      end;
    finally
      DestinoDBConnection.Fechar;
      FLinhasSL.Free;
      ProdIdSL.Free;
      DescrSL.Free;
      DescrRedSL.Free;

      ProdFabrSL.Free;
      ProdTipoSL.Free;
      ProdUnidSL.Free;
      ProdIcmsSL.Free;

      ProgressBar1.Visible := False;
    end;

  finally
    StatusOutput.Exibir('Fim');
    StatusOutput.Exibir('');
    AtualizarAction_AppDBImport.Execute;
  end;
end;

procedure TShopDBImportFormPLUBase.GravarLinhaAtual;
begin
  iProdFabrId := GravarTabExtrangeira('FABR', sProdFabrDescr, ProdFabrSL);
  iProdTipoId := GravarTabExtrangeira('PROD_TIPO', sProdTipoDescr, ProdTipoSL);
  iProdUnidId := GravarTabExtrangeira('UNID', sProdUnidDescr, ProdUnidSL);
  iProdIcmsId := GravarTabExtrangeira('ICMS', sProdIcmsDescr, ProdIcmsSL);
  GravarProd;
end;

procedure TShopDBImportFormPLUBase.GravarProd;
var
  sSql: string;
  iImportProdId: integer;
  q: TDataSet;
begin
  sSql := 'EXECUTE PROCEDURE import_prod_pa.INSERIR_DO (' //
    + 'TRUE' // VAI_IMPORTAR BOOLEAN,

    + ', ' + iProdId.ToString // PROD_ID ID_DOM,

    + ', ' + QuotedStr(sDescr) // DESCR PROD_DESCR_DOM,
    + ', ' + QuotedStr(sDescrRed) // DESCR_RED PROD_DESCR_RED_DOM,

    + ', ' + iProdFabrId.ToString // IMPORT_FABR_ID ID_DOM,
    + ', ' + iProdTipoId.ToString // IMPORT_PROD_TIPO_ID ID_DOM,
    + ', ' + iProdUnidId.ToString // IMPORT_UNID_ID ID_DOM,
    + ', ' + iProdIcmsId.ToString // IMPORT_ICMS_ID ID_DOM,

    + ', ' + QuotedStr(#33) // PROD_NATU_ID ID_CHAR_DOM,

    + ', 1' // CAPAC_EMB QTD_DOM,
    + ', ' + QuotedStr(sNCM) // NCM CHAR(8),

    + ', ' + CurrencyToStrPonto(cCusto) // CUSTO CUSTO_DOM,
    + ', TRUE' // ATIVO BOOLEAN,
    + ', ' + QuotedStr('') // LOCALIZ NOME_CURTO_DOM,
    + ', 0' // MARGEM PERC_DOM,
    + ', 0' // BAL_USO SMALLINT,
    + ', ' + QuotedStr('001') // BAL_DPTO CHAR(3),
    + ', 0' // BAL_VALIDADE_DIAS SMALLINT,
    + ', ' + QuotedStr('') // BAL_TEXTO_ETIQ VARCHAR(400)
    + ');';

  iImportProdId := DestinoDBConnection.GetValueInteger(sSql);

  sSql := 'INSERT INTO IMPORT_PROD_BARRAS (IMPORT_PROD_ID, ORDEM, COD_BARRAS' +
    ') VALUES(' + iImportProdId.ToString + ', 1,' + QuotedStr(sBarCod) + ');';
  DestinoDBConnection.ExecuteSQL(sSql);

  sSql := 'INSERT INTO IMPORT_PROD_PRECO (IMPORT_PROD_ID, PROD_PRECO_TABELA_ID'
    + ', PRECO) VALUES(' + iImportProdId.ToString + ', 1,' +
    CurrencyToStrPonto(cPreco) + ');';

  DestinoDBConnection.ExecuteSQL(sSql);
end;

function TShopDBImportFormPLUBase.GravarTabExtrangeira(pNomeTab,
  pDescrVal: string; pValoresSL: TStrings): integer;
var
  sSql: string;
begin
  Result := pValoresSL.IndexOf(pDescrVal);
  if Result = -1 then
  begin
    pValoresSL.Add(pDescrVal);
    Result := pValoresSL.Count - 1;

    sSql := 'EXECUTE PROCEDURE IMPORT_' + pNomeTab + '_PA.GARANTIR_ID_DESCR(' +
      QuotedStr(pDescrVal) + ', ' + Result.ToString + ');';

    DestinoDBConnection.ExecuteSQL(sSql);
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
  sDescr := StrSemCharRepetido(Copy(FLinhaAtual, 21, 40));

  // descr red
  sDescrRed := sDescr;

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, ' DE ', ' D ');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, ' DO ', ' D ');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, ' DA ', ' D ');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, ' PARA ', ' P ');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'CARREGADORES', 'CARREG');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'CARREGADOR', 'CARREG');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'ADAPTADORES', 'ADAP');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'ADAPTADOR', 'ADAP');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'MONITORES', 'MONIT');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'MONITOR', 'MONIT');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'TECLADOS', 'TECL');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'TECLADO', 'TECL');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'CAIXAS', 'CX');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'CAIXA', 'CX');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'BATERIAS', 'BATER');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'BATERIA', 'BATER');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'COMPATIVEL', 'COMPAT');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'STANDARD', 'STAN');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'STANDART', 'STAN');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'PROFISSIONAL', 'PRO');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'ORIGINAIS', 'ORI');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'ORIGINAL', 'ORI');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'METROS', 'M');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'METRO', 'M');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'SUPORTES', 'SUP');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'SUPORTE', 'SUP');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'SUPORTE', 'SUP');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'MEMORIAS', 'MEM');

  if Length(sDescrRed) > 29 then
    sDescrRed := ReplaceStr(sDescrRed, 'MEMORIA', 'MEM');

  if Length(sDescrRed) > 29 then
    TStringAbrev.Abrev(sDescrRed, 29);

  sNCM := Trim(Copy(FLinhaAtual, 168, 8));

  sProdTipoDescr := 'SETOR ' + Copy(FLinhaAtual, 85, 2);
  sProdUnidDescr := Copy(FLinhaAtual, 87, 2);

  sBarCod := StrToIntStr(Copy(FLinhaAtual, 8, 13));

  if sBarCod = '0' then
    sBarCod := '';

  // custo
  s := Copy(FLinhaAtual, 138, 10);
  Insert('.', s, 9);
  cCusto := StrToCurrency(s);

  if cCusto = 0 then
    cCusto := 0.01;

  // preco
  s := Copy(FLinhaAtual, 61, 10);
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
{$IFDEF DEBUG}
  FFileSelectFrame.NomeArq := 'X:\Doc\Bantu\Clientes\Daros\PLUBASE.TXT';
  // ExecuteAction_AppDBImport.Execute;

  ProdRejFDMemTable.First;
  ProdRejFDMemTable.Next;
  ProdRejFDMemTable.Next;
  ProdRejFDMemTable.Next;
  ProdRejFDMemTable.Next;
  ProdRejFDMemTable.Next;
  ProdRejFDMemTable.Next;

  RejEdAction_AppDBImport.Execute;
{$ENDIF}
end;

end.
