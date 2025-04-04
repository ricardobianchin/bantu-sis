unit Sis.UI.ImgDM;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, Data.DB;

type
  TSisImgDataModule = class(TDataModule)
    FormSysMenuImageList: TImageList;
    ImageList24Flat: TImageList;
    ImageList32Flat: TImageList;
    ImageList_40_24: TImageList;
    ImageListLogin16: TImageList;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    BalloonHint1: TBalloonHint;
    ImageList16Flat: TImageList;
    ImageList_9_9: TImageList;
    ImageList24FlatSelect: TImageList;
    PrincImageList: TImageList;
    PrincImageList89: TImageList;
    ImageList_13_8: TImageList;
    ControlesImageList_8_8: TImageList;
    ImageList_13_8_Preto: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PegueVendor(pVendorHome, pVendorLib: string);
  end;

var
  SisImgDataModule: TSisImgDataModule;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TSisImgDataModule }

procedure TSisImgDataModule.PegueVendor(pVendorHome, pVendorLib: string);
begin
  FDPhysFBDriverLink1.VendorHome := pVendorHome;
  FDPhysFBDriverLink1.VendorLib := pVendorLib;
end;

end.
