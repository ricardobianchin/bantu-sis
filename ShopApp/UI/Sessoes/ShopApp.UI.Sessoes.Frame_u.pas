unit ShopApp.UI.Sessoes.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Sessoes.Frame, System.Actions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, App.UI.Sessao.Frame,
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u, Sis.Usuario,
  AppShop.UI.Form.Modulo.Config_u, AppShop.UI.Form.Modulo.PDV_u,
  AppShop.UI.Form.Modulo.Retaguarda_u;

type
  TShopSessoesFrame = class(TSessoesFrame)
  private
    { Private declarations }
  protected
    function SessaoFrameCreate(AOwner: TComponent;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm): TSessaoFrame; override;
    function ModuloBasFormCreate(pTipoModuloSistema: TTipoModuloSistema)
      : TModuloBasForm; override;
  public
    { Public declarations }
  end;

var
  ShopSessoesFrame: TShopSessoesFrame;

implementation

{$R *.dfm}

uses ShopApp.UI.Sessao.Frame_u;

{ TShopSessoesFrame }

function TShopSessoesFrame.ModuloBasFormCreate(
  pTipoModuloSistema: TTipoModuloSistema): TModuloBasForm;
begin
  case pTipoModuloSistema of
    modsisConfiguracoes: Result := TShopConfigModuloForm.Create(Application);
    modsisRetaguarda: Result := TShopRetaguardaModuloForm.Create(Application);
    modsisPDV: Result := TShopPDVModuloForm.Create(Application);
    else Result := nil; //modsisNaoIndicado: ;
  end;
end;

function TShopSessoesFrame.SessaoFrameCreate(AOwner: TComponent;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm): TSessaoFrame;
begin
  Result := TShopSessaoFrame.Create(AOwner, pTipoModuloSistema, pUsuario,
    pModuloBasForm);
end;

end.
