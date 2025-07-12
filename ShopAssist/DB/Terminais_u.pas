unit Terminais_u;

interface

uses DBTermDM_u, System.Generics.Collections;

procedure CrieListaDeTerminais;
procedure LibereListaDeTerminais;

procedure ForEachTerminal(pProc: TProcTermOfObject;
  var pPrecisaTerminar: boolean);

implementation

uses Data.DB, DBServDM_u, App.AppInfo.Types, System.SysUtils, Sis_u, Log_u,
  vcl.dialogs, Sis.Win.Utils_u, Configs_u;

var
  DBTermDMList: TList<TDBTermDM>;

procedure CrieListaDeTerminais;
var
  sSql: string;
  Q: TDataSet;
  oTerminal: TTerminal;
  sLetraDoDrive: string;
  sFormat: string;
  sAtiv: string;
  sNomeArq: string;
  oDM: TDBTermDM;
  iId: integer;
  sDriver: string;
begin
  EscrevaLog('CrieListaDeTerminais');
  sDriver := 'FB';
  DBTermDMList := TList<TDBTermDM>.Create;
  try
    DBServDM.Connection.Open;
  except
    on e: exception do
      // showmessage(e.classname + ' '+e.message);
  end;
  try
    sSql := 'SELECT'#13#10 //
      + 'TERMINAL_ID'#13#10 // 0
      + ', NOME_NA_REDE'#13#10 // 1
      + ', IP'#13#10 // 2
      + ', LETRA_DO_DRIVE'#13#10 // 3
      + ' FROM TERMINAL'#13#10 //
      + 'WHERE TERMINAL_ID > 0 AND ATIVO'#13#10 //
      +' AND (NOME_NA_REDE = '+QuotedStr( Config.Local.Nome) + #13#10 //
      +' OR IP = '+QuotedStr( Config.Local.Ip) + ')'#13#10 //
      + 'ORDER BY TERMINAL_ID;'#13#10; //

//{$IFDEF DEBUG}
//    CopyTextToClipboard(sSql);
//{$ENDIF}
    DBServDM.Connection.ExecSQL(sSql, Q);

    if not Assigned(Q) then
      exit;

    try
      while not Q.Eof do
      begin
        oDM := TDBTermDM.Create(nil);

        iId := Q.Fields[0 { TERMINAL_ID } ].AsInteger;
        oDM.Terminal.TerminalId := iId;

        oDM.Terminal.NomeNaRede := Q.Fields[1 { NOME NA REDE } ].AsString.Trim;
        if oDM.Terminal.NomeNaRede = '' then
          oDM.Terminal.NomeNaRede := Q.Fields[2 { IP } ].AsString.Trim;

        sLetraDoDrive := Q.Fields[3 { LETRA DO DRIVE } ].AsString.Trim;
        if sLetraDoDrive = '' then
          sLetraDoDrive := 'C';

        sFormat := '%sDados_%s_Terminal_%.3d.fdb';
        sAtiv := AtividadeEconomicaSisDescr
          [TAtividadeEconomicaSis.ativeconMercado];

        sNomeArq := Format(sFormat, [sPastaDados, sAtiv, iId]);
        sNomeArq[1] := sLetraDoDrive[1];

        oDM.Terminal.LocalArqDados := sNomeArq;

        oDM.Connection.Params.Text := //
          'DriverID=' + sDriver + #13#10 //
          + 'Server=' + oDM.Terminal.NomeNaRede + #13#10 //
          + 'Database=' + oDM.Terminal.LocalArqDados + #13#10 //
          + 'Password=masterkey'#13#10 //
          + 'User_Name=sysdba'#13#10 //
          + 'Protocol=TCPIP' //
          ;

        DBTermDMList.Add(oDM);
        Q.Next;
      end;
    finally
      Q.Free;
    end;
  finally
    DBServDM.Connection.Close;
  end;
end;

procedure LibereListaDeTerminais;
begin
  EscrevaLog('LibereListaDeTerminais');
  for var oDM in DBTermDMList do
    FreeAndNil(oDM);
  FreeAndNil(DBTermDMList);
end;

procedure ForEachTerminal(pProc: TProcTermOfObject;
  var pPrecisaTerminar: boolean);
begin
  for var oDM in DBTermDMList do
  begin
    pPrecisaTerminar := GetPrecisaTerminar;
    if pPrecisaTerminar then
      exit;

    pProc(oDM, pPrecisaTerminar);
    if pPrecisaTerminar then
      exit;
  end;
end;

end.
