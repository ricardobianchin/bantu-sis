unit Sis.UI.Controls.TImage;

interface

uses Vcl.ExtCtrls;

procedure TImageCarretarJpg(pImage: TImage; pNomeArqJpg: string);

implementation

uses Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, System.SysUtils;

procedure TImageCarretarJpg(pImage: TImage; pNomeArqJpg: string);
var
  jpg: TJPEGImage;
begin
  if not FileExists(pNomeArqJpg) then
    exit;
  jpg := TJPEGImage.Create;
  try
    jpg.LoadFromFile(pNomeArqJpg);
    pImage.Picture.Graphic := jpg;
  finally
    jpg.Free;
  end;
end;

end.
