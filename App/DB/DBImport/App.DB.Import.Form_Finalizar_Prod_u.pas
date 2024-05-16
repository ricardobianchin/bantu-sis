unit App.DB.Import.Form_Finalizar_Prod_u;

interface

uses Sis.DB.DBTypes, App.AppObj, Sis.Usuario, Vcl.ComCtrls;

procedure GarantirProd(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pUsuario: IUsuario; pProgressBar1: TProgressBar);

implementation

uses Sis.Win.Utils_u, Sis.Types.strings_u, Sis.UI.IO.Files, Data.DB,
  System.SysUtils, Sis.Types.Floats, Sis.Types.Bool_u, Vcl.Dialogs;

var
  oAppObj: IAppObj;
  oUsuario: IUsuario;

  iProdId: integer;

  sDescr: string[120];
  sDescrRed: string[29];

  iFabrId, iTipoId, iUnidId, iICMSId: integer;
  sProdNatuId: string;

  uCapacEmb: Currency;

  NCM: string[8];

  iLojaId, iUsuarioId, iMachineId: integer;

  uCusto: Currency;
  iTabPrecoId: integer;
  aPreco: TArray<Currency>;

  bAtivo: boolean;
  sLocaliz: string[15];
  uMargem: Currency;

  iBalUso: SmallInt;
  sBalDpto: string[3];
  iBalValidadeDias: SmallInt;
  sBalTextoEtiq: string;

  sBarras: string;
  sComando: string;

function GetImportProdSelectSQL: string;
begin
  Result := 'WITH BARRAS AS'#13#10 //
    + '('#13#10 //
    + 'SELECT IMPORT_PROD_ID, ORDEM, COD_BARRAS'#13#10 //
    + 'FROM IMPORT_PROD_BARRAS_NOVO'#13#10 //
    + 'ORDER BY IMPORT_PROD_ID, ORDEM'#13#10 //
    + ')'#13#10 //
    + ', BARLIST AS ('#13#10 //
    + 'SELECT'#13#10 //
    + 'BARRAS.IMPORT_PROD_ID'#13#10 //
    + ', LIST(BARRAS.COD_BARRAS, '','') CODIGOS'#13#10 //
    + 'FROM BARRAS'#13#10 //
    + 'GROUP BY BARRAS.IMPORT_PROD_ID'#13#10 //
    + 'ORDER BY BARRAS.IMPORT_PROD_ID'#13#10 //
    + ')'#13#10 //
    + 'SELECT'#13#10 //

    + 'PRO.PROD_ID'#13#10 // 0

    + ',CASE'#13#10 //
    + '    WHEN PRO.NOVO_DESCR IS NULL OR TRIM(PRO.NOVO_DESCR) = '''' THEN PRO.DESCR'#13#10
  //
    + '    ELSE PRO.NOVO_DESCR'#13#10 //
    + ' END AS DESCR'#13#10 // 1

    + ',CASE'#13#10 //
    + '    WHEN PRO.NOVO_DESCR_RED IS NULL OR TRIM(PRO.NOVO_DESCR_RED) = '''' THEN PRO.DESCR_RED'#13#10
  //
    + '    ELSE PRO.NOVO_DESCR_RED'#13#10 //
    + ' END AS DESCR_RED'#13#10 // 2

    + ',PRO.IMPORT_FABR_ID'#13#10 // 3
    + ',PRO.IMPORT_PROD_TIPO_ID'#13#10 // 4
    + ',PRO.IMPORT_UNID_ID'#13#10 // 5
    + ',PRO.IMPORT_ICMS_ID'#13#10 // 6

    + ',PRO.PROD_NATU_ID'#13#10 // 7

    + ',PRO.CAPAC_EMB'#13#10 // 8

    + ',PRO.NCM'#13#10 // 9

    + ',CASE'#13#10 //
    + '    WHEN PRO.NOVO_CUSTO IS NULL OR PRO.NOVO_CUSTO = 0'#13#10
    + '    THEN PRO.CUSTO'#13#10 //

    + '    ELSE PRO.NOVO_CUSTO'#13#10 //
    + ' END AS CUS'#13#10 // 10

    + ',PRE.PRECO'#13#10 // 11

    + ',PRO.ATIVO'#13#10 // 12
    + ',PRO.LOCALIZ'#13#10 // 13
    + ',PRO.MARGEM'#13#10 // 14

    + ',PRO.BAL_USO'#13#10 // 15
    + ',PRO.BAL_DPTO'#13#10 // 16
    + ',PRO.BAL_VALIDADE_DIAS'#13#10 // 17
    + ',PRO.BAL_TEXTO_ETIQ'#13#10 // 18

    + ',BARLIST.CODIGOS'#13#10 // 19

    + 'FROM IMPORT_PROD PRO'#13#10 //

    + 'JOIN BARLIST ON'#13#10 //
    + 'PRO.IMPORT_PROD_ID = BARLIST.IMPORT_PROD_ID'#13#10 //

    + 'JOIN IMPORT_PROD_PRECO_NOVO PRE ON'#13#10 //
    + 'PRO.IMPORT_PROD_ID = PRE.IMPORT_PROD_ID'#13#10 //

    + 'WHERE PRO.VAI_IMPORTAR'#13#10 //

    + 'ORDER BY pro.PROD_ID'#13#10 //
    ;

end;

function GetImportProdCountSQL: string;
begin
  Result := 'SELECT'#13#10 //
    + 'COUNT(*)'#13#10 // 0
    + 'FROM IMPORT_PROD'#13#10 //
    + 'WHERE VAI_IMPORTAR'#13#10 //
    ;
end;

procedure LeiaQCampos(q: TDataSet);
begin
  iProdId := q.Fields[0].AsInteger;
  if iProdId < 1 then
    raise Exception.Create('Erro prod_id zerado');

  sDescr := Trim(q.Fields[1].AsString);
  sDescrRed := Trim(q.Fields[2].AsString);

  iFabrId := q.Fields[3].AsInteger;
  iTipoId := q.Fields[4].AsInteger;
  iUnidId := q.Fields[5].AsInteger;
  iICMSId := q.Fields[6].AsInteger;

  sProdNatuId := #033; // q.Fields[7].AsString

  uCapacEmb := q.Fields[8].AsCurrency;

  if uCapacEmb = 0 then
    uCapacEmb := 1;

  NCM := Trim(q.Fields[9].AsString);

  iLojaId := oAppObj.Loja.Id;
  iUsuarioId := oUsuario.Id;
  iMachineId := oAppObj.SisConfig.ServerMachineId.IdentId;

  bAtivo := q.Fields[12].AsBoolean;
  sLocaliz := Trim(q.Fields[13].AsString);
  uMargem := q.Fields[14].AsCurrency;

  uCusto := StrToCurrency(q.Fields[10].AsString);
  iTabPrecoId := 1;
  aPreco[0] := StrToCurrency(q.Fields[11].AsString);

  if uCusto = 0 then
    uCusto := 0.01;

  if aPreco[0] = 0 then
    aPreco[0] := 0.01;

  iBalUso := q.Fields[15].AsInteger;
  sBalDpto := Trim(q.Fields[16].AsString);
  iBalValidadeDias := q.Fields[17].AsInteger;
  sBalTextoEtiq := Trim(q.Fields[18].AsString);

  sBarras := StrSemCharRepetido(q.Fields[19].AsString);
  sBarras := StringReplace(sBarras, ',', ';', [rfReplaceAll]);
end;

function GetImportProdInserirExistenteSQL: string;
begin
  Result := 'EXECUTE PROCEDURE PROD_PA.INSERIR_EXISTENTE_DO(' + iProdId.ToString

    + ',' + QuotedStr(sDescr) + ',' + QuotedStr(sDescrRed)

    + ',' + iFabrId.ToString + ',' + iTipoId.ToString + ',' + iUnidId.ToString +
    ',' + iICMSId.ToString

    + ',' + QuotedStr(sProdNatuId)

    + ',' + CurrencyToStrPonto(uCapacEmb)

    + ',' + QuotedStr(NCM)

    + ',' + iLojaId.ToString + ',' + iUsuarioId.ToString + ',' +
    iMachineId.ToString

    + ',' + CurrencyToStrPonto(uCusto) + ',' + iTabPrecoId.ToString + ',' +
    CurrencyToStrPonto(aPreco[0])

    + ',' + BooleanToStrSQL(bAtivo) + ',' + QuotedStr(sLocaliz) + ',' +
    CurrencyToStrPonto(uMargem)

    + ',' + iBalUso.ToString + ',' + QuotedStr(sBalDpto) + ',' +
    iBalValidadeDias.ToString + ',' + QuotedStr(sBalTextoEtiq)

    + ',' + QuotedStr(sBarras)

    + ');';
end;

procedure GarantirProd(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pUsuario: IUsuario; pProgressBar1: TProgressBar);
var
  sSql: string;
  q: TDataSet;
  sProdDescr: string;
  sProdSigla: string;
  iQtdRegs: integer;
  iRegAtual: integer;
  sNomeArqLog: string;
  F: TextFile;
begin
  oAppObj := pAppObj;
  oUsuario := pUsuario;
  sSql := GetImportProdSelectSQL;
  pDBConnection.QueryDataSet(sSql, q);

  sSql := GetImportProdCountSQL;

  iQtdRegs := pDBConnection.GetValueInteger(sSql);

  pProgressBar1.Position := 0;
  pProgressBar1.Max := iQtdRegs;
  sNomeArqLog := oAppObj.AppInfo.Pasta + 'Tmp\DBImport\Log DBImport Prod.txt';
  GarantirPastaDoArquivo(sNomeArqLog);
  AssignFile(F, sNomeArqLog);
  Rewrite(F);
  try
    SetLength(aPreco, 1);
    iRegAtual := 0;
    while not q.Eof do
    begin
      LeiaQCampos(q);

      sSql := GetImportProdInserirExistenteSQL;
      WriteLn(F, sSql);
      Flush(F);

      try
        pDBConnection.ExecuteSQL(sSql);
      except
        on E: Exception do
        begin
          WriteLn(F, E.Message);
          showmessage(E.Message);
        end;
      end;

      q.Next;
      Inc(iRegAtual);
      pProgressBar1.Position := iRegAtual;
    end;
  finally
    q.Free;
    WriteLn(F, 'Terminou');
    CloseFile(F);
  end;
end;

end.
