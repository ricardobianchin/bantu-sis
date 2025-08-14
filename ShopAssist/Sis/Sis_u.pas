unit Sis_u;

interface

uses Sis.Entities.Types;

const
  SYNC_QTD_REGS = 50000;
  PAUSA_SEGUNDOS = 5;

var
  sPastaBin: string;
  sPastaProduto: string;
  sPastaDados: string;
  sPastaDadosServ: string;
  sPastaTmp: string;
  sPastaConfig: string;
  bAtivo: Boolean;
  bSegueAberto: Boolean;
  iLojaId: TLojaId;

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
  if Result then
    System.SysUtils.DeleteFile(sNomeArq);
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
  iLojaId := 0;
end.
