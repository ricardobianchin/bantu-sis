unit Exec_u;

interface

procedure Execute;

implementation

uses Configs_u, System.SysUtils, DBServDM_u, Terminais_u, EnvParaTerm_u, Sis_u,
  Log_u, Vcl.Dialogs;

procedure Execute;
var
  bPrecisaTerminar: Boolean;
  iQtdPausa: integer;
  iEsperaAtual: integer;
begin
  // ShowMessage('Assist iniciou');

  try
    CarregarConfigs;
    InicieLog;
    DBServDM := DBServDMCreate;
    CrieListaDeTerminais;
    bPrecisaTerminar := False;
    try
      repeat
        ForEachTerminal(EnvParaTerm, bPrecisaTerminar);
//  break;
//        {$IFDEF DEBUG}
//        break;
//        {$ENDIF}

        if bPrecisaTerminar then
          break;

        for iEsperaAtual := 1 to PAUSA_SEGUNDOS do
        begin
          bPrecisaTerminar := GetPrecisaTerminar;
          if bPrecisaTerminar then
            break;
          sleep(1000);
        end;
      until False;
    finally
      LibereListaDeTerminais;
      FreeAndNil(DBServDM);
      ApaguePrecisaTerminar;
      EscrevaLog('Terminado');
      // ShowMessage('Assist Terminou');
    end;
  except
    on e: exception do
    begin
      EscrevaLog('Exec_u.Execute;'+ e.ClassName + ' ' + e.Message);
    end;
  end;
end;

end.
