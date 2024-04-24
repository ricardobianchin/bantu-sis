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
  TmpNomeExib: string;
  Len: Integer;  // Variável para armazenar o comprimento da string

begin
  Arquivo := pAppInfo.PastaConfigs + 'App.bin';

  Stream := TFileStream.Create(Arquivo, fmOpenRead);
  try
    Stream.Read(TmpVersao, SizeOf(Integer));
    if TmpVersao = 1 then
    begin
      Stream.Read(TmpCliCod, SizeOf(TmpCliCod));
      Stream.Read(TmpFundoCor, SizeOf(TColor));
      Stream.Read(TmpFonteCor, SizeOf(TColor));

      // Ler a string
      Stream.Read(Len, SizeOf(Len));  // Ler o comprimento da string
//      SetLength(TmpNomeExib, Len);  // Definir o comprimento da string
//      Stream.Read(PChar(TmpNomeExib)^, Len);  // Ler a string
    end;
  finally
    Stream.Free;
  end;
  pAppInfo.PessoaDonoId := TmpCliCod;
  pAppInfo.FundoCor := TmpFundoCor;
  pAppInfo.FonteCor := TmpFonteCor;
  pAppInfo.NomeExib := 'Administrador do Sistema Daros';//TmpNomeExib;
end;

end.
