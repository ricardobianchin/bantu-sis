unit Sis.Ui.ImgsList.Prepare.Sis;

interface

uses Sis.Ui.ImgsList;

procedure ImgsListPrepareSis(pImgsList: IImgsList);

implementation

uses Sis.Ui.Img.Types, Sis.Ui.Img.Utils;

procedure ImgsListPrepareSis(pImgsList: IImgsList);
begin
  ImgIndexesSis.Lupa16 := pImgsList.PegueImgIndex('Sis\Lupa.png');
end;

end.
