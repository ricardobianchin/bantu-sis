unit AppShop.UI.Form.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.DB.DBTypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ.Sessoes_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Imaging.pngimage, App.AppInfo, App.AppObj,
  App.UI.Sessoes.Frame_u, FireDAC.Comp.Client, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, App.DB.Bak, Sis.Sis.Executavel, Sis.Web.Factory, Vcl.Menus;

type
  TShopPrincForm = class(TSessoesPrincBasForm)
  private
    { Private declarations }

  protected
    function ExeParamsDecida: Boolean; override;
    function SessoesFrameCreate: TSessoesFrame; override;
    function GetAppInfoCreate: IAppInfo; override;
    procedure PreenchaAtividade; override;
    procedure PreenchaDBUpdaterVariaveis; override;
    procedure AssistAbrir; override;

    function AppBakCreate(pAppObj: IAppObj; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog): IAppBak; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  ShopPrincForm: TShopPrincForm;

implementation

{$R *.dfm}

uses App.Factory, ShopApp.Constants, Sis.DB.Factory, App.AppInfo.Types,
  ShopApp.UI.Sessoes.Frame_u, App.DB.Utils, Sis.Sis.Constants,
  Sis.Threads.Factory_u, Sis.Win.Utils_u, ShopApp.DB.Bak_u, Sis.Web.FTP.Frame_u;

{ TShopPrincForm }

function TShopPrincForm.AppBakCreate(pAppObj: IAppObj; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog): IAppBak;
begin
  Result := TShopAppBak.Create(pAppObj, pDBMS, pOutput, pProcessLog);
end;

procedure TShopPrincForm.AssistAbrir;
var
  sPasta, sParams, sNomeArq, sErro: string;
begin
  inherited;
  sPasta := AppObj.AppInfo.PastaBin;
  sParams := '';
  sNomeArq := sPasta + 'ShopAssist.exe';

  ExecutePrograma(sNomeArq, sParams, sPasta, sErro);
end;

constructor TShopPrincForm.Create(AOwner: TComponent);
begin
  // ProcessLog.PegueAssunto('TShopPrincForm.FormCreate');
  try
    inherited;
    if Application.Terminated then
      exit;

    if PrecisaFechar then
      Application.Terminate;

  finally
    // ProcessLog.RetorneAssunto;
  end;
end;

function TShopPrincForm.ExeParamsDecida: Boolean;
var
  sArqLocal: string;
  sArqRemoto: string;
  sNomeArq: string;
  sGuid: string;
  bExluiDestinoAntes: Boolean;
  oUpload: IExecutavel;
  bErroDeu: Boolean;
  sErroMens: string;
begin
  if ParamCount < 2 then
  begin
    Result := inherited;
    exit;
  end;

  if AnsiLowerCase(ParamStr(1)) = 'upbak' then
  begin
    sArqLocal := ParamStr(2);

    if not FileExists(sArqLocal) then
      exit;

    sNomeArq := ExtractFileName(sArqLocal);
    sGuid := AppInfo.PessoaDonoGuid;
    bExluiDestinoAntes := False;
    sArqRemoto := Format(BACKUP_URL, [sGuid, sNomeArq]);

//    oUpload := HTTPUploadCreate(sArqLocal, sArqRemoto, bExluiDestinoAntes,
//      nil, nil);
//    oUpload.Execute;

    Sis.Web.FTP.Frame_u.Put(sArqLocal, sArqRemoto, bErroDeu, sErroMens);
    exit;
  end;

  Result := inherited;
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
  DBUpdaterVariaveis := DBUpdaterVariaveis + 'USA_TABPRECO=N'#13#10;
  // 'USA_TABPRECO=N'#13#10'USA_NATU=N'#13#10;
end;

function TShopPrincForm.SessoesFrameCreate: TSessoesFrame;
begin
  Result := TShopSessoesFrame.Create(Self, LoginConfig, AppObj);
end;

end.
