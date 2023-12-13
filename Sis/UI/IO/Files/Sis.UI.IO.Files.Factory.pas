unit Sis.UI.IO.Files.Factory;

interface

uses Sis.UI.IO.Files.FileInfo{, System.SysUtils};

function FIleInfoCreate(pPasta, pNome: string; pData: TDateTime): IFileInfo; overload;

implementation

uses Sis.UI.IO.Files.FileInfo_u;

function FIleInfoCreate(pPasta, pNome: string; pData: TDateTime): IFileInfo;
begin
  Result := TFileInfo.Create(pPasta, pNome, pData);
end;

end.
