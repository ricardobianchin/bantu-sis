unit EnvParaTerm_u_AtualizeMachine;

interface

uses DBTermDM_u;

procedure AtualizeMachine(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u;

procedure AtualizeMachine(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);
var
  iMaxMachineId: integer;
  s: string;
  oServMachinesQ: TFDQuery;
  q: TDataSet;
  iRowsAfected: LongInt;
begin
  if pPrecisaTerminar then
    exit;

  DBServDM.Connection.Open;
  pTermDM.Connection.Open;
  try
    // descobre no terminal, qual maior machine_id gravado
    s := 'select max(machine_id) from machine;';
    iMaxMachineId := VarToInteger(pTermDM.Connection.ExecSQLScalar(s));

    // busca no servidor machines posteriores à iMaxMachineId
    s := 'SELECT MACHINE_ID, NOME_NA_REDE, trim(IP) colip' //
      + ' FROM MACHINE' //
      + ' WHERE MACHINE_ID > ' + IntToStr(iMaxMachineId) //
      + ' ORDER BY MACHINE_ID'; //

    oServMachinesQ := TFDQuery.Create(nil);
    try
      oServMachinesQ.Connection := DBServDM.Connection;
      oServMachinesQ.Sql.Text := s;

      oServMachinesQ.Open;
      try
        q := oServMachinesQ;
        while not q.Eof do
        begin
          s := 'INSERT INTO MACHINE' + '(MACHINE_ID, NOME_NA_REDE, IP)' //
            + ' VALUES (' + q.Fields[0].AsInteger.ToString //
            + ', ' + QuotedStr(q.Fields[1].AsString) //
            + ', ' + QuotedStr(q.Fields[2].AsString.Trim) //
            + ');';
          pTermDM.Connection.ExecSQL(s);
          q.Next;
        end;
      finally
        oServMachinesQ.Close;
      end;
    finally
      oServMachinesQ.Free;
    end;
  finally
    DBServDM.Connection.Close;
    pTermDM.Connection.Close;
  end;
end;

end.
