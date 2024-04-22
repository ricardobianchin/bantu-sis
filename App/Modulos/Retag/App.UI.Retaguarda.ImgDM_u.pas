unit App.UI.Retaguarda.ImgDM_u;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TRetagImgDM = class(TDataModule)
    ImageList_16_16: TImageList;
    ImageList_24_24: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RetagImgDM: TRetagImgDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

initialization

  RetagImgDM := nil;

end.
