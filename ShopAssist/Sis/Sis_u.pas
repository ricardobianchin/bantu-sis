unit Sis_u;

interface

const
  TERMINAL_SYNC_PASSO = 50000;

var
  sPastaBin: string;
  sPastaProduto: string;
  sPastaDados: string;
  sPastaTmp: string;

function GetPrecisaTerminar: Boolean;
procedure ApaguePrecisaTerminar;
procedure InicializePrecisaTerminar;

implementation

uses System.SysUtils;

const
  NOME_ARQ_TERMINAR = 'Assist_precisa_fechar.txt';

var
  sNomeArq: string;

function GetPrecisaTerminar: Boolean;
begin
  Result := FileExists(sNomeArq);
end;

procedure ApaguePrecisaTerminar;
begin
  DeleteFile(sNomeArq);
end;

procedure InicializePrecisaTerminar;
begin
  sNomeArq := sPastaBin + NOME_ARQ_TERMINAR;
end;

end.
