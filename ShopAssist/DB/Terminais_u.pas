unit Terminais_u;

interface

uses DBTermDM_u, System.Generics.Collections;

procedure CrieListaDeTerminais;
procedure LibereListaDeTerminais;

procedure ForEachTerminal(pProc: TProcTermOfObject; var pPrecisaTerminar: boolean);

implementation

uses Data.DB, DBServDM_u, App.AppInfo.Types, System.SysUtils, Sis_u;

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
  sDriver := 'FB';
  DBTermDMList := TList<TDBTermDM>.Create;
  DBServDM.Connection.Open;
  try
    sSql := 'SELECT'#13#10 //
      + 'TERMINAL_ID'#13#10 // 0
      + ', APELIDO'#13#10 // 1
      + ', NOME_NA_REDE'#13#10 // 2
      + ', IP'#13#10 // 3
      + ', NF_SERIE'#13#10 // 4
      + ', LETRA_DO_DRIVE'#13#10 // 5
      + ', GAVETA_TEM'#13#10 // 6
      + ', BALANCA_MODO_ID'#13#10 // 7
      + ', BALANCA_ID'#13#10 // 8
      + ', BARRAS_COD_INI'#13#10 // 9
      + ', BARRAS_COD_TAM'#13#10 // 10
      + ', CUPOM_NLINS_FINAL'#13#10 // 11
      + ', SEMPRE_OFFLINE'#13#10 // 12
      + ' FROM TERMINAL'#13#10 //
      + 'WHERE TERMINAL_ID > 0'#13#10 //
      + 'ORDER BY TERMINAL_ID'#13#10; //

    DBServDM.Connection.ExecSQL(sSql, Q);

    if not Assigned(Q) then
      exit;

    try
      while not Q.Eof do
      begin
        oDM := TDBTermDM.Create(nil);

        iId := Q.Fields[0].AsInteger;
        oDM.Terminal.TerminalId := iId;
        oDM.Terminal.NomeNaRede := Q.Fields[2].AsString.Trim;

        sLetraDoDrive := Q.Fields[5].AsString.Trim;
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
  for var oDM in DBTermDMList do
    FreeAndNil(oDM);
  FreeAndNil(DBTermDMList);
end;

procedure ForEachTerminal(pProc: TProcTermOfObject; var pPrecisaTerminar: boolean);
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
