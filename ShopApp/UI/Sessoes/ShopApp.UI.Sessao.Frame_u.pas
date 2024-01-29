unit ShopApp.UI.Sessao.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Sessao.Frame, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls, Sis.Usuario,
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u;

type
  TShopSessaoFrame = class(TSessaoFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShopSessaoFrame: TShopSessaoFrame;

implementation

{$R *.dfm}

end.
