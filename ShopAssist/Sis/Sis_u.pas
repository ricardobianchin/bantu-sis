unit Sis_u;

interface

const
  TERMINAL_SYNC_PASSO = 50000;
  PAUSA_SEGUNDOS = 20;

var
  sPastaBin: string;
  sPastaProduto: string;
  sPastaDados: string;
  sPastaTmp: string;
  sPastaConfig: string;
  bAtivo: Boolean;
  bSegueAberto: Boolean;

function GetPrecisaTerminar: Boolean;
procedure ApaguePrecisaTerminar;
procedure InicializePrecisaTerminar;

implementation

uses System.SysUtils, App.Constants;

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
  sNomeArq := sPastaBin + ASSIST_NOME_ARQ_TERMINAR;
end;

initialization
  bAtivo := True;
  bSegueAberto := True;
end.
