unit AppShop.UI.Form.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.Config,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus;

type
  TShopConfigModuloForm = class(TConfigModuloBasForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShopConfigModuloForm: TShopConfigModuloForm;

implementation

{$R *.dfm}

end.
