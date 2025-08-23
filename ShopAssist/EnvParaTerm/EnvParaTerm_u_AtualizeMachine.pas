unit EnvParaTerm_u_AtualizeMachine;

interface

uses DBTermDM_u;

procedure AtualizeMachine(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Configs_u, Sis.Log, Sis.Log_u;

procedure AtualizeMachine(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);
var
  sMens: string;
  sSql: string;
  oServMachinesQ: TFDQuery;
  oLocalMachinesQ: TFDQuery;
  qServ: TDataSet;
  qLocal: TDataSet;
  iRowsAfected: LongInt;

  iServId: integer;
  sServNome: string;
  sServIp: string;

  iLocalId: integer;
  sLocalNome: string;
  sLocalIp: string;
begin
  if pPrecisaTerminar then
    exit;
  try
  sSql := 'SELECT MACHINE_ID, NOME_NA_REDE, trim(IP) colip' //
    + ' FROM MACHINE' //
    + ' WHERE NOME_NA_REDE = ' + QuotedStr(Config.Local.Nome) //
    + ' AND IP = ' + QuotedStr(Config.Local.IP) //
    ; //
  Sis.Log.Log.Escreva('AtualizeMachine;vai abrir serv');
  DBServDM.Connection.Open;
  try
    Sis.Log.Log.Escreva('AtualizeMachine;vai abriu');
    oServMachinesQ := TFDQuery.Create(nil);
    try
      oServMachinesQ.Connection := DBServDM.Connection;
      oServMachinesQ.Sql.Text := sSql;
      Sis.Log.Log.Escreva('AtualizeMachine;vai oServMachinesQ.Open');
      oServMachinesQ.Open;
      try
        iServId := oServMachinesQ.Fields[0].AsInteger;
        sServNome := oServMachinesQ.Fields[1].AsString.Trim;
        sServIp := oServMachinesQ.Fields[2].AsString.Trim;
      finally
        oServMachinesQ.Close;
      end;
    finally
      FreeAndNil(oServMachinesQ);
    end;
  finally
    DBServDM.Connection.Close;
  end;

  Sis.Log.Log.Escreva('AtualizeMachine;vai abrir term');
  pTermDM.Connection.Open;
  try
    Sis.Log.Log.Escreva('AtualizeMachine;vai abriu');
    oLocalMachinesQ := TFDQuery.Create(nil);
    try
      oLocalMachinesQ.Connection := pTermDM.Connection;
      oLocalMachinesQ.Sql.Text := sSql;
    Sis.Log.Log.Escreva('AtualizeMachine;vai oLocalMachinesQ.Open');
      oLocalMachinesQ.Open;
      try
        iLocalId := oLocalMachinesQ.Fields[0].AsInteger;
        sLocalNome := oLocalMachinesQ.Fields[1].AsString.Trim;
        sLocalIp := oLocalMachinesQ.Fields[2].AsString.Trim;
      finally
        oLocalMachinesQ.Close;
      end;

      if (iServId <> iLocalId) or (sServNome <> sLocalNome) or
        (sServIp <> sLocalIp) then
      begin
        try
          // sSql := 'UPDATE MACHINE SET MACHINE_ID = ' //
          // + iServId.ToString //
          // + ', NOME_NA_REDE = ' //
          // + ', ' + QuotedStr(sServNome) //
          // + ', IP = ' //
          // + ', ' + QuotedStr(sServIp) //
          // + ';';

          sSql := 'UPDATE OR INSERT INTO MACHINE (MACHINE_ID, NOME_NA_REDE, IP) '
            + 'VALUES (' + iServId.ToString + ', ' + QuotedStr(sServNome) + ', '
            + QuotedStr(sServIp) + ') MATCHING (MACHINE_ID);';
          pTermDM.Connection.ExecSQL(sSql);
        except
          on e: exception do
          begin
            sMens := 'Erro atualizando machine. Terminal_id = ' +
              pTermDM.Terminal.TerminalId.ToString + '. ' + sSql + '  ' +
              e.message;
            Log.Escreva(sMens);
          end;
        end;
      end;
    finally
      FreeAndNil(oLocalMachinesQ);
    end;
  finally
    pTermDM.Connection.Close;
  end;
  except on e:exception do
    Log.Escreva('AtualizeMachine erro '+e.Message)
  end;
end;

end.
