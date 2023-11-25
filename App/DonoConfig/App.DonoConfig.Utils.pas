unit App.DonoConfig.Utils;

interface

uses App.AppInfo;

procedure DonoConfigLer(pAppInfo: IAppInfo);

implementation

uses System.Classes, System.SysUtils, Vcl.Graphics;

procedure DonoConfigLer(pAppInfo: IAppInfo);
var
  Stream: TFileStream;
  Arquivo: string;
  TmpVersao: integer;
  TmpCliCod: integer;
  TmpFundoCor: TColor;
  TmpFonteCor: TColor;
  TmpNomeExib: string[200];

begin
  Arquivo := pAppInfo.PastaBin + 'App.bin';

  Stream := TFileStream.Create(Arquivo, fmOpenRead);
  try
    Stream.Read(TmpVersao, SizeOf(Integer));
    if TmpVersao = 1 then
    begin
      Stream.Read(TmpCliCod, SizeOf(TmpCliCod));
      Stream.Read(TmpFundoCor, SizeOf(TColor));
      Stream.Read(TmpFonteCor, SizeOf(TColor));
      Stream.Read(TmpNomeExib[1], 200);
    end;
  finally
    Stream.Free;
  end;
  pAppInfo.PessoaDonoId := TmpCliCod;
  pAppInfo.FundoCor := TmpFundoCor;
  pAppInfo.FonteCor := TmpFonteCor;
  pAppInfo.NomeExib := TmpNomeExib;
end;

end.
