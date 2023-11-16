unit Sis.Files.Factory;

interface

uses sis.files.FileInfo{, System.SysUtils};

function FIleInfoCreate(pPasta, pNome: string; pData: TDateTime): IFileInfo; overload;

implementation

uses sis.files.FileInfo_u;

function FIleInfoCreate(pPasta, pNome: string; pData: TDateTime): IFileInfo;
begin
  Result := TFileInfo.Create(pPasta, pNome, pData);
end;

end.
