unit Sis.DB.Updater_u_GetStrings;

interface

function GetUpdaterCabecalho(piVersao: integer; psObjetivo, psObs, psAssunto,
  psDatabase: string; pDtHExec: TDateTime): string;

implementation

uses System.SysUtils;

function GetUpdaterCabecalho(piVersao: integer; psObjetivo, psObs, psAssunto,
  psDatabase: string; pDtHExec: TDateTime): string;
begin
  Result :=
    '/*'#13#10 //
    + 'SCRIPT CRIADO AUTOMATICAMENTE'#13#10 //
    + 'ATUALIZA BANCO DE DADOS PARA A VERSAO: ' //
    + piVersao.ToString + #13#10 //
    + 'ASSUNTO: ' //
    + psAssunto + #13#10 //
    + 'OBJETIVO: ' //
    + psObjetivo + #13#10 //
    ; //

  if psObs <> '' then
    Result := Result + 'OBS: ' + psObs + #13#10;

  Result := Result + //
    FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', pDtHExec) +  #13#10 //
    + '*/'#13#10 + #13#10 //
    + 'CONNECT ''' //
    + psDatabase //
    + ''' USER ''sysdba'' PASSWORD ''masterkey'';'#13#10 //
    + #13#10 //
    ; //

end;

end.
