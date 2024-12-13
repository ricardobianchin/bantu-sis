unit EnvParaTerm_u_UsuarioPodeOpcaoSis;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvUsuarioPodeOpcaoSis(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

function GetSqlServLogs(pLogIdIni, pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', PESSOA_ID'#13#10 // 2
    + ', OPCAO_SIS_ID'#13#10 // 3

    + 'FROM LOG_HIST_PA.TEVE_USUARIO_PODE_OPCAO_SIS('#13#10 //

    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure EnvUsuarioPodeOpcaoSis(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
  UltimoPessoaId: integer;
  oPessoaIdField: TField;
begin
  sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  DBServDM.Connection.ExecSQL(sSql, q);

  if not Assigned(q) then
    exit;

  try
    oPessoaIdField := q.FindField('PESSOA_ID');
    UltimoPessoaId := 0;
    while not q.Eof do
    begin
      if UltimoPessoaId <> oPessoaIdField.AsInteger then
      begin
        UltimoPessoaId := oPessoaIdField.AsInteger;
        sSql := 'DELETE FROM USUARIO_PODE_OPCAO_SIS WHERE PESSOA_ID = ' //
          + UltimoPessoaId.ToString;
        oExecScript.PegueComando(sSql);
      end;

      sSql := DataSetToSqlGarantir(q, 'USUARIO_PODE_OPCAO_SIS',
        'LOJA_ID, TERMINAL_ID, PESSOA_ID, OPCAO_SIS_ID');
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}

      oExecScript.PegueComando(sSql);
      q.Next;
    end;
  finally
    q.Free
  end;
end;

end.
