unit AppShop.UI.Form.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
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
    procedure GerFormInicializar; override;

    procedure AjusteControles; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  ShopPrincForm: TShopPrincForm;

implementation

{$R *.dfm}

uses App.Factory, ShopApp.Constants, ShopApp.UI.Sessoes.Frame_u,Sis.DB.Factory,
  App.AppInfo.Types, ShopApp.Ger.GerForm_u, Sis.DB.DBTypes, App.DB.Utils,
  Sis.Sis.Constants, App.Ger.GerForm.DBI, App.Ger.Factory,
  Sis.DB.DBConfig.Factory_u, Sis.DB.DBConfigDBI;

{ TShopPrincForm }

procedure TShopPrincForm.AjusteControles;
var
  PrincPosDir: integer;
  GerPosDir: integer;
begin
  inherited;
  GerenciadorDeTarefasCentralizarAction_PrincBasForm.Execute;
  PrincPosDir := Left + Width;
  GerForm.Left := PrincPosDir + 1;

  GerPosDir := GerForm.Left + GerForm.Width;
  if GerPosDir > Screen.Width then
    GerForm.Left := Screen.Width - GerForm.Width;

  if GerForm.AutoOpen then
    GerForm.Show;
end;

constructor TShopPrincForm.Create(AOwner: TComponent);
begin
  inherited;
  ProcessLog.PegueAssunto('TShopPrincForm.FormCreate');
  try
  finally
    ProcessLog.RetorneAssunto;
  end;
end;

procedure TShopPrincForm.GerFormInicializar;
var
  rDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  oDBConfigDBI: IDBConfigDBI;
  oGerFormDBI: IGerFormDBI;
begin
  // inherited;
  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  oDBConnection := DBConnectionCreate('App.GerForm.CarregConfig.conn',
    AppObj.SisConfig, rDBConnectionParams, nil, nil);

  oDBConfigDBI := DBConfigDBICreate(oDBConnection);
  oGerFormDBI := GerFormDBICreate(oDBConnection, oDBConfigDBI);

  GerForm := TGerShopAppForm.Create(Self, oGerFormDBI);
end;

function TShopPrincForm.GetAppInfoCreate: IAppInfo;
begin
  Result := App.Factory.AppInfoCreate(Application.ExeName, ATUALIZ_ARQ_SUBPASTA,
    ATUALIZ_URL);
end;

procedure TShopPrincForm.PreenchaAtividade;
begin
  // inherited;
  AppObj.AppInfo.AtividadeEconomicaSis := TAtividadeEconomicaSis.stativMercado;
end;

procedure TShopPrincForm.PreenchaDBUpdaterVariaveis;
begin
  inherited;
  {
    classe mae preenche algo em DBUpdaterVariaveis
    geralmente aqui se faz:
    DBUpdaterVariaveis := DBUpdaterVariaveis + '...';
    ao invés de
    DBUpdaterVariaveis := '...';
    toda entrada precisa terminar com #13#10 pois alimentará TStrings.Text
  }
  DBUpdaterVariaveis := DBUpdaterVariaveis +
    'USA_TABPRECO=N'#13#10'USA_NATU=N'#13#10;
end;

function TShopPrincForm.SessoesFrameCreate: TSessoesFrame;
begin
  Result := TShopSessoesFrame.Create(Self, LoginConfig, Self, AppObj);
end;

end.
