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
    bPrecisaTerminar := False;
    try
      repeat
        CarregarConfigs;
        CrieListaDeTerminais;
        try

        CarregarIni_Ativo;
        if bAtivo then
          ForEachTerminal(EnvParaTerm, bPrecisaTerminar);

        if bPrecisaTerminar then
          break;

//        if bAtivo then
//          ForEachTerminal(TrazerDoTerm, bPrecisaTerminar);

//        if bPrecisaTerminar then
//          break;

        if not bSegueAberto then
          break;
//  break;
//        {$IFDEF DEBUG}
//        break;
//        {$ENDIF}

        for iEsperaAtual := 1 to PAUSA_SEGUNDOS do
        begin
          bPrecisaTerminar := GetPrecisaTerminar;
          if bPrecisaTerminar then
            break;
          sleep(1000);
        end;
        finally
          LibereListaDeTerminais;
        end;
      until False;
    finally
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
