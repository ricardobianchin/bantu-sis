unit btu.lib.ui.Img.DataModule;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TSisImgDataModule = class(TDataModule)
    FormSysMenuImageList: TImageList;
    ImageList24Flat: TImageList;
    procedure DataModuleCreate(Sender: TObject);
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

procedure TSisImgDataModule.DataModuleCreate(Sender: TObject);
begin
//
end;

end.
