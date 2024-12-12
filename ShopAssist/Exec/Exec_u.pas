unit Exec_u;

interface

procedure Execute;

implementation

uses Configs_u, System.SysUtils, DBServDM_u, Terminais_u, EnvParaTerm_u, Sis_u;

procedure Execute;
var
  bPrecisaTerminar: Boolean;
  iQtdPausa: integer;
  iEsperaAtual: integer;
begin
  CarregarConfigs;
  DBServDM := DBServDMCreate;
  CrieListaDeTerminais;
  bPrecisaTerminar := False;
  try
    repeat
      ForEachTerminal(EnvParaTerm, bPrecisaTerminar);
      if bPrecisaTerminar then
        break;

      for iEsperaAtual := 1 to 15 do
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
  end;
end;

end.
