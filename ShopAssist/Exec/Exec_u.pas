unit Exec_u;

interface

const
  //PODE_ENVIAR = FALSE;
  PODE_ENVIAR = TRUE;
  //PODE_TRAZER = FALSE;
  PODE_TRAZER = TRUE;
  PODE_SALDO = TRUE;

procedure Execute;

implementation

uses Configs_u, System.SysUtils, DBServDM_u, Terminais_u, EnvParaTerm_u, Sis_u,
  Log_u, Vcl.Dialogs, TrazerDoTerm_u, EstSaldo_u, Loja_dbi_u, EstSaldo_u_dbi;

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
    bPrecisaTerminar := FALSE;

    if not CarregueLoja then
      exit;

    EstSaldoAtualDtHGarantir;

    try
      repeat
        CarregarConfigs;
        CrieListaDeTerminais;
        try
          CarregarIni_Ativo;

          if bAtivo and PODE_ENVIAR then
            ForEachTerminal(EnvParaTerm, bPrecisaTerminar);

          if bPrecisaTerminar then
            break;

          if bAtivo and PODE_TRAZER then
            ForEachTerminal(TrazerDoTerm, bPrecisaTerminar);

          if bPrecisaTerminar then
            break;

          if bAtivo and PODE_SALDO then
            EstSaldo_u.AtualizeEstSaldo(bPrecisaTerminar);

          if bPrecisaTerminar then
            break;

          if not bSegueAberto then
            break;
          // break;
          // {$IFDEF DEBUG}
          // break;
          // {$ENDIF}

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
      until FALSE;
    finally
      FreeAndNil(DBServDM);
      ApaguePrecisaTerminar;
      EscrevaLog('Terminado');
      // ShowMessage('Assist Terminou');
    end;
  except
    on e: exception do
    begin
      EscrevaLog('Exec_u.Execute;' + e.ClassName + ' ' + e.Message);
    end;
  end;
end;

end.
