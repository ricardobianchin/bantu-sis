unit App.DB.Import.Form_SQL_u;

interface


USES App.DB.Import.Types_u;

function AtualizarGetSQL(pConfStatus: TConfStatus; pSelStatus: TSelStatus): string;

implementation

function AtualizarGetSQL(pConfStatus: TConfStatus; pSelStatus: TSelStatus): string;
begin
  Result :=
'WITH FAB AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_FABR_ID, NOME FROM IMPORT_FABR'#13#10 //
+')'#13#10 //
+', TIP AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_PROD_TIPO_ID, DESCR FROM IMPORT_PROD_TIPO'#13#10 //
+')'#13#10 //
+', UNI AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_UNID_ID, UNID_SIGLA FROM IMPORT_UNID'#13#10 //
+')'#13#10 //
+', ICM AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_ICMS_ID, ICMS_PERC_DESCR FROM IMPORT_ICMS'#13#10 //
+')'#13#10 //
+', BAR AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_PROD_ID, LIST(COD_BARRAS, '', '') AS CODS_BARRAS'#13#10 //
+'  FROM IMPORT_PROD_BARRAS'#13#10 //
+'  GROUP BY IMPORT_PROD_ID'#13#10 //
+')'#13#10 //
+', BARN AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_PROD_ID, LIST(COD_BARRAS, '', '') AS CODS_BARRAS_NOVO'#13#10 //
+'  FROM IMPORT_PROD_BARRAS_NOVO'#13#10 //
+'  GROUP BY IMPORT_PROD_ID'#13#10 //
+')'#13#10 //
+', TAB AS'#13#10 //
+'('#13#10 //
+'  SELECT PROD_PRECO_TABELA_ID ID, NOME FROM PROD_PRECO_TABELA'#13#10 //
+')'#13#10 //
+', PRE AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_PROD_ID, LIST(TAB.ID || ''-'' || TRIM(CAST(preco AS VARCHAR(20))), ''/'') AS precos'#13#10 //
+'  FROM IMPORT_PROD_PRECO'#13#10 //
+'  JOIN TAB ON'#13#10 //
+'  PROD_PRECO_TABELA_ID = tAB.id'#13#10 //
+'  GROUP BY IMPORT_PROD_ID'#13#10 //
+')'#13#10 //
+', PREN AS'#13#10 //
+'('#13#10 //
+'  SELECT IMPORT_PROD_ID, LIST(TAB.ID || ''-'' || TRIM(CAST(preco AS VARCHAR(20))), ''/'') AS precosn'#13#10 //
+'  FROM IMPORT_PROD_PRECO_NOVO'#13#10 //
+'  JOIN TAB ON'#13#10 //
+'  PROD_PRECO_TABELA_ID = tAB.id'#13#10 //
+'  GROUP BY IMPORT_PROD_ID'#13#10 //
+')'#13#10 //
+', REJ_ORI AS'#13#10 //
+' ('#13#10 //
+'   SELECT IPRO.IMPORT_PROD_REJEICAO_ID_ORIGEM ID'#13#10 //
+'   FROM IMPORT_PROD_REJEICAO IPRO'#13#10 //
+')'#13#10 //
+', REJ_DEST AS'#13#10 //
+'('#13#10 //
+'  SELECT IPRO.IMPORT_PROD_REJEICAO_ID_DESTINO ID'#13#10 //
+'  FROM IMPORT_PROD_REJEICAO IPRO'#13#10 //
+')'#13#10 //
+', REJ as'#13#10 //
+'('#13#10 //
+'  SELECT REJ_ORI.ID FROM REJ_ORI'#13#10 //
+'  UNION DISTINCT'#13#10 //
+'  SELECT REJ_DEST.ID FROM REJ_DEST'#13#10 //
+')'#13#10 //
+'SELECT'#13#10 //
+' PRO.import_prod_id'#13#10 // 0
+', PRO.vai_importar'#13#10 //
+', PRO.PROD_ID'#13#10 //
+', PRO.DESCR'#13#10 //
+', PRO.DESCR_RED'#13#10 //
+', PRO.NOVO_DESCR'#13#10 // 5
+', PRO.NOVO_DESCR_RED'#13#10 //
+', FAB.IMPORT_FABR_ID'#13#10 //
+', FAB.NOME'#13#10 //
+', TIP.IMPORT_PROD_TIPO_ID'#13#10 //
+', TIP.DESCR'#13#10 // 10
+', UNI.IMPORT_UNID_ID'#13#10 //
+', UNI.unid_sigla'#13#10 //
+', ICM.IMPORT_ICMS_ID'#13#10 //
+', ICM.ICMS_PERC_DESCR'#13#10 //
+', PRO.CAPAC_EMB'#13#10 // 15
+', PRO.NCM'#13#10 //
+', PRO.CUSTO'#13#10 //
+', PRO.NOVO_CUSTO'#13#10 //
+', PRE.PRECOS'#13#10 //
+', PREN.PRECOSN'#13#10 // 20
+', PRO.ATIVO'#13#10 //
+', PRO.LOCALIZ'#13#10 //
+', PRO.MARGEM'#13#10 //
+', PRO.BAL_USO'#13#10 //
+', PRO.BAL_DPTO'#13#10 // 25
+', BAR.CODS_BARRAS'#13#10 //
+', BARN.CODS_BARRAS_NOVO'#13#10 // 27
+'FROM import_prod PRO'#13#10 //
+'JOIN FAB ON PRO.import_fabr_id = FAB.IMPORT_FABR_ID'#13#10 //
+'JOIN TIP ON PRO.IMPORT_PROD_TIPO_ID = TIP.IMPORT_PROD_TIPO_ID'#13#10 //
+'JOIN UNI ON PRO.IMPORT_UNID_ID = UNI.IMPORT_UNID_ID'#13#10 //
+'JOIN ICM ON PRO.IMPORT_ICMS_ID = ICM.IMPORT_ICMS_ID'#13#10 //
+'JOIN BAR ON PRO.import_prod_id = BAR.IMPORT_PROD_ID'#13#10 //
+'JOIN BARN ON PRO.import_prod_id = BARN.IMPORT_PROD_ID'#13#10 //
+'JOIN PRE ON PRO.import_prod_id = PRE.IMPORT_PROD_ID'#13#10 //
+'JOIN PREN ON PRO.import_prod_id = PREN.IMPORT_PROD_ID'#13#10 //
+'ORDER BY PRO.IMPORT_PROD_ID'#13#10 //
;

(*
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
        sSql := sSql + 'JOIN rej ON'#13#10 //
          + 'ip.import_prod_id=rej.id'#13#10 //
          ;
      end;
    confAceitos:
      begin
        if WhereStr <> '' then
          WhereStr := WhereStr + ' and ';
        WhereStr := WhereStr + ' (rej.id is NULL)';
        sSql := sSql + 'LEFT JOIN rej ON'#13#10 //
          + 'ip.import_prod_id=rej.id'#13#10 //
          ;
      end;
  end;
  if WhereStr <> '' then
    sSql := sSql + 'WHERE ' + WhereStr + #13#10;

  sSql := sSql + 'ORDER BY ip.import_prod_id'#13#10; //

  {$IFDEF DEBUG}
    SetClipboardText(sSql);
  {$ENDIF}




*)
end;

end.
