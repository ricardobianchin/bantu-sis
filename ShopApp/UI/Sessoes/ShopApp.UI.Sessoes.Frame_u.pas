unit ShopApp.UI.Sessoes.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Sessoes.Frame_u, System.Actions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, App.UI.Sessao.Frame,
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u, Sis.Usuario,
  AppShop.UI.Form.Modulo.Config_u, ShopApp.UI.Form.Modulo.PDV_u,
  AppShop.UI.Form.Modulo.Retaguarda_u, Sis.ModuloSistema, App.Constants,
  Sis.Config.SisConfig, Sis.DB.DBTypes, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.Entities.Types;

type
  TShopSessoesFrame = class(TSessoesFrame)
  private
    { Private declarations }
  protected
    function SessaoFrameCreate(AOwner: TComponent;
      pTipoOpcaoSisModulo: TOpcaoSisIdModulo; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pSessaoIndex: TSessaoIndex; pDBMS: IDBMS;
      pOutput: IOutput; pProcessLog: IProcessLog): TSessaoFrame; override;

    function ModuloBasFormCreate(pModuloSistema: IModuloSistema;
      pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
      pTerminalId: TTerminalId): TModuloBasForm; override;
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
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId): TModuloBasForm;
begin
  case pModuloSistema.TipoOpcaoSisModulo of
    opmoduConfiguracoes:
      Result := TShopConfigModuloForm.Create(Application, pModuloSistema,
        EventosDeSessao, pSessaoIndex, pUsuario, AppObj, pTerminalId);
    opmoduRetaguarda:
      Result := TShopRetaguardaModuloForm.Create(Application, pModuloSistema,
        EventosDeSessao, pSessaoIndex, pUsuario, AppObj, pTerminalId);
    opmoduPDV:
      Result := TShopPDVModuloForm.Create(Application, pModuloSistema,
        EventosDeSessao, pSessaoIndex, pUsuario, AppObj, pTerminalId);
  else // modsisNaoIndicado:
    Result := nil;
  end;
end;

function TShopSessoesFrame.SessaoFrameCreate(AOwner: TComponent;
  pTipoOpcaoSisModulo: TOpcaoSisIdModulo; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm; pSessaoIndex: TSessaoIndex; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog): TSessaoFrame;
begin
  Result := TShopSessaoFrame.Create(AOwner, pTipoOpcaoSisModulo, pUsuario,
    pModuloBasForm, pSessaoIndex, EventosDeSessao, pDBMS, pOutput, pProcessLog);
end;

end.
