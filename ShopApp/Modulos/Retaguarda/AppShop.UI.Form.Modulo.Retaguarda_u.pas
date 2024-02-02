unit AppShop.UI.Form.Modulo.Retaguarda_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.Retaguarda_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus;

type
  TShopRetaguardaModuloForm = class(TRetaguardaModuloBasForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShopRetaguardaModuloForm: TShopRetaguardaModuloForm;

implementation

{$R *.dfm}

uses App.UI.Retaguarda.ImgDM_u;

procedure TShopRetaguardaModuloForm.FormCreate(Sender: TObject);
begin
  inherited;
//
end;

end.
