unit AppShop.UI.Form.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ.Sessoes_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Imaging.pngimage, App.AppInfo, App.UI.Sessoes.Frame;

type
  TShopPrincForm = class(TSessoesPrincBasForm)
  private
    { Private declarations }
  protected
    function SessoesFrameCreate: TSessoesFrame; override;
    function GetAppInfoCreate: IAppInfo; override;
    procedure PreenchaAtividade; override;
    procedure PreenchaDBUpdaterVariaveis; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  ShopPrincForm: TShopPrincForm;

implementation

{$R *.dfm}

uses App.Factory, ShopApp.Constants, ShopApp.UI.Sessoes.Frame_u, App.AppInfo.Types;

{ TShopPrincForm }

constructor TShopPrincForm.Create(AOwner: TComponent);
begin
  inherited;
  ProcessLog.PegueAssunto('TShopPrincForm.FormCreate');
  try
  finally
    ProcessLog.RetorneAssunto;
  end;
end;

function TShopPrincForm.GetAppInfoCreate: IAppInfo;
begin
  Result := App.Factory.AppInfoCreate(Application.ExeName,
    ATUALIZ_ARQ_SUBPASTA, ATUALIZ_URL);
end;

procedure TShopPrincForm.PreenchaAtividade;
begin
//  inherited;
  AppObj.AppInfo.SisTipoAtividade := TSisTipoAtividade.stativMercado;
end;

procedure TShopPrincForm.PreenchaDBUpdaterVariaveis;
begin
  inherited;
  DBUpdaterVariaveis := 'USA_TABPRECO=N'#13#10'USA_NATU=N'#13#10;
end;

function TShopPrincForm.SessoesFrameCreate: TSessoesFrame;
begin
  Result := TShopSessoesFrame.Create(Self, LoginConfig, Self, AppObj);
end;

end.
