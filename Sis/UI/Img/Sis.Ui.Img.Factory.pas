unit Sis.Ui.Img.Factory;

interface

uses Sis.Ui.ImgsList;

function ImgsListCreate(pPastaImg: string): IImgsList;

implementation

uses Sis.Ui.ImgsList_u;

function ImgsListCreate(pPastaImg: string): IImgsList;
begin
  Result := TImgsList.Create(pPastaImg);
end;

end.
