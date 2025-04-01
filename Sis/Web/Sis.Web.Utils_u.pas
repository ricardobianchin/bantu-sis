unit Sis.Web.Utils_u;

interface

function PathToUrl(pFileName: string): string;

implementation

uses System.SysUtils;

function PathToUrl(pFileName: string): string;
begin
  // Convert the path to a URL format
  // Replace backslashes with forward slashes
  // includes the protocol (files://) and domain (localhost) for local files
  {
    Por exemplo, o nome de arquivo:
      C:\Pr\app\bantu\bantu-sis\bantu-doc\Versoes\recentes.html
    deve ser convertido para:
      file:///C:/Pr/app/bantu/bantu-sis/bantu-doc/Versoes/recentes.html  
  }
  Result := 'file:///' + StringReplace(pFileName, '\', '/', [rfReplaceAll]);
end;

end.
