unit VersaoAtu.IssAtu_u;

interface

procedure IssAtuExecute(pDescribe, pDtH: string);

implementation

uses System.Classes, System.SysUtils, System.DateUtils, Vcl.Dialogs;

const
  ARQUIVOS: array [0 .. 1] of string =
    ('C:\Pr\app\bantu\bantu-sis\bantu-instaladores\Shop64\MercadoInicial.iss',
    'C:\Pr\app\bantu\bantu-sis\bantu-instaladores\Shop64\MercadoAtualiz.iss');

  MARCA_VERSAO = '#define MyVersionNumber';
  MARCA_COMPILE_DTH = '#define MyDtHCompile';
  MARCA_DTH_EDIT = '; Este arquivo foi editado em:';

procedure IssAtuExecute(pDescribe, pDtH: string);
var
  sl: TStringList;
  I: Integer;
  iarq: Integer;
  sLinha: string;
  sIssNomeArq: string;
  QtdItens: integer;
  sAgora: string;
begin
  QtdItens := length(ARQUIVOS);

  sl := TStringList.Create;
  try
    sAgora := FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', Now);
    for iarq := 0 to QtdItens - 1 do
    begin
      sIssNomeArq := ARQUIVOS[iarq];
      sl.LoadFromFile(sIssNomeArq);

      for I := 0 to sl.Count - 1 do
      begin
        sLinha := sl[I];

        if Pos(MARCA_VERSAO, sLinha) > 0 then
        begin
          sLinha := MARCA_VERSAO + ' "' + (pDescribe) + '"';
          sl[I] := sLinha;
        end
        else if Pos(MARCA_COMPILE_DTH, sLinha) > 0 then
        begin
          sLinha := MARCA_COMPILE_DTH + ' "' + pDtH + '"';
          sl[I] := sLinha;
        end
        else if Pos(MARCA_DTH_EDIT, sLinha) > 0 then
        begin
          sLinha := MARCA_DTH_EDIT + ' ' + sAgora;
          sl[I] := sLinha;
        end;
      end;
      sl.savetofile(sIssNomeArq);
    end;
  finally
    sl.Free;
  end;
end;

end.
