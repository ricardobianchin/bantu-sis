unit ShopApp.UI.Sessoes.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Sessoes.Frame, System.Actions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, App.UI.Sessao.Frame,
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u, Sis.Usuario,
  AppShop.UI.Form.Modulo.Config_u, AppShop.UI.Form.Modulo.PDV_u,
  AppShop.UI.Form.Modulo.Retaguarda_u, Sis.ModuloSistema, App.Constants;

type
  TShopSessoesFrame = class(TSessoesFrame)
  private
    { Private declarations }
  protected
    function SessaoFrameCreate(AOwner: TComponent;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pSessaoIndex: TSessaoIndex)
      : TSessaoFrame; override;

    function ModuloBasFormCreate(pModuloSistema: IModuloSistema;
      pSessaoIndex: TSessaoIndex): TModuloBasForm; override;
  public
    { Public declarations }
  end;

var
  ShopSessoesFrame: TShopSessoesFrame;

implementation

{$R *.dfm}

uses ShopApp.UI.Sessao.Frame_u;

{ TShopSessoesFrame }

function TShopSessoesFrame.ModuloBasFormCreate(pModuloSistema: IModuloSistema;
  pSessaoIndex: TSessaoIndex): TModuloBasForm;
begin
  case pModuloSistema.TipoModuloSistema of
    modsisNaoIndicado:
      Result := nil;
    modsisConfiguracoes:
      Result := TShopConfigModuloForm.Create(Application, pModuloSistema,
        SessaoEventos, pSessaoIndex);
    modsisRetaguarda:
      Result := TShopRetaguardaModuloForm.Create(Application, pModuloSistema,
        SessaoEventos, pSessaoIndex);
    modsisPDV:
      Result := TShopPDVModuloForm.Create(Application, pModuloSistema,
        SessaoEventos, pSessaoIndex);
  end;
end;

function TShopSessoesFrame.SessaoFrameCreate(AOwner: TComponent;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm; pSessaoIndex: TSessaoIndex): TSessaoFrame;
begin
  Result := TShopSessaoFrame.Create(AOwner, pTipoModuloSistema, pUsuario,
    pModuloBasForm, pSessaoIndex, SessaoEventos);
end;

end.
