unit VersaoAtu.SrcAtu_u;

interface

procedure SrcAtuExecute(pDescribe, pGMTDtH, pHash: string);

implementation

uses System.Classes, System.SysUtils;

const
  VERSAO_SRC_FILENAME = 'C:\Pr\app\bantu\bantu-sis\Src\App\AppVersao\App.Versao_u.pas';
  MARCA_VERSAO = '{versaoatu versao}';
  MARCA_DTH = '{versaoatu datahora}';
  MARCA_HASH = '{versaoatu Hash}';

procedure SrcAtuExecute(pDescribe, pGMTDtH, pHash: string);
var
  sl: TStringList;
  I: Integer;
  sLinha: string;
begin
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
      else if Pos(MARCA_DTH, sLinha) > 0 then
      begin
        sLinha := '    ' + QuotedStr(pGMTDtH) + MARCA_DTH;
        sl[i] := sLinha;
      end
      else if Pos(MARCA_HASH, sLinha) > 0 then
      begin
        sLinha := '    ' + QuotedStr(pHash) + MARCA_HASH;
        sl[i] := sLinha;
      end;

      sl.savetofile(VERSAO_SRC_FILENAME);
    end;
  finally
    sl.Free;
  end;
end;

end.
