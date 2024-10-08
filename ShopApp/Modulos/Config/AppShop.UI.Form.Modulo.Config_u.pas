unit AppShop.UI.Form.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.Config_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.ModuloSistema, App.Sessao.Eventos, App.Constants, Sis.Usuario, App.AppObj,
  Sis.UI.Controls.Utils, App.DB.Import.Form_u, Sis.Entities.Types;

type
  TShopConfigModuloForm = class(TConfigModuloBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DBImportPrep; override;
    function DBImportFormCreate(pItemIndex: integer): TDBImportForm; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId); reintroduce;
  end;

var
  ShopConfigModuloForm: TShopConfigModuloForm;

implementation

{$R *.dfm}

uses Sis.Types, ShopApp.DB.Import.Form.PLUBase, ShopApp.DB.Import.Types_u;

{ TShopConfigModuloForm }

constructor TShopConfigModuloForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
begin
  inherited Create(AOwner, pModuloSistema, pSessaoEventos, pSessaoIndex,
    pUsuario, pAppObj, pTerminalId);
end;
function TShopConfigModuloForm.DBImportFormCreate(pItemIndex: integer)
  : TDBImportForm;
begin
  case pItemIndex + 1 of
    1:
      Result := TShopDBImportFormPLUBase.Create(Application, AppObj, Usuario);
  end;
end;

procedure TShopConfigModuloForm.DBImportPrep;
var
  i: integer;
begin
  inherited;
  for i := Low(MercadoImportSelectItems) to High(MercadoImportSelectItems) do
  begin
    DBImportOrigemComboBox.Items.AddObject(MercadoImportSelectItems[i].Descr,
      Pointer(MercadoImportSelectItems[i].Id));
  end;
  DBImportOrigemComboBox.ItemIndex := 0;
end;

procedure TShopConfigModuloForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//{$IFDEF DEBUG}
//  DBImportAction.Execute;
//  Application.Terminate;
//{$ENDIF}
end;

end.
