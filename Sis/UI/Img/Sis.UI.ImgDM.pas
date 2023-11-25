unit Sis.UI.ImgDM;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TSisImgDataModule = class(TDataModule)
    FormSysMenuImageList: TImageList;
    ImageList24Flat: TImageList;
    ImageList32Flat: TImageList;
    ImageList_40_24: TImageList;
    ImageListLogin16: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SisImgDataModule: TSisImgDataModule;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
