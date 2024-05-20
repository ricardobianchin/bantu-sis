unit VersaoAtu.SrcAtu_u;

interface

procedure SrcAtuExecute(pDescribe, pDtH, pHash: string);

implementation

uses System.Classes, System.SysUtils, Vcl.Dialogs;

const
  VERSAO_SRC_FILENAME = 'C:\Pr\app\bantu\bantu-sis\Src\App\AppVersao\AppVersao_u.pas';
  MARCA_VERSAO = '{versaoatu versao}';
  MARCA_VERSAO_RESUMIDA = '{versaoatu versao resumida}';
  MARCA_COMMIT_DTH = '{versaoatu datahora commit}';
  MARCA_COMPILE_DTH = '{versaoatu datahora compile}';
  MARCA_HASH = '{versaoatu Hash}';

procedure SrcAtuExecute(pDescribe, pDtH, pHash: string);
var
  sl: TStringList;
  I: Integer;
  sLinha: string;
  aItens: TArray<string>;
begin //ConvertImportarActionToTDateTimeStr
  sl := TStringList.Create;
  try
    sl.LoadFromFile(VERSAO_SRC_FILENAME);
    for I := 0 to sl.Count - 1  do
    begin
      sLinha := sl[i];
      if Pos(MARCA_VERSAO, sLinha) > 0 then
      begin
        sLinha := '    ' + QuotedStr(pDescribe) + MARCA_VERSAO;
        sl[i] := sLinha;
      end
      else if Pos(MARCA_VERSAO_RESUMIDA, sLinha) > 0 then
      begin
        aItens := pDescribe.Split(['-']);
        sLinha := '    ' + QuotedStr(aItens[0]) + MARCA_VERSAO_RESUMIDA;
        sl[i] := sLinha;
      end
      else if Pos(MARCA_COMMIT_DTH, sLinha) > 0 then
      begin
        sLinha := '    ' + QuotedStr(pDtH) + MARCA_COMMIT_DTH;
        sl[i] := sLinha;
      end
      else if Pos(MARCA_COMPILE_DTH, sLinha) > 0 then
      begin
        sLinha := '    ' + QuotedStr(FormatDateTime('dd/mm/yyyy hh:nn:ss', now)) + MARCA_COMPILE_DTH;
        sl[i] := sLinha;
      end
      else if Pos(MARCA_HASH, sLinha) > 0 then
      begin
        sLinha := '    ' + QuotedStr(pHash) + MARCA_HASH;
        sl[i] := sLinha;
      end;
    end;
    sl.savetofile(VERSAO_SRC_FILENAME);
  finally
    sl.Free;
  end;
end;

end.
