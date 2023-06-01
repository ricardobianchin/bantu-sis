unit btu.lib.sis_i;

interface

uses btu.lib.ui.Img.DataModule, Spring.Container;

type
  ISis = interface(IInterface)
    ['{4684024B-282D-4F67-A474-C692FFE35988}']
    function GetDIM: TContainer;
    property DIM: TContainer read GetDIM;

    function GetSisImgDataModule: TSisImgDataModule;
    property SisImgDataModule: TSisImgDataModule read GetSisImgDataModule;
  end;

implementation

end.
