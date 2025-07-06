unit App.DB.Import.Form_Finalizar_Prod_u;

interface

uses Sis.Types.Utils_u, Sis.DB.DBTypes, App.AppObj, Sis.Usuario, Vcl.ComCtrls, System.Classes;

procedure GarantirProd(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pUsuario: IUsuario; pProgressBar1: TProgressBar; pComandosPendentesSL: TStrings);

implementation

uses Sis.Win.Utils_u, Sis.Types.strings_u, Sis.UI.IO.Files, Data.DB,
  System.SysUtils, Sis.Types.Floats, Sis.Types.Bool_u, Vcl.Dialogs, System.Math;

var
  oAppObj: IAppObj;
  oUsuario: IUsuario;

  iProdId: integer;
  iMaiorId: integer;

  sDescr: string[120];
  sDescrRed: string[29];

  iFabrId, iTipoId, iUnidId, iICMSId: integer;
  sProdNatuId: string;

  uCapacEmb: Currency;

  NCM: string[8];

  iLojaId, iUsuarioId, iMachineId: integer;

  uCusto: Currency;
  // iTabPrecoId: integer;
  aPreco: TArray<Currency>;

  bAtivo: boolean;
  sLocaliz: string[15];
  uMargem: Currency;

  bBalancaExige: boolean;
  sBalDpto: string[3];
  iBalValidadeDias: SmallInt;
  sBalTextoEtiq: string;

  sBarras: string;
  sComando: string;

  oFieldFin_PROD_ID, //
    oFieldFin_DESCR, //
    oFieldFin_DESCR_RED, //
    oFieldFin_IMPORT_FABR_ID, //
    oFieldFin_IMPORT_PROD_TIPO_ID, //
    oFieldFin_IMPORT_UNID_ID, //
    oFieldFin_IMPORT_ICMS_ID, //
    oFieldFin_CAPAC_EMB, //
    oFieldFin_NCM, //
    oFieldFin_CUS, //
    oFieldFin_PRECO, //
    oFieldFin_ATIVO, //
    oFieldFin_LOCALIZ, //
    oFieldFin_MARGEM, //
    oFieldFin_BALANCA_EXIGE, //
    oFieldFin_BAL_DPTO, //
    oFieldFin_BAL_VALIDADE_DIAS, //
    oFieldFin_BAL_TEXTO_ETIQ, //
    oFieldFin_CODIGOS //
    : TField;

  FLog: TextFile;
  sLinhaLog: String;

procedure CrieLog(pNomeArqLog: string);
begin
  AssignFile(FLog, pNomeArqLog);
  Rewrite(FLog);
end;

procedure EscrLog(pFrase: string);
begin
  Append(FLog);
  Writeln(FLog, pFrase);
  CloseFile(FLog);
end;

procedure AtribuaCamposFin(Q: TDataSet);
begin
  oFieldFin_PROD_ID := Q.FieldByName('PROD_ID');
  oFieldFin_DESCR := Q.FieldByName('DESCR');
  oFieldFin_DESCR_RED := Q.FieldByName('DESCR_RED');
  oFieldFin_IMPORT_FABR_ID := Q.FieldByName('IMPORT_FABR_ID');
  oFieldFin_IMPORT_PROD_TIPO_ID := Q.FieldByName('IMPORT_PROD_TIPO_ID');
  oFieldFin_IMPORT_UNID_ID := Q.FieldByName('IMPORT_UNID_ID');
  oFieldFin_IMPORT_ICMS_ID := Q.FieldByName('IMPORT_ICMS_ID');
  oFieldFin_CAPAC_EMB := Q.FieldByName('CAPAC_EMB');
  oFieldFin_NCM := Q.FieldByName('NCM');
  oFieldFin_CUS := Q.FieldByName('CUS');
  oFieldFin_PRECO := Q.FieldByName('PRECO');
  oFieldFin_ATIVO := Q.FieldByName('ATIVO');
  oFieldFin_LOCALIZ := Q.FieldByName('LOCALIZ');
  oFieldFin_MARGEM := Q.FieldByName('MARGEM');
  oFieldFin_BALANCA_EXIGE := Q.FieldByName('BALANCA_EXIGE');
  oFieldFin_BAL_DPTO := Q.FieldByName('BAL_DPTO');
  oFieldFin_BAL_VALIDADE_DIAS := Q.FieldByName('BAL_VALIDADE_DIAS');
  oFieldFin_BAL_TEXTO_ETIQ := Q.FieldByName('BAL_TEXTO_ETIQ');
  oFieldFin_CODIGOS := Q.FieldByName('CODIGOS');
end;

procedure LibereCamposFin;
begin
  oFieldFin_PROD_ID := nil;
  oFieldFin_DESCR := nil;
  oFieldFin_DESCR_RED := nil;
  oFieldFin_IMPORT_FABR_ID := nil;
  oFieldFin_IMPORT_PROD_TIPO_ID := nil;
  oFieldFin_IMPORT_UNID_ID := nil;
  oFieldFin_IMPORT_ICMS_ID := nil;
  oFieldFin_CAPAC_EMB := nil;
  oFieldFin_NCM := nil;
  oFieldFin_CUS := nil;
  oFieldFin_PRECO := nil;
  oFieldFin_ATIVO := nil;
  oFieldFin_LOCALIZ := nil;
  oFieldFin_MARGEM := nil;
  oFieldFin_BALANCA_EXIGE := nil;
  oFieldFin_BAL_DPTO := nil;
  oFieldFin_BAL_VALIDADE_DIAS := nil;
  oFieldFin_BAL_TEXTO_ETIQ := nil;
  oFieldFin_CODIGOS := nil;
end;

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

  // + ',PRO.PROD_NATU_ID'#13#10 // 7

    + ',PRO.CAPAC_EMB'#13#10 // 8

    + ',PRO.NCM'#13#10 // 9

    + ',CASE'#13#10 //
    + '    WHEN PRO.NOVO_CUSTO IS NULL OR PRO.NOVO_CUSTO = 0'#13#10 +
    '    THEN PRO.CUSTO'#13#10 //

    + '    ELSE PRO.NOVO_CUSTO'#13#10 //
    + ' END AS CUS'#13#10 // 10

    + ',PRE.PRECO'#13#10 // 11

    + ',PRO.ATIVO'#13#10 // 12
    + ',PRO.LOCALIZ'#13#10 // 13
    + ',PRO.MARGEM'#13#10 // 14

    + ',PRO.BALANCA_EXIGE'#13#10 // 15
    + ',PRO.BAL_DPTO'#13#10 // 16
    + ',PRO.BAL_VALIDADE_DIAS'#13#10 // 17
    + ',PRO.BAL_TEXTO_ETIQ'#13#10 // 18

    + ',BARLIST.CODIGOS'#13#10 // 19

    + 'FROM IMPORT_PROD PRO'#13#10 //

    + 'LEFT JOIN BARLIST ON'#13#10 //
    + 'PRO.IMPORT_PROD_ID = BARLIST.IMPORT_PROD_ID'#13#10 //

    + 'LEFT JOIN IMPORT_PROD_PRECO_NOVO PRE ON'#13#10 //
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

procedure LeiaQCampos(Q: TDataSet);
begin
  iProdId := oFieldFin_PROD_ID.AsInteger;
  if iProdId < 1 then
  begin
    sLinhaLog := 'Erro prod_id zerado';
    raise Exception.Create(sLinhaLog);
  end
  else
    sLinhaLog := iProdId.ToString;

  iMaiorId := Max(iProdId, iMaiorId);

  sDescr := Trim(oFieldFin_DESCR.AsString);
  sDescrRed := Trim(oFieldFin_DESCR_RED.AsString);
  sLinhaLog := sLinhaLog + ';' + sDescr;

  iFabrId := oFieldFin_IMPORT_FABR_ID.AsInteger;
  iTipoId := oFieldFin_IMPORT_PROD_TIPO_ID.AsInteger;
  iUnidId := oFieldFin_IMPORT_UNID_ID.AsInteger;
  iICMSId := oFieldFin_IMPORT_ICMS_ID.AsInteger;
  if iICMSId < 1 then
    iICMSId := 1;

  sProdNatuId := #033; // q.Fields[7].AsString

  uCapacEmb := oFieldFin_CAPAC_EMB.AsCurrency;

  if uCapacEmb = 0 then
    uCapacEmb := 1;

  NCM := Trim(oFieldFin_NCM.AsString);

  iLojaId := oAppObj.Loja.Id;
  iUsuarioId := oUsuario.Id;
  iMachineId := oAppObj.SisConfig.ServerMachineId.IdentId;

  bAtivo := oFieldFin_ATIVO.AsBoolean;
  sLocaliz := Trim(oFieldFin_LOCALIZ.AsString);
  uMargem := oFieldFin_MARGEM.AsCurrency;

  uCusto := StrToCurrency(oFieldFin_CUS.AsString);
  // iTabPrecoId := 1;
  aPreco[0] := StrToCurrency(oFieldFin_PRECO.AsString);

  if uCusto = 0 then
    uCusto := UM_CENTAVO;

  if aPreco[0] = 0 then
    aPreco[0] := UM_CENTAVO;

  bBalancaExige := oFieldFin_BALANCA_EXIGE.AsBoolean;
  sBalDpto := Trim(oFieldFin_BAL_DPTO.AsString);
  iBalValidadeDias := oFieldFin_BAL_VALIDADE_DIAS.AsInteger;
  sBalTextoEtiq := Trim(oFieldFin_BAL_TEXTO_ETIQ.AsString);

  sBarras := StrSemCharRepetido(oFieldFin_CODIGOS.AsString);
  sBarras := StringReplace(sBarras, ',', ';', [rfReplaceAll]);
end;

function GetImportProdInserirExistenteSQL: string;
begin
  Result := 'EXECUTE PROCEDURE PROD_PA.INSERIR_EXISTENTE_DO(' //
    + iProdId.ToString //
    + ',' + QuotedStr(sDescr) //
    + ',' + QuotedStr(sDescrRed) //
    + ',' + iFabrId.ToString //
    + ',' + iTipoId.ToString //
    + ',' + iUnidId.ToString //
    + ',' + iICMSId.ToString //

    + ',' + QuotedStr(sProdNatuId)

    + ',' + CurrencyToStrPonto(uCapacEmb) //
    + ',' + QuotedStr(NCM) //
    + ',' + iLojaId.ToString //
    + ',' + iUsuarioId.ToString //
    + ',' + iMachineId.ToString //

    + ',' + CurrencyToStrPonto(uCusto) //
    + ',' + CurrencyToStrPonto(aPreco[0]) //
  // iTabPrecoId.ToString + ',' + //
    + ',' + BooleanToStrSQL(bAtivo) //
    + ',' + QuotedStr(sLocaliz) //
    + ',' + CurrencyToStrPonto(uMargem) //
    + ',' + BooleanToStrSQL(bBalancaExige) //
    + ',' + QuotedStr(sBalDpto) //
    + ',' + iBalValidadeDias.ToString //
    + ',' + QuotedStr(sBalTextoEtiq) //
    + ',' + QuotedStr(sBarras) //
    + ');';
end;

procedure GarantirProd(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pUsuario: IUsuario; pProgressBar1: TProgressBar; pComandosPendentesSL: TStrings);
var
  sSql: string;
  Q: TDataSet;
  sProdDescr: string;
  sProdSigla: string;
  iQtdRegs: integer;
  iRegAtual: integer;
  sNomeArqLog: string;
begin
  iMaiorId := 0;
  sNomeArqLog := pAppObj.AppInfo.Pasta + 'Tmp\DBImport\Log DBImport Prod.txt';
  GarantirPastaDoArquivo(sNomeArqLog);
  CrieLog(sNomeArqLog);

  oAppObj := pAppObj;
  oUsuario := pUsuario;
  sSql := GetImportProdSelectSQL;
  EscrLog('GetImportProdSelectSQL');
  EscrLog(sSql);
  EscrLog('------');
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  pDBConnection.QueryDataSet(sSql, Q);
  AtribuaCamposFin(Q);

  sSql := GetImportProdCountSQL;
  EscrLog('GetImportProdCountSQL');
  EscrLog(sSql);
  EscrLog('------');

  iQtdRegs := pDBConnection.GetValueInteger(sSql);
  EscrLog('iQtdRegs=' + iQtdRegs.ToString);
  EscrLog('------');
  pProgressBar1.Position := 0;
  pProgressBar1.Max := iQtdRegs;

  pAppObj.CriticalSections.DB.Acquire;
  pAppObj.CriticalSections.Files.Acquire;
  try
    SetLength(aPreco, 1);
    iRegAtual := 0;
    while not Q.Eof do
    begin
      sLinhaLog := '';
      try
        LeiaQCampos(Q);

        sSql := GetImportProdInserirExistenteSQL;
        sLinhaLog := sLinhaLog + ';' + sSql;

        try
          pDBConnection.ExecuteSQL(sSql);
          sLinhaLog := sLinhaLog + 'Exec sql';//aproveira o ; fim do sql
        except
          on E: Exception do
          begin
            sLinhaLog := sLinhaLog + E.Message;//aproveira o ; fim do sql
            showmessage(E.Message);
          end;
        end;

      finally
        EscrLog(sLinhaLog);
      end;
      Q.Next;
      Inc(iRegAtual);
      pProgressBar1.Position := iRegAtual;
    end;
  finally
    pComandosPendentesSL.Add('ALTER SEQUENCE PROD_SEQ RESTART WITH '+(iMaiorId + 1).ToString+';');
    LibereCamposFin;
    Q.Free;
    EscrLog('Terminou');

    pAppObj.CriticalSections.DB.Release;
    pAppObj.CriticalSections.Files.Release;
  end;
end;

end.
