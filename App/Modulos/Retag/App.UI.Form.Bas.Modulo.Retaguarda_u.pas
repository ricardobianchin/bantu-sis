unit App.UI.Form.Bas.Modulo.Retaguarda_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.Types.Contador,
  App.UI.Form.Bas.TabSheet_u, App.UI.Form.Bas.TabSheet.DataSet_u, Sis.Loja,
  Sis.UI.IO.Output, Sis.ModuloSistema, App.Sessao.Eventos, App.Constants,
  Sis.Usuario, App.AppInfo, Sis.Config.SisConfig, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.FormCreator, App.AppObj,
  Sis.Entities.Types,
  App.Retag.Est.Factory, App.Ent.Ed, App.Ent.DBI, Sis.Entidade

    , App.Retag.Est.Prod.Fabr.Ent //
    , App.Retag.Est.Prod.Tipo.Ent //
    , App.Retag.Est.Prod.Unid.Ent //
    , App.Retag.Est.Prod.ICMS.Ent //
    , App.Retag.Est.Prod.Ent //

    , App.Retag.Est.Prod.Barras.Ent.List //
    , App.Retag.Est.Prod.Balanca.Ent //
    , App.Retag.Aju.VersaoDB.Ent //
    , App.Acesso.PerfilDeUso.DBI //
    , App.Acesso.PerfilDeUso.Ent //

    ;

type
  TRetaguardaModuloBasForm = class(TModuloBasForm)
    RetagActionList: TActionList;
    MenuPanel: TPanel;
    MenuPageControl: TPageControl;
    EstoqueTabSheet: TTabSheet;
    AjudaTabSheet: TTabSheet;
    PageControl1: TPageControl;

    RetagAjuBemAction: TAction;

    RetagEstProdAction: TAction;
    RetagEstProdFabrAction: TAction;
    RetagEstProdTipoAction: TAction;
    RetagEstProdUnidAction: TAction;

    RetagEstProdEnviarTermAction: TAction;

    BalloonHint1: TBalloonHint;
    AjudaToolBar: TToolBar;
    AjuBemToolButton: TToolButton;
    RetagEstProdICMSAction: TAction;
    ProdTabsTabSheet: TTabSheet;
    ToolBar5: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Estoque1: TMenuItem;
    Estoque2: TMenuItem;
    Configuraes1: TMenuItem;
    Produtos1: TMenuItem;
    Fabricantes1: TMenuItem;
    Setores1: TMenuItem;
    Unidades1: TMenuItem;
    ICMS1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    OcultarActionModuloBasForm1: TMenuItem;
    Fechar1: TMenuItem;
    Preos1: TMenuItem;
    Entradadenotas1: TMenuItem;
    Entradadenotas2: TMenuItem;
    Inventrios1: TMenuItem;
    Baixa1: TMenuItem;
    Balanas1: TMenuItem;
    Estabelecimento1: TMenuItem;
    PerfisdeUsurio1: TMenuItem;
    Usurios1: TMenuItem;
    N3: TMenuItem;
    Cadastro2: TMenuItem;
    Cadastro3: TMenuItem;
    Relatrios1: TMenuItem;
    Acesso1: TMenuItem;
    Produtos2: TMenuItem;
    N4: TMenuItem;
    Preos2: TMenuItem;
    Fabricantes2: TMenuItem;
    Setores2: TMenuItem;
    Unidades2: TMenuItem;
    ICMS2: TMenuItem;
    EntradadeNotas3: TMenuItem;
    EntradadeNotas4: TMenuItem;
    Inventrio1: TMenuItem;
    Inventrio2: TMenuItem;
    PerfildeUso1: TMenuItem;
    Usurios2: TMenuItem;
    DireitosdeAcesso1: TMenuItem;
    ToolBar4: TToolBar;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton2: TToolButton;
    FinTabSheet: TTabSheet;
    FinToolBar: TToolBar;
    PagamentoFormaToolButton: TToolButton;
    FinanceiroPagamentoFormaAction: TAction;
    AcessoTabSheet: TTabSheet;
    AcessoToolBar: TToolBar;
    FuncToolButton: TToolButton;
    RetagAcessoFuncAction: TAction;
    RetagAjuVersaoDBAction: TAction;
    AjuVersaoDBToolButton: TToolButton;
    RetagAcessoPerfilAction: TAction;
    PerfilToolButton: TToolButton;
    ToolButton8: TToolButton;
    RetagEstVenClienteAction: TAction;

    procedure FormDestroy(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure MenuPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);

    // Aju
    procedure RetagAjuBemActionExecute(Sender: TObject);
    procedure RetagAjuVersaoDBActionExecute(Sender: TObject);

    // Est

    // EstProd
    procedure RetagEstProdFabrActionExecute(Sender: TObject);
    procedure RetagEstProdTipoActionExecute(Sender: TObject);
    procedure RetagEstProdUnidActionExecute(Sender: TObject);
    procedure RetagEstProdICMSActionExecute(Sender: TObject);

    procedure RetagEstProdActionExecute(Sender: TObject);
    procedure RetagEstProdEnviarTermActionExecute(Sender: TObject);
    procedure FinanceiroPagamentoFormaActionExecute(Sender: TObject);
    procedure RetagAcessoFuncActionExecute(Sender: TObject);
    procedure RetagAcessoPerfilActionExecute(Sender: TObject);
    procedure RetagEstVenClienteActionExecute(Sender: TObject);
  private
    { Private declarations }
    FFormClassNamesSL: TStringList;
    FContador: IContador;
    FOutputNotify: IOutput;

    // aju
    FAjuBemVindoTabSheetFormCreator: IFormCreator;
    FAjuVersaoDBTabSheetFormCreator: IFormCreator;

    // ace
    FAcessoPerfilTabSheetFormCreator: IFormCreator;
    FAcessoFuncionarioTabSheetFormCreator: IFormCreator;

    // est
    FFabrDataSetFormCreator: IFormCreator;
    FProdTipoDataSetFormCreator: IFormCreator;
    FProdUnidDataSetFormCreator: IFormCreator;
    FProdICMSDataSetFormCreator: IFormCreator;
    FProdDataSetFormCreator: IFormCreator;

    // est ven
    FClienteDataSetFormCreator: IFormCreator;

    // fin
    FPagFormaDataSetFormCreator: IFormCreator;

    // abre form
    // tab crie
    procedure TabSheetCrie(pFormCreator: IFormCreator);

    procedure CreateIniciais;
    procedure CreateFormCreator(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pDBConnection: IDBConnection);
    procedure CreateFormCreatorAju(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pDBConnection: IDBConnection);
    procedure CreateFormCreatorAcesso(pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBConnection: IDBConnection);
    procedure CreateFormCreatorProd(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pDBConnection: IDBConnection);
    procedure CreateFormCreatorFin(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pDBConnection: IDBConnection);

    procedure TestaTesteConfig;
    procedure TestaTesteConfig_Acesso;
    procedure TestaTesteConfig_Est;
    procedure TestaTesteConfig_Ajuda;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
      reintroduce;
  end;

var
  RetaguardaModuloBasForm: TRetaguardaModuloBasForm;

implementation

{$R *.dfm}

uses App.UI.Retaguarda.ImgDM_u, Sis.Types.Factory, System.Types,
  Sis.Types.strings_u, Sis.UI.IO.Factory, App.DB.Utils, Sis.DB.Factory,
  App.Retag.Aju.Factory, App.Retag.Fin.Factory,
  App.Fin.PagFormaTipo, App.Acesso.PerfilDeUso.Ent.Factory_u,
  App.Acesso.PerfilDeUso.UI.Factory_u, App.UI.Form.DataSet.Pess.Cliente_u,
  App.Acesso.Cliente.UI.Factory_u, App.Acesso.Funcionario.UI.Factory_u,
  Sis.Sis.Constants;

constructor TRetaguardaModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
var
  oAppObj: IAppObj;
  oAppInfo: IAppInfo;
  oSisConfig: ISisConfig;

  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  inherited Create(AOwner, pModuloSistema, pSessaoEventos, pSessaoIndex,
    pUsuario, pAppObj, pTerminalId);

  CreateIniciais;

  MenuPageControl.ActivePage := EstoqueTabSheet;

  oAppObj := AppObj;
  oAppInfo := AppInfo;
  oSisConfig := SisConfig;

  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppInfo, SisConfig);

  oDBConnection := DBConnectionCreate('Retag.Conn', SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  CreateFormCreator(AppInfo, SisConfig, oDBConnection);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreator(pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pDBConnection: IDBConnection);
begin
  CreateFormCreatorAju(pAppInfo, pSisConfig, pDBConnection);
  CreateFormCreatorAcesso(pAppInfo, pSisConfig, pDBConnection);
  CreateFormCreatorProd(pAppInfo, pSisConfig, pDBConnection);
  CreateFormCreatorFin(pAppInfo, pSisConfig, pDBConnection);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorAcesso(pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pDBConnection: IDBConnection);
begin

  FAcessoPerfilTabSheetFormCreator := PerfilDeUsoDataSetFormCreatorCreate
    (FFormClassNamesSL, pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

  FAcessoFuncionarioTabSheetFormCreator := FuncionarioDataSetFormCreatorCreate
    (FFormClassNamesSL, AppObj, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorAju(pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pDBConnection: IDBConnection);
var
  oVersaoDBEnt: IVersaoDBEnt;
  oVersaoDBDBI: IEntDBI;

begin
  // aju bem-vindo
  FAjuBemVindoTabSheetFormCreator := AjuBemVindoSetFormCreatorCreate
    (FFormClassNamesSL, pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

  // aju versao
  oVersaoDBEnt := RetagEstVersaoDBEntCreate;
  oVersaoDBDBI := RetagAjuVersaoDBDBICreate(pDBConnection, oVersaoDBEnt);

  FAjuVersaoDBTabSheetFormCreator := AjuVersaoDBDataSetFormCreatorCreate
    (FFormClassNamesSL, pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify, oVersaoDBEnt, oVersaoDBDBI, AppObj);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorFin(pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pDBConnection: IDBConnection);
var
  oPagFormaTipo: IPagFormaTipo;
  oPagFormaEnt: IEntEd;
  oPagFormaDBI: IEntDBI;
begin

  // pPagFormaTipo: IPagFormaTipo
  oPagFormaTipo := PagFormaTipoCreate;

  oPagFormaEnt := RetagFinPagFormaEntCreate(AppObj.Loja.Id, Usuario.Id,
    pSisConfig.ServerMachineId.IdentId, oPagFormaTipo);
  oPagFormaDBI := RetagFinPagFormaDBICreate(pDBConnection, oPagFormaEnt);

  // fin pag forma
  FPagFormaDataSetFormCreator := PagFormaDataSetFormCreatorCreate
    (FFormClassNamesSL, pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify, oPagFormaEnt, oPagFormaDBI, AppObj);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorProd(pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pDBConnection: IDBConnection);
var
  oFabrEnt: IProdFabrEnt;
  oFabrDBI: IEntDBI;

  oTipoEnt: IProdTipoEnt;
  oTipoDBI: IEntDBI;

  oUnidEnt: IProdUnidEnt;
  oUnidDBI: IEntDBI;

  oICMSEnt: IProdICMSEnt;
  oICMSDBI: IEntDBI;

  oProdBarrasList: IProdBarrasList;
  oProdBalancaEnt: IProdBalancaEnt;

  oProdEnt: IProdEnt;
  oProdDBI: IEntDBI;
begin
  oFabrEnt := RetagEstProdFabrEntCreate;
  oFabrDBI := RetagEstProdFabrDBICreate(pDBConnection, oFabrEnt);

  FFabrDataSetFormCreator := FabrDataSetFormCreatorCreate(FFormClassNamesSL,
    pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog, FOutputNotify,
    oFabrEnt, oFabrDBI, AppObj);

  oTipoEnt := RetagEstProdTipoEntCreate;
  oTipoDBI := RetagEstProdTipoDBICreate(pDBConnection, oTipoEnt);

  FProdTipoDataSetFormCreator := ProdTipoDataSetFormCreatorCreate
    (FFormClassNamesSL, pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify, oTipoEnt, oTipoDBI, AppObj);

  oUnidEnt := RetagEstProdUnidEntCreate;
  oUnidDBI := RetagEstProdUnidDBICreate(pDBConnection, oUnidEnt);

  FProdUnidDataSetFormCreator := ProdUnidDataSetFormCreatorCreate
    (FFormClassNamesSL, pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify, oUnidEnt, oUnidDBI, AppObj);

  oICMSEnt := RetagEstProdICMSEntCreate;
  oICMSDBI := RetagEstProdICMSDBICreate(pDBConnection, oICMSEnt);

  FProdICMSDataSetFormCreator := ProdICMSDataSetFormCreatorCreate
    (FFormClassNamesSL, pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify, oICMSEnt, oICMSDBI, AppObj);

  oProdBarrasList := ProdBarrasListCreate;
  oProdBalancaEnt := ProdBalancaEntCreate;

  oProdEnt := RetagEstProdEntCreate(AppObj.Loja.Id, Usuario.Id,
    pSisConfig.ServerMachineId.IdentId, oFabrEnt, oTipoEnt, oUnidEnt, oICMSEnt,
    oProdBarrasList, oProdBalancaEnt);
  oProdDBI := RetagEstProdDBICreate(pDBConnection, oProdEnt);

  FProdDataSetFormCreator := ProdDataSetFormCreatorCreate(FFormClassNamesSL,
    pAppInfo, pSisConfig, Usuario, DBMS, Output, ProcessLog, FOutputNotify,
    oProdEnt, oProdDBI, AppObj);

  FClienteDataSetFormCreator := ClienteDataSetFormCreatorCreate
    (FFormClassNamesSL, AppObj, pSisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify);
end;

procedure TRetaguardaModuloBasForm.CreateIniciais;
begin
  if not Assigned(RetagImgDM) then
  begin
    RetagImgDM := TRetagImgDM.Create(Application);
  end;
  FOutputNotify := BalloonHintOutputCreate(BalloonHint1);

  FFormClassNamesSL := TStringList.Create;
  FContador := ContadorCreate;
end;

procedure TRetaguardaModuloBasForm.FinanceiroPagamentoFormaActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FPagFormaDataSetFormCreator);

end;

procedure TRetaguardaModuloBasForm.FormDestroy(Sender: TObject);
begin
  FFormClassNamesSL.Free;
  inherited;
end;

procedure TRetaguardaModuloBasForm.MenuPageControlDrawTab
  (Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
var
  vRect: TRect;
  sTexto: string;
begin
  inherited;
  vRect := Rect;
  vRect.Top := vRect.Top + 2;
  Control.Canvas.Pen.Style := psClear;
  Control.Canvas.Brush.Style := bsClear;
  // Control.Canvas.Font.Color := clBlack;
  if Active then
  begin
    // Control.Canvas.Brush.Color := RGB(230, 230, 230);
    Control.Canvas.Rectangle(vRect);
    // Control.Canvas.Pen.Style := psSolid;
    Control.Canvas.Font.Color := RGB(230, 230, 230);
    Control.Canvas.Font.Style := [TFontStyle.fsUnderline];
  end
  else
  begin
    // Control.Canvas.Brush.Color := RGB(204, 204, 204);
    Control.Canvas.Rectangle(vRect);
    // Control.Canvas.Pen.Style := psSolid;
    // Control.Canvas.Font.Color := clBlack;
    Control.Canvas.Font.Color := RGB(204, 204, 204);
  end;
  sTexto := TTabControl(Control).Tabs[TabIndex];
  Control.Canvas.TextRect(vRect, sTexto, [tfCenter, tfVerticalCenter]);
end;

procedure TRetaguardaModuloBasForm.RetagAcessoFuncActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FAcessoFuncionarioTabSheetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagAcessoPerfilActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FAcessoPerfilTabSheetFormCreator);

end;

procedure TRetaguardaModuloBasForm.RetagAjuBemActionExecute(Sender: TObject);
begin
  inherited;
  TabSheetCrie(FAjuBemVindoTabSheetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagAjuVersaoDBActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FAjuVersaoDBTabSheetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdActionExecute(Sender: TObject);
begin
  inherited;
  TabSheetCrie(FProdDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdEnviarTermActionExecute
  (Sender: TObject);
begin
  inherited;
  //
end;

procedure TRetaguardaModuloBasForm.RetagEstProdFabrActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FFabrDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdICMSActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FProdICMSDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdTipoActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FProdTipoDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdUnidActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FProdUnidDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstVenClienteActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FClienteDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  RetagAjuBemAction.Execute;
  TestaTesteConfig;
  // RetagEstProdICMSAction.Execute;
  // sleep(150);
  // RetagEstProdFabrAction.Execute;
  // RetagEstProdAction.Execute;

  // MenuPageControl.ActivePage := EstoqueTabSheet;
  // FinanceiroPagamentoFormaAction.Execute
end;

procedure TRetaguardaModuloBasForm.TabSheetCrie(pFormCreator: IFormCreator
  { pFunctionTabSheetGetClassName
    : TFunctionTabSheetGetClassName;
    pFunctionTabSheetFormCreate: TFunctionTabSheetFormCreate } );
var
  oTabSheet: TTabSheet;
  // oTabSheetBasForm: TTabSheetAppBasForm;
  oForm: TForm;
  // HintPoint: TPoint;
  sFormClassName: string;
  // iPageIndex: Integer;
  // oTRect: TRect;
  iExistenteIndex: Integer;

  oFormOwner: TComponent;
  oAppInfo: IAppInfo;
  oSisConfig: ISisConfig;
begin
  sFormClassName := pFormCreator.FormClassName;

  iExistenteIndex := FFormClassNamesSL.IndexOf(sFormClassName);
  if iExistenteIndex > -1 then
  begin
    oTabSheet := TTabSheet(FFormClassNamesSL.Objects[iExistenteIndex]);
    PageControl1.ActivePage := oTabSheet;

    // iPageIndex := PageControl1.ActivePageIndex;
    // HintPoint := Mouse.CursorPos;
    // oTRect := PageControl1.TabRect(iPageIndex);
    // HintPoint := CenterPoint(oTRect);

    // if HintPoint.X < 20 then
    // HintPoint.X := 20;
    // Dec(HintPoint.Y, 3);

    FOutputNotify.Exibir('Op��o j� aberta');

    exit;
  end;

  oTabSheet := TTabSheet.Create(PageControl1);
  oTabSheet.PageControl := PageControl1;
  oTabSheet.Name := sFormClassName + 'TabSheet';
  PageControl1.ActivePage := oTabSheet;

  oFormOwner := oTabSheet;

  oAppInfo := AppInfo;
  oSisConfig := SisConfig;

  // oTabSheetBasForm := FFabrDataSetFormCreator.FormCreate(oFormOwner);
  oForm := pFormCreator.FormCreate(oFormOwner);
  // pFunctionTabSheetFormCreate(oFormOwner, FFormClassNamesSL,
  // oAppInfo, oSisConfig, DBMS, Output, ProcessLog, FOutputNotify);
  oForm.Parent := oTabSheet;

  FFormClassNamesSL.AddObject(sFormClassName, oTabSheet);

  oTabSheet.Caption := pFormCreator.Titulo;
  oForm.Show;
end;

procedure TRetaguardaModuloBasForm.TestaTesteConfig;
begin
  TestaTesteConfig_Acesso;
  TestaTesteConfig_Est;
  TestaTesteConfig_Ajuda;
end;

procedure TRetaguardaModuloBasForm.TestaTesteConfig_Acesso;
var
  bDeveExecutar: Boolean;
begin
  bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Acesso.PerfilDeUso.AutoExec;

  if bDeveExecutar then
  begin
    MenuPageControl.ActivePage := AcessoTabSheet;
    RetagAcessoPerfilAction.Execute;
  end;

  bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Acesso.Funcionario.AutoExec;

  if bDeveExecutar then
  begin
    MenuPageControl.ActivePage := AcessoTabSheet;
    RetagAcessoFuncAction.Execute;
  end;
end;

procedure TRetaguardaModuloBasForm.TestaTesteConfig_Ajuda;
//var
//  bDeveExecutar: Boolean;
begin
//  bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Ajuda.BemVindo.
//    Terminais.AutoExec;
//
//  if bDeveExecutar then
//  begin
//    MenuPageControl.ActivePage := AjudaTabSheet;
//  end;
end;

procedure TRetaguardaModuloBasForm.TestaTesteConfig_Est;
var
  bDeveExecutar: Boolean;
begin
  bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Est.Cliente.AutoExec;

  if bDeveExecutar then
  begin
    MenuPageControl.ActivePage := EstoqueTabSheet;
    RetagEstVenClienteAction.Execute;
  end;
end;

end.
