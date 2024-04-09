unit Sis.Ui.ImgsList.Prepare;

interface

procedure PrepareImgs(pPastaImgs: string);

implementation

uses Sis.Ui.Img.Factory, Sis.Ui.Img.Utils, Sis.Ui.ImgsList.Prepare.Sis;

procedure PrepareImgs(pPastaImgs: string);
begin
  pPastaImgs := pPastaImgs + 'Iceberg\';
  ImgsList := ImgsListCreate(pPastaImgs);
  ImgsListPrepareSis(ImgsList);
end;

end.
