unit AppShop.UI.Form.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.Config_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.ModuloSistema, App.Sessao.EventosDeSessao, App.Constants, Sis.Usuario, App.AppObj,
  Sis.UI.Controls.Utils, App.DB.Import.Form_u, Sis.Entities.Types;

type
  TShopConfigModuloForm = class(TConfigModuloBasForm)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
      reintroduce;
  end;

var
  ShopConfigModuloForm: TShopConfigModuloForm;

implementation

{$R *.dfm}

uses Sis.Types, ShopApp.DB.Import.Form.PLUBase, ShopApp.DB.Import.Types_u;

{ TShopConfigModuloForm }

constructor TShopConfigModuloForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
begin
  inherited Create(AOwner, pModuloSistema, pEventosDeSessao, pSessaoIndex,
    pUsuario, pAppObj, pTerminalId);
end;

end.
