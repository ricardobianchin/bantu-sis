unit AppShop.UI.Form.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.PDV_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus;

type
  TShopPDVModuloForm = class(TPDVModuloBasForm)
    procedure PrecoPergAction_ModuloBasFormExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShopPDVModuloForm: TShopPDVModuloForm;

implementation

{$R *.dfm}

uses AppShop.UI.Form.PDV.Preco.Perg_u;

procedure TShopPDVModuloForm.PrecoPergAction_ModuloBasFormExecute(
  Sender: TObject);
begin
  inherited;
//  pAppObj: IAppObj; pTerminalId: TTerminalId
  AppShop.UI.Form.PDV.Preco.Perg_u.PrecoPerg(AppObj, TerminalId);
end;

end.
