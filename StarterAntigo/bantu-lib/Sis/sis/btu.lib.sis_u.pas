unit btu.lib.sis_u;

interface

uses btu.lib.sis_i, Spring.Container, SIS.ui.Img.DataModule;

type
  TSis = class(TInterfacedObject, ISis)
  private
    FDIM: TContainer;
    FSisImgDataModule: TSisImgDataModule;

    function GetDIM: TContainer;
    function GetSisImgDataModule: TSisImgDataModule;
  public
    property DIM: TContainer read GetDIM;
    property SisImgDataModule: TSisImgDataModule read GetSisImgDataModule;

    constructor Create(pDIM: TContainer; pSisImgDataModule: TSisImgDataModule);
  end;

implementation

{ TSis }

constructor TSis.Create(pDIM: TContainer;
  pSisImgDataModule: TSisImgDataModule);
begin
  inherited Create;
  FDIM := pDIM;
  FSisImgDataModule := pSisImgDataModule
end;

function TSis.GetDIM: TContainer;
begin
  result := FDIM;
end;

function TSis.GetSisImgDataModule: TSisImgDataModule;
begin
  result := FSisImgDataModule;
end;

end.
