unit App.Threads.SyncTermThread_ProcLog.UsuarioPodeOpcaoSis_u;

interface

uses App.Threads.SyncTermThread_ProcLog_u, Sis.Entities.Types;

type
  TSyncTermProcLogUsuarioPodeOpcaoSis = class(TSyncTermProcLog)
  private
    function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
  public
    procedure Execute(pLogIdIni: Int64; pLogIdFin: Int64); override;
  end;

implementation

uses System.SysUtils, Data.DB, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

{ TSyncTermProcLogUsuarioPodeOpcaoSis }

procedure TSyncTermProcLogUsuarioPodeOpcaoSis.Execute(pLogIdIni,
  pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
  UltimoPessoaId: integer;
  oPessoaIdField: TField;
begin
  AppObj.CriticalSections.DB.Acquire;
  try
    sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    ServCon.QueryDataSet(sSql, q);
  finally
    AppObj.CriticalSections.DB.Release;
  end;

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
        DBExecScript.PegueComando(sSql);
      end;

      sSql := DataSetToSqlGarantir(q, 'USUARIO_PODE_OPCAO_SIS',
        'LOJA_ID, TERMINAL_ID, PESSOA_ID, OPCAO_SIS_ID');
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}

      DBExecScript.PegueComando(sSql);
      q.Next;
    end;
  finally
    q.Free
  end;
end;

function TSyncTermProcLogUsuarioPodeOpcaoSis.GetSqlServLogs(pLogIdIni,
  pLogIdFin: Int64): string;
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

end.
