unit AppShop.UI.Form.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ.Modulos_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Imaging.pngimage, App.AppInfo;

type
  TShopPrincForm = class(TModulosPrincBasForm)
  private
    { Private declarations }
  protected
    function GetAppInfoCreate: IAppInfo; override;
  public
    { Public declarations }
  end;

var
  ShopPrincForm: TShopPrincForm;

implementation

{$R *.dfm}

uses App.Factory, ShopApp.Constants;

{ TShopPrincForm }

function TShopPrincForm.GetAppInfoCreate: IAppInfo;
begin
  Result := App.Factory.AppInfoCreate(Application.ExeName,
    ATUALIZ_ARQ_SUBPASTA, ATUALIZ_URL);
end;

end.
