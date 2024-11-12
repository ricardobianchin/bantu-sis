unit App.Threads.SyncTermThread_u_SyncLoja;

interface

uses App.Constants, Sis.DB.Factory, Sis.DB.DBTypes, App.DB.Utils,
  Sis.Sis.Constants, App.AppObj, Sis.Entities.Terminal, Sis.Win.Utils_u;

procedure SyncLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pLogIdIni: Int64; pLogIdFin: Int64;
  pDBExecScript: IDBExecScript);

implementation

uses System.SysUtils, Data.DB, Sis.Types.Dates, Sis.Types.Bool_u,
  Sis.DB.SqlUtils_u;

function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //
    + 'LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', PESSOA_ID'#13#10 // 2

    + ', APELIDO'#13#10 // 3

    + ', NOME'#13#10 // 4
    + ', NOME_FANTASIA'#13#10 // 5

    + ', C'#13#10 // 6
    + ', I'#13#10 // 7
    + ', M'#13#10 // 8
    + ', M_UF'#13#10 // 9

    + ', EMAIL'#13#10 // 10
    + ', DT_NASC'#13#10 // 11
    + ', ATIVO'#13#10 // 12

    + ', PESS_CRIADO_EM CRIADO_EM'#13#10 // 13
    + ', PESS_ALTERADO_EM ALTERADO_EM'#13#10 // 14

    + ', 0 ORDEM'#13#10 // 15
    + ', LOGRADOURO'#13#10 // 16
    + ', NUMERO'#13#10 // 17
    + ', COMPLEMENTO'#13#10 // 18
    + ', BAIRRO'#13#10 // 19
    + ', UF_SIGLA'#13#10 // 20
    + ', CEP'#13#10 // 21
    + ', MUNICIPIO_IBGE_ID'#13#10 // 22

    + ', DDD'#13#10 // 23
    + ', FONE1'#13#10 // 24
    + ', FONE2'#13#10 // 25
    + ', FONE3'#13#10 // 26

    + ', CONTATO'#13#10 // 27
    + ', REFERENCIA'#13#10 // 28
    + ', SELECIONADO'#13#10 // 29

    + 'FROM LOG_HIST_PA.TEVE_LOJA('#13#10 //
    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //
    + ');' //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure SyncLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pLogIdIni: Int64; pLogIdFin: Int64;
  pDBExecScript: IDBExecScript);
var
  sSql: string;
  q: TDataSet;
  iLojaId: SmallInt;
  iPessoaId: integer;
begin
  pAppObj.CriticalSections.DB.Acquire;
  try
    sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    pServCon.QueryDataSet(sSql, q);
  finally
    pAppObj.CriticalSections.DB.Release;
  end;

  if not Assigned(q) then
    exit;

  try
    if q.IsEmpty then
      exit;

    iLojaId := q.Fields[0].AsInteger;
    if iLojaId = 0 then
      exit;

    sSql := DataSetToSqlGarantir(q, 'LOJA', 'LOJA_ID', [0, 3, 29]);
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    pDBExecScript.PegueComando(sSql);

    sSql := 'UPDATE AMBIENTE_SIS SET LOJA_ID='+iLojaId.ToString;
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}
    pDBExecScript.PegueComando(sSql);

    iPessoaId := q.FieldByName('pessoa_id').AsInteger;

    if iPessoaId = 0 then
      exit;

    sSql := DataSetToSqlGarantir(q, 'PESSOA', 'LOJA_ID, TERMINAL_ID, PESSOA_ID',
      [0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]);
//{$IFDEF DEBUG}
//    CopyTextToClipboard(sSql);
//{$ENDIF}
    pDBExecScript.PegueComando(sSql);

    sSql := DataSetToSqlGarantir(q, 'ENDERECO', //
      'LOJA_ID, TERMINAL_ID, PESSOA_ID, ORDEM', //
      [0, 1, 2, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]);
//{$IFDEF DEBUG}
//    CopyTextToClipboard(sSql);
//{$ENDIF}
    pDBExecScript.PegueComando(sSql);

    sSql := DataSetToSqlGarantir(q, 'LOJA_EH_PESSOA',
      'LOJA_ID, TERMINAL_ID, PESSOA_ID', [0, 1, 2]);
//{$IFDEF DEBUG}
//    CopyTextToClipboard(sSql);
//{$ENDIF}
    pDBExecScript.PegueComando(sSql);

    {

      UPDATE OR INSERT INTO LOJA_EH_PESSOA (LOJA_ID, TERMINAL_ID, PESSOA_ID)
      VALUES (:LOJA_ID_RET, :TERMINAL_ID_RET, :PESSOA_ID_RET)
      MATCHING (LOJA_ID, TERMINAL_ID, PESSOA_ID);


      UPDATE OR INSERT INTO PESSOA(LOJA_ID, TERMINAL_ID, PESSOA_ID, NOME,
      NOME_FANTASIA, APELIDO, GENERO_ID, ESTADO_CIVIL_ID, C, I, M, M_UF, EMAIL,
      DT_NASC, ATIVO, ALTERADO_EM)VALUES(: LOJA_ID, : TERMINAL_ID, : PESSOA_ID,
      : NOME, : NOME_FANTASIA, : APELIDO, : GENERO_ID, : ESTADO_CIVIL_ID, : C,
      : I, : M, : M_UF, : EMAIL, : DT_NASC, : ATIVO, : ALTERADO_EM)
      MATCHING(LOJA_ID, TERMINAL_ID, PESSOA_ID);

      SUSPEND;

      EXECUTE
      PROCEDURE ENDERECO_PA.GARANTIR(: LOJA_ID, : TERMINAL_ID, : PESSOA_ID, 0,
      : LOGRADOURO, : NUMERO, : COMPLEMENTO, : BAIRRO, : UF_SIGLA, : CEP,
      : MUNICIPIO_IBGE_ID, : DDD, : FONE1, : FONE2, : FONE3, : CONTATO,
      : REFERENCIA);

      UPDATE OR INSERT INTO LOJA_EH_PESSOA(LOJA_ID, TERMINAL_ID, PESSOA_ID)
      VALUES(: LOJA_ID_RET, : TERMINAL_ID_RET, : PESSOA_ID_RET)
      MATCHING(LOJA_ID, TERMINAL_ID, PESSOA_ID);

    }

  finally
    q.Free
  end;
end;

end.
