unit VersaoAtu.SrcAtu_u;

interface

procedure SrcAtuExecute(pDescribe, pHash, pGMTDtH: string);

implementation

uses System.Classes;

const
  MARCA_VERSAO = '{versaoatu versao}';
  MARCA_DTH = '{versaoatu datahora}';
  MARCA_HASH = '{versaoatu Hash}';
  VERSAO_SRC_FILENAME = 'C:\Pr\app\bantu\bantu-sis\Src\App\AppVersao\App.Versao_u.pas';

procedure SrcAtuExecute(pDescribe, pHash, pGMTDtH: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
  finally
    sl.Free;
  end;
end;

end.
