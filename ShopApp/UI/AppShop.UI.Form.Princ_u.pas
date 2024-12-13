unit AppShop.UI.Form.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ.Sessoes_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Imaging.pngimage, App.AppInfo, App.UI.Sessoes.Frame,
  FireDAC.Comp.Client;

type
  TShopPrincForm = class(TSessoesPrincBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FServFDConnection: TFDConnection;
    FTermFDConnection: TFDConnection;

  protected
    function SessoesFrameCreate: TSessoesFrame; override;
    function GetAppInfoCreate: IAppInfo; override;
    procedure PreenchaAtividade; override;
    procedure PreenchaDBUpdaterVariaveis; override;
    procedure AjusteControles; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  ShopPrincForm: TShopPrincForm;

implementation

{$R *.dfm}

uses App.Factory, ShopApp.Constants, Sis.DB.Factory, App.AppInfo.Types,
  ShopApp.UI.Sessoes.Frame_u, Sis.DB.DBTypes, App.DB.Utils, Sis.Sis.Constants,
  Sis.Threads.Factory_u;

{ TShopPrincForm }

procedure TShopPrincForm.AjusteControles;
begin
end;

constructor TShopPrincForm.Create(AOwner: TComponent);
begin
  // ProcessLog.PegueAssunto('TShopPrincForm.FormCreate');
  try
    inherited;
  finally
    // ProcessLog.RetorneAssunto;
  end;
end;

destructor TShopPrincForm.Destroy;
begin
  FServFDConnection.Free;
  FTermFDConnection.Free;
  inherited;
end;

function TShopPrincForm.GetAppInfoCreate: IAppInfo;
begin
  Result := App.Factory.AppInfoCreate(Application.ExeName, ATUALIZ_ARQ_SUBPASTA,
    ATUALIZ_URL);
end;

procedure TShopPrincForm.PreenchaAtividade;
begin
  // inherited;
  AppObj.AppInfo.AtividadeEconomicaSis :=
    TAtividadeEconomicaSis.ativeconMercado;
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

procedure TShopPrincForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  // s: ISisConfig;
  sDriver: string;

  FServDBConnectionParams: TDBConnectionParams;
  FTermDBConnectionParams: TDBConnectionParams;
begin
  inherited;
  // FServDBConnectionParams := TerminalIdToDBConnectionParams
  // (TERMINAL_ID_RETAGUARDA, AppObj);
  FServDBConnectionParams.Server := 'DELPHI-BTU';
  FServDBConnectionParams.Arq :=
    'C:\Pr\app\bantu\bantu-sis\exe\dados\dados_mercado_retaguarda.fdb';
  FServDBConnectionParams.Database :=
    'DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\exe\dados\dados_mercado_retaguarda.fdb';

  // s := AppObj.SisConfig;

  FServFDConnection := TFDConnection.Create(nil);
  FServFDConnection.LoginPrompt := False;
  sDriver := 'FB';

  FServFDConnection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + FServDBConnectionParams.Server + #13#10 //
    + 'Database=' + FServDBConnectionParams.Arq + #13#10 +
    'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 + 'Protocol=TCPIP';

  FTermDBConnectionParams.Server := AppObj.TerminalList[0].IdentStr;
  FTermDBConnectionParams.Arq := AppObj.TerminalList[0].LocalArqDados;
  FTermDBConnectionParams.Database := AppObj.TerminalList[0].Database;

  FTermFDConnection := TFDConnection.Create(nil);
  FTermFDConnection.LoginPrompt := False;
  sDriver := 'FB';

  FTermFDConnection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + FTermDBConnectionParams.Server + #13#10 //
    + 'Database=' + FTermDBConnectionParams.Arq + #13#10 +
    'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 + 'Protocol=TCPIP';
end;

end.
