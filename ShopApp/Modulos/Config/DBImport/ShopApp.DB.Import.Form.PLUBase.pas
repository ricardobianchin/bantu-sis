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
    procedure AtualizarAction_AppDBImportExecute(Sender: TObject);
    procedure ValidarAction_AppDBImportExecute(Sender: TObject);
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

procedure TShopDBImportFormPLUBase.AtualizarAction_AppDBImportExecute
  (Sender: TObject);
type
  TConfStatus = (confTodos, confRejeitados, confAceitos);
  TSelStatus = (selTodos, selSelecionados, selNaoSelecionados);

var
  sSql: string;
  q: TDataSet;
  iIdAnt: integer;
  iIdAtu: integer;
  sBarCodes: string;
  ConfStatus: TConfStatus;
  SelStatus: TSelStatus;
  WhereStr: string;
begin
  case FIlConfComboBox.ItemIndex of
    0:
      ConfStatus := TConfStatus.confTodos;
    1:
      ConfStatus := TConfStatus.confRejeitados;
    2:
      ConfStatus := TConfStatus.confAceitos;
  end;

  case FilSelecComboBox.ItemIndex of
    0:
      SelStatus := TSelStatus.selTodos;
    1:
      SelStatus := TSelStatus.selSelecionados;
    2:
      SelStatus := TSelStatus.selNaoSelecionados;
  end;

  // inherited;
  sSql :=
    'WITH REJ_ORI AS'#13#10
    +'('#13#10
    +'  SELECT IPRO.IMPORT_PROD_REJEICAO_ID_ORIGEM ID'#13#10
    +'  FROM IMPORT_PROD_REJEICAO IPRO'#13#10
    +')'#13#10
    +', REJ_DEST AS'#13#10
    +'('#13#10
    +'  SELECT IPRO.IMPORT_PROD_REJEICAO_ID_DESTINO ID'#13#10
    +'  FROM IMPORT_PROD_REJEICAO IPRO'#13#10
    +')'#13#10
    +', REJ AS'#13#10
    +'('#13#10
    +'SELECT REJ_ORI.ID FROM REJ_ORI'#13#10
    +'UNION DISTINCT'#13#10
    +'SELECT REJ_DEST.ID FROM REJ_DEST'#13#10
    +')'#13#10
    +'select'#13#10 //
    + ' ip.import_prod_id'#13#10 // 0
    + ', ip.vai_importar'#13#10 //
    + ', ip.PROD_ID'#13#10 //
    + ', ip.DESCR'#13#10 //
    + ', ip.DESCR_RED'#13#10 //
    + ', ip.NOVO_DESCR'#13#10 // 5
    + ', ip.NOVO_DESCR_RED'#13#10 //
    + ', ifa.IMPORT_FABR_ID'#13#10 //
    + ', ifa.NOME fabr_nome'#13#10 //
    + ', it.IMPORT_PROD_TIPO_ID'#13#10 //
    + ', it.DESCR tipo_descr'#13#10 // 10
    + ', iu.IMPORT_UNID_ID'#13#10 //
    + ', iu.unid_sigla'#13#10 //
    + ', ii.IMPORT_ICMS_ID'#13#10 //
    + ', ii.ICMS_PERC_DESCR'#13#10 //
    + ', ip.CAPAC_EMB'#13#10 // 15
    + ', ip.NCM'#13#10 //
    + ', ip.CUSTO'#13#10 //
    + ', ipr.PRECO'#13#10 //
    + ', ip.ATIVO'#13#10 //
    + ', ip.LOCALIZ'#13#10 // 20
    + ', ip.MARGEM'#13#10 //
    + ', ip.BAL_USO'#13#10 //
    + ', ip.BAL_DPTO'#13#10 //
    + ', ib.COD_BARRAS'#13#10 // 24

    + 'from import_prod ip'#13#10 //

    + 'join import_fabr ifa on'#13#10//
    + 'ip.import_fabr_id=ifa.import_fabr_id'#13#10 //

    + 'join import_prod_tipo it on'#13#10 //
    + 'ip.import_prod_tipo_id=it.import_prod_tipo_id'#13#10 //

    + 'join import_unid iu on'#13#10 //
    + 'ip.import_unid_id=iu.import_unid_id'#13#10 //

    + 'join import_icms ii on'#13#10 //
    + 'ip.import_icms_id=ii.import_icms_id'#13#10 //

    + 'join import_prod_preco ipr on'#13#10 //
    + 'ip.import_prod_id=ipr.import_prod_id'#13#10 //

    + 'join import_prod_barras ib on'#13#10 //
    + 'ip.import_prod_id=ib.import_prod_id'#13#10 //

    ;

  WhereStr := '';
  case SelStatus of
    selSelecionados:
    begin
      if WhereStr <> '' then
        WhereStr := WhereStr + ' and ';
      WhereStr := '(ip.vai_importar)'#13#10;
    end;
    selNaoSelecionados:
    begin
      if WhereStr <> '' then
        WhereStr := WhereStr + ' and ';
      WhereStr := '(not ip.vai_importar)'#13#10;
    end;
  end;


  case ConfStatus of
    confRejeitados:
      begin
        sSql := sSql
          + 'JOIN rej ON'#13#10 //
          +'ip.import_prod_id=rej.id'#13#10 //
          ;
      end;
    confAceitos:
      begin
        if WhereStr <> '' then
          WhereStr := WhereStr + ' and ';
        WhereStr := WhereStr +' (rej.id is NULL)';
        sSql := sSql
          + 'LEFT JOIN rej ON'#13#10 //
          +'ip.import_prod_id=rej.id'#13#10 //
          ;
      end;
  end;
  if WhereStr <> '' then
    sSql := sSql + 'WHERE ' + WhereStr + #13#10;

  sSql := sSql + 'ORDER BY ip.import_prod_id'#13#10; //
  SetClipboardText(sSql);
  //DestinoDBConnection.Abrir;
  ProdFDMemTable.DisableControls;
  try
    ProdFDMemTable.EmptyDataSet;
    DestinoDBConnection.QueryDataSet(sSql, q);
    try
      iIdAnt := -1;
      sBarCodes := '';
      while not q.Eof do
      begin
        iIdAtu := q.Fields[0].AsInteger;
        if iIdAnt <> iIdAtu then
        begin
          if ProdFDMemTable.State <> dsBrowse then
          begin
            ProdFDMemTable.Fields[24].AsString := sBarCodes;
            ProdFDMemTable.Post;
            sBarCodes := '';
          end;
          ProdFDMemTable.Append;
          QueryToFDMemTable(ProdFDMemTable, q);
          if sBarCodes <> '' then
            sBarCodes := sBarCodes + ',';
          sBarCodes := sBarCodes + Trim(q.Fields[24].AsString);
          iIdAnt := iIdAtu;
        end
        else
        begin
          if sBarCodes <> '' then
            sBarCodes := sBarCodes + ',';
          sBarCodes := sBarCodes + Trim(q.Fields[24].AsString);
        end;

        q.Next;
      end;
      if ProdFDMemTable.State <> dsBrowse then
      begin
        ProdFDMemTable.Fields[24].AsString := sBarCodes;
        ProdFDMemTable.Post;
      end;
    finally
      q.Free;
    end
  finally
    CarregarRej;
    DestinoDBConnection.Fechar;
    ProdFDMemTable.First;
    ProdFDMemTable.EnableControls;
  end
end;

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
{$ENDIF}
end;

procedure TShopDBImportFormPLUBase.ValidarAction_AppDBImportExecute
  (Sender: TObject);
var
  OrigQ: TDataSet;
  DestDBQuery: IDBQuery;
  sSqlOrig: string;
  sSqlQtd: string;
  sSqlDest: string;
  sSqlInsRej: string;
  QtdRegs: integer;
  RegAtual: integer;
  InsDBExec: IDBExec;

  RejeicaoIdOrigem, RejeicaoIdDestino, RejeicaoTipoId: integer;
begin
  inherited;
  sSqlQtd := 'SELECT COUNT(*) FROM IMPORT_PROD WHERE VAI_IMPORTAR;';

  // orig ini
  sSqlOrig := //
    'WITH IP AS ('#13#10 //
    + '  SELECT '#13#10 //
    + '    IMPORT_PROD_ID,'#13#10 //
    + '    IMPORT_FABR_ID,'#13#10 //
    + '    CASE'#13#10 //
    + '        WHEN NOVO_PROD_ID IS NULL OR NOVO_PROD_ID < 1 THEN PROD_ID'#13#10
  //
    + '        ELSE NOVO_PROD_ID'#13#10 //
    + '    END AS PRODUTO_ID,'#13#10 //
    + '    CASE'#13#10 //
    + '        WHEN NOVO_DESCR IS NULL OR NOVO_DESCR = '''' THEN DESCR'#13#10 //
    + '        ELSE NOVO_DESCR'#13#10 //
    + '    END AS DESCRICAO,'#13#10 //
    + '    CASE'#13#10 //
    + '        WHEN NOVO_DESCR_RED IS NULL OR NOVO_DESCR_RED = '''' THEN DESCR_RED'#13#10
  //
    + '        ELSE NOVO_DESCR_RED'#13#10 //
    + '    END AS DESCRICAO_RED '#13#10 //
    + '  FROM IMPORT_PROD '#13#10 //
    + '  WHERE VAI_IMPORTAR '#13#10 //
    + '  ORDER BY IMPORT_PROD_ID'#13#10 //
    + ') '#13#10 //
    + 'SELECT '#13#10 //
    + '  IMPORT_PROD_ID,'#13#10 //
    + '  IMPORT_FABR_ID,'#13#10 //
    + '  PRODUTO_ID,'#13#10 //
    + '  DESCRICAO,'#13#10 //
    + '  DESCRICAO_RED '#13#10 //
    + 'FROM IP;'#13#10; //
  // orig fim

  // dest ini
  sSqlDest := //
    'WITH IP AS ('#13#10 //
    + '  SELECT '#13#10 //
    + '    IMPORT_PROD_ID,'#13#10 //
    + '    IMPORT_FABR_ID,'#13#10 //
    + '    CASE'#13#10 //
    + '        WHEN NOVO_PROD_ID IS NULL OR NOVO_PROD_ID < 1 THEN PROD_ID'#13#10
  //
    + '        ELSE NOVO_PROD_ID'#13#10 //
    + '    END AS PRODUTO_ID,'#13#10 //
    + '    CASE'#13#10 //
    + '        WHEN NOVO_DESCR IS NULL OR NOVO_DESCR = '''' THEN DESCR'#13#10 //
    + '        ELSE NOVO_DESCR'#13#10 //
    + '    END AS DESCRICAO,'#13#10 //
    + '    CASE'#13#10 //
    + '        WHEN NOVO_DESCR_RED IS NULL OR NOVO_DESCR_RED = '''' THEN DESCR_RED'#13#10
  //
    + '        ELSE NOVO_DESCR_RED'#13#10 //
    + '    END AS DESCRICAO_RED '#13#10 //
    + '  FROM IMPORT_PROD '#13#10 //
    + '  WHERE VAI_IMPORTAR '#13#10 //
    + '  AND IMPORT_PROD_ID > :IMPORT_PROD_ID '#13#10 //
    + '  ORDER BY IMPORT_PROD_ID'#13#10 //
    + ') '#13#10 //
    + 'SELECT '#13#10 //
    + '  IMPORT_PROD_ID,'#13#10 //
    + '  IMPORT_FABR_ID,'#13#10 //
    + '  PRODUTO_ID,'#13#10 //
    + '  DESCRICAO,'#13#10 //
    + '  DESCRICAO_RED'#13#10 //
    + 'FROM IP'#13#10 //
    + 'WHERE IMPORT_FABR_ID = :IMPORT_FABR_ID '#13#10 //
    + 'AND (DESCRICAO = :DESCRICAO '#13#10 //
    + 'OR  DESCRICAO_RED = :DESCRICAO_RED) '#13#10 //
    + ';'#13#10; //
  // dest fim

  sSqlInsRej := 'INSERT INTO IMPORT_PROD_REJEICAO(' +
    'IMPORT_PROD_REJEICAO_ID_ORIGEM, IMPORT_PROD_REJEICAO_ID_DESTINO, IMPORT_REJEICAO_TIPO_ID'
    + ') VALUES (' +
    ':IMPORT_PROD_REJEICAO_ID_ORIGEM, :IMPORT_PROD_REJEICAO_ID_DESTINO, :IMPORT_REJEICAO_TIPO_ID'
    + ');';

  DestinoDBConnection.Abrir;
  DestinoDBConnection.ExecuteSQL('DELETE FROM IMPORT_PROD_REJEICAO;');

  ProgressBar1.Position := 0;
  ProgressBar1.Visible := true;
  try
    QtdRegs := DestinoDBConnection.GetValueInteger(sSqlQtd);
    ProgressBar1.Max := QtdRegs;

     SetClipboardText(sSqlDest);
    DestDBQuery := DBQueryCreate('Config.Import.Prod.Rejeicao.Q',
      DestinoDBConnection, sSqlDest, ProcessLog, StatusOutput);
    DestDBQuery.Prepare;

    InsDBExec := DBExecCreate('Config.Import.Prod.Rejeicao.Ins',
      DestinoDBConnection, sSqlInsRej, ProcessLog, StatusOutput);
    InsDBExec.Prepare;

    SetClipboardText(sSqlOrig);
    DestinoDBConnection.QueryDataSet(sSqlOrig, OrigQ);

    RegAtual := 0;
    while not OrigQ.Eof do
    begin
      DestDBQuery.Params[0].AsInteger := OrigQ.Fields[0].AsInteger;
      DestDBQuery.Params[1].AsInteger := OrigQ.Fields[1].AsInteger;
      DestDBQuery.Params[2].AsString := Trim(OrigQ.Fields[3].AsString);
      DestDBQuery.Params[3].AsString := Trim(OrigQ.Fields[4].AsString);

      DestDBQuery.Abrir;
      try
        while not DestDBQuery.DataSet.Eof do
        begin
          RejeicaoIdOrigem := OrigQ.Fields[0].AsInteger;
          RejeicaoIdDestino := DestDBQuery.DataSet.Fields[0].AsInteger;

          if OrigQ.Fields[3].AsString = DestDBQuery.DataSet.Fields[3].AsString
          then
          begin
            RejeicaoTipoId := 1;
            InsDBExec.Params[0].AsInteger := RejeicaoIdOrigem;
            InsDBExec.Params[1].AsInteger := RejeicaoIdDestino;
            InsDBExec.Params[2].AsInteger := RejeicaoTipoId;
          end;

          InsDBExec.Execute;

          if OrigQ.Fields[4].AsString = DestDBQuery.DataSet.Fields[4].AsString
          then
          begin
            RejeicaoTipoId := 2;
            InsDBExec.Params[0].AsInteger := RejeicaoIdOrigem;
            InsDBExec.Params[1].AsInteger := RejeicaoIdDestino;
            InsDBExec.Params[2].AsInteger := RejeicaoTipoId;
          end;

          InsDBExec.Execute;
          DestDBQuery.DataSet.Next;
        end;
      finally
        DestDBQuery.Fechar;
      end;
      OrigQ.Next;
      inc(RegAtual);
      ProgressBar1.Position := RegAtual;
    end;

  finally
    DestDBQuery.Unprepare;
    InsDBExec.Unprepare;
    OrigQ.Free;
    CarregarRej;
    DestinoDBConnection.Fechar;
    ProgressBar1.Visible := False;
  end;
end;

end.
