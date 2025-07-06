unit App.UI.Form.Bas.Modulo.Retaguarda_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.Types.Contador,
  App.UI.Form.Bas.TabSheet_u, App.UI.Form.Bas.TabSheet.DataSet_u, Sis.Loja,
  Sis.UI.IO.Output, Sis.ModuloSistema, App.Sessao.EventosDeSessao,
  App.Constants,
  Sis.Usuario, App.AppObj, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.FormCreator,
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
    EstAuxTabSheet: TTabSheet;
    EstAuxToolBar: TToolBar;
    AuxFabrToolButton: TToolButton;
    AuxTipoToolButton: TToolButton;
    AuxUnidToolButton: TToolButton;
    AuxIcmsToolButton: TToolButton;
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
    EstoqueToolBar: TToolBar;
    EstEntrToolButton: TToolButton;
    EstVenToolButton: TToolButton;
    EstProdToolButton: TToolButton;
    FinTabSheet: TTabSheet;
    FinanceiroToolBar: TToolBar;
    PagamentoFormaToolButton: TToolButton;
    AcessoTabSheet: TTabSheet;
    AcessoToolBar: TToolBar;
    FuncToolButton: TToolButton;
    RetagAcessoFuncAction: TAction;
    RetagAjuVersaoDBAction: TAction;
    AjuVersaoDBToolButton: TToolButton;
    RetagAcessoPerfilAction: TAction;
    PerfilToolButton: TToolButton;
    EstCliToolButton: TToolButton;
    RetagEstVenClienteAction: TAction;
    FinanceiroDespesaTipoToolButton: TToolButton;

    FinanceiroPagamentoFormaAction: TAction;
    FinanceiroDespesaTipoAction: TAction;
    ToolButton12: TToolButton;
    RetagAjuVersaoSisAction: TAction;
    EstFornecedorToolButton: TToolButton;
    RetagEstEntFornecedorAct: TAction;
    AuxEstSaiMotivosToolButton: TToolButton;
    RetagEstSaiMotivoAction: TAction;
    EstSaidaToolButton: TToolButton;
    RetagEstSaidaAct: TAction;
    RetagEstEntradaAction: TAction;
    RetagEstInventarioAction: TAction;
    EstInventarioToolButton: TToolButton;
    EstSaldoToolButton: TToolButton;
    RetagEstSaldoAct: TAction;
    EstPromoToolButton: TToolButton;
    RetagEstPromoAct: TAction;

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
    procedure FinanceiroDespesaTipoActionExecute(Sender: TObject);
    procedure RetagAjuVersaoSisActionExecute(Sender: TObject);
    procedure RetagEstEntFornecedorActExecute(Sender: TObject);
    procedure RetagEstSaidaActExecute(Sender: TObject);
    procedure RetagEstEntradaActionExecute(Sender: TObject);
    procedure RetagEstInventarioActionExecute(Sender: TObject);
    procedure RetagEstSaldoActExecute(Sender: TObject);
    procedure RetagEstPromoActExecute(Sender: TObject);
  private
    { Private declarations }
    FFormClassNamesSL: TStringList;
    FContador: IContador;
    FOutputNotify: IOutput;

    // aju
    FAjuBemVindoTabSheetFormCreator: IFormCreator;
    FAjuVersaoDBTabSheetFormCreator: IFormCreator;
    FAjuVersaoSisFormCreator: IFormCreator;

    // ace
    FAcessoPerfilTabSheetFormCreator: IFormCreator;
    FAcessoFuncionarioTabSheetFormCreator: IFormCreator;

    // est aux
    FFabrDataSetFormCreator: IFormCreator;
    FProdTipoDataSetFormCreator: IFormCreator;
    FProdUnidDataSetFormCreator: IFormCreator;
    FProdICMSDataSetFormCreator: IFormCreator;

    // est
    FProdDataSetFormCreator: IFormCreator;
    FClienteDataSetFormCreator: IFormCreator;
    FFornecedorDataSetFormCreator: IFormCreator;
    FEstSaidaDataSetFormCreator: IFormCreator;
    FEstEntradaDataSetFormCreator: IFormCreator;
    FEstPromoDataSetFormCreator: IFormCreator;
    FEstInventarioDataSetFormCreator: IFormCreator;

    // fin
    FPagFormaDataSetFormCreator: IFormCreator;
    FDespTipoDataSetFormCreator: IFormCreator;

    // abre form
    // tab crie
    procedure TabSheetCrie(pFormCreator: IFormCreator);

    procedure CreateIniciais;
    procedure CreateFormCreator(pAppObj: IAppObj; pDBConnection: IDBConnection);
    procedure CreateFormCreatorAju(pAppObj: IAppObj;
      pDBConnection: IDBConnection);
    procedure CreateFormCreatorAcesso(pAppObj: IAppObj;
      pDBConnection: IDBConnection);
    procedure CreateFormCreatorProd(pAppObj: IAppObj;
      pDBConnection: IDBConnection);
    procedure CreateFormCreatorFin(pAppObj: IAppObj;
      pDBConnection: IDBConnection);

    procedure TestaTesteConfig;
    procedure TestaTesteConfig_Acesso;
    procedure TestaTesteConfig_Est;
    procedure TestaTesteConfig_Fin;
    procedure TestaTesteConfig_Ajuda;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
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
  Sis.Sis.Constants, App.Acesso.Fornecedor.UI.Factory_u,
  App.Pess.Fornecedor.Ent.Factory_u,
  App.Retag.Est.EstSaida.DBI, App.Retag.Est.EstSaida.Ent,
  App.Retag.Est.Inventario.DBI, App.Retag.Est.Inventario.Ent,
  App.Retag.Est.Entrada.Ent, App.Retag.Est.Entrada.DBI, App.Est.Promo.DBI,
  App.Est.Promo.Ent, App.UI.Form.DataSet.Est.Promo_u,
  App.UI.Form.Ed.Est.Promo_u;

constructor TRetaguardaModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
var
  oAppObj: IAppObj;

  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  inherited Create(AOwner, pModuloSistema, pEventosDeSessao, pSessaoIndex,
    pUsuario, pAppObj, pTerminalId);

  CreateIniciais;

  MenuPageControl.ActivePage := EstoqueTabSheet;

  oAppObj := AppObj;

  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  oDBConnection := DBConnectionCreate('Retag.Conn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  CreateFormCreator(AppObj, oDBConnection);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreator(pAppObj: IAppObj;
  pDBConnection: IDBConnection);
begin
  CreateFormCreatorAju(AppObj, pDBConnection);
  CreateFormCreatorAcesso(AppObj, pDBConnection);
  CreateFormCreatorProd(AppObj, pDBConnection);
  CreateFormCreatorFin(AppObj, pDBConnection);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorAcesso(pAppObj: IAppObj;
  pDBConnection: IDBConnection);
begin

  FAcessoPerfilTabSheetFormCreator := PerfilDeUsoDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

  FAcessoFuncionarioTabSheetFormCreator := FuncionarioDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorAju(pAppObj: IAppObj;
  pDBConnection: IDBConnection);
var
  oVersaoDBEnt: IVersaoDBEnt;
  oVersaoDBDBI: IEntDBI;

begin
  // aju bem-vindo
  FAjuBemVindoTabSheetFormCreator := AjuBemVindoSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

  // aju versao
  oVersaoDBEnt := RetagEstVersaoDBEntCreate;
  oVersaoDBDBI := RetagAjuVersaoDBDBICreate(pDBConnection, oVersaoDBEnt);

  FAjuVersaoDBTabSheetFormCreator := AjuVersaoDBDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oVersaoDBEnt, oVersaoDBDBI, AppObj);

  FAjuVersaoSisFormCreator := AjuVersaoSisFormCreatorCreate(FFormClassNamesSL,
    LogUsuario, DBMS, Output, ProcessLog, FOutputNotify, AppObj);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorFin(pAppObj: IAppObj;
  pDBConnection: IDBConnection);
var
  oPagFormaTipo: IPagFormaTipo;
  oPagFormaEnt: IEntEd;
  oPagFormaDBI: IEntDBI;

  oDespTipoEnt: IEntEd;
  oDespTipoDBI: IEntDBI;
begin

  // pPagFormaTipo: IPagFormaTipo
  oPagFormaTipo := PagFormaTipoCreate;

  oPagFormaEnt := RetagFinPagFormaEntCreate(AppObj.Loja.Id, LogUsuario.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId, oPagFormaTipo);
  oPagFormaDBI := RetagFinPagFormaDBICreate(pDBConnection, oPagFormaEnt);

  // fin pag forma
  FPagFormaDataSetFormCreator := PagFormaDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oPagFormaEnt, oPagFormaDBI, AppObj);

  // fin desp tipo
  oDespTipoEnt := RetagFinDespTipoEntCreate(AppObj.Loja.Id, LogUsuario.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId);
  oDespTipoDBI := RetagFinDespTipoDBICreate(pDBConnection, oDespTipoEnt);

  FDespTipoDataSetFormCreator := DespTipoDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oDespTipoEnt, oDespTipoDBI, AppObj);
end;

procedure TRetaguardaModuloBasForm.CreateFormCreatorProd(pAppObj: IAppObj;
  pDBConnection: IDBConnection);
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

  oEstSaidaEnt: IEstSaidaEnt;
  oEstSaidaDBI: IEntDBI;

  oInventarioEnt: IInventarioEnt;
  oInventarioDBI: IEntDBI;

  oEntradaEnt: IEntradaEnt;
  oEntradaDBI: IEntDBI;

  oEstPromoEnt: IEstPromoEnt;
  oEstPromoDBI: IEntDBI;
begin
  oFabrEnt := RetagEstProdFabrEntCreate;
  oFabrDBI := RetagEstProdFabrDBICreate(pDBConnection, oFabrEnt);

  FFabrDataSetFormCreator := FabrDataSetFormCreatorCreate(FFormClassNamesSL,
    LogUsuario, DBMS, Output, ProcessLog, FOutputNotify, oFabrEnt,
    oFabrDBI, AppObj);

  oTipoEnt := RetagEstProdTipoEntCreate;
  oTipoDBI := RetagEstProdTipoDBICreate(pDBConnection, oTipoEnt);

  FProdTipoDataSetFormCreator := ProdTipoDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oTipoEnt, oTipoDBI, AppObj);

  oUnidEnt := RetagEstProdUnidEntCreate;
  oUnidDBI := RetagEstProdUnidDBICreate(pDBConnection, oUnidEnt);

  FProdUnidDataSetFormCreator := ProdUnidDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oUnidEnt, oUnidDBI, AppObj);

  oICMSEnt := RetagEstProdICMSEntCreate;
  oICMSDBI := RetagEstProdICMSDBICreate(pDBConnection, oICMSEnt);

  FProdICMSDataSetFormCreator := ProdICMSDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oICMSEnt, oICMSDBI, AppObj);

  oProdBarrasList := ProdBarrasListCreate;
  oProdBalancaEnt := ProdBalancaEntCreate;

  oProdEnt := RetagEstProdEntCreate(AppObj.Loja.Id, LogUsuario.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId, oFabrEnt, oTipoEnt, oUnidEnt,
    oICMSEnt, oProdBarrasList, oProdBalancaEnt);
  oProdDBI := RetagEstProdDBICreate(pDBConnection, oProdEnt);

  FProdDataSetFormCreator := ProdDataSetFormCreatorCreate(FFormClassNamesSL,
    LogUsuario, DBMS, Output, ProcessLog, FOutputNotify, oProdEnt,
    oProdDBI, AppObj);

  FClienteDataSetFormCreator := ClienteDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

  FFornecedorDataSetFormCreator := FornecedorDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

  oEstSaidaEnt := RetagEstSaidaEntCreate(AppObj.Loja, 0, DATA_ZERADA,
    DATA_ZERADA);

  oEstSaidaDBI := RetagEstSaidaEntDBICreate(pDBConnection, pAppObj,
    oEstSaidaEnt, LogUsuario.Id);

  FEstSaidaDataSetFormCreator := EstSaidaEntDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oEstSaidaEnt, oEstSaidaDBI, AppObj);


  oInventarioEnt := RetagInventarioEntCreate(AppObj.Loja, 0, DATA_ZERADA,
    DATA_ZERADA);

  oInventarioDBI := RetagInventarioEntDBICreate(pDBConnection, pAppObj,
    oInventarioEnt, LogUsuario.Id);

  FEstInventarioDataSetFormCreator := InventarioEntDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oInventarioEnt, oInventarioDBI, AppObj);


  oEntradaEnt := RetagEntradaEntCreate(AppObj.Loja, 0, DATA_ZERADA,
    DATA_ZERADA);

  oEntradaDBI := RetagEntradaEntDBICreate(pDBConnection, pAppObj,
    oEntradaEnt, LogUsuario.Id);

  FEstEntradaDataSetFormCreator := EntradaEntDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oEntradaEnt, oEntradaDBI, AppObj);


  oEstPromoEnt := EstPromoEntCreate(//
    AppObj.Loja,//
    0,//promoid
    '', //nome
    True,//Ativo
    DATA_ZERADA,//inicia em
    DATA_ZERADA//termina em
    );

  oEstPromoDBI := EstPromoEntDBICreate(pDBConnection, pAppObj,oEstPromoEnt,
     LogUsuario.Id);

  FEstPromoDataSetFormCreator := EstPromoEntDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog, FOutputNotify,
    oEstPromoEnt, oEstPromoDBI, AppObj);
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

procedure TRetaguardaModuloBasForm.FinanceiroDespesaTipoActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FDespTipoDataSetFormCreator);
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

procedure TRetaguardaModuloBasForm.RetagAjuVersaoSisActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FAjuVersaoSisFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstEntFornecedorActExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FFornecedorDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstEntradaActionExecute
  (Sender: TObject);
begin
  inherited;
   TabSheetCrie(FEstEntradaDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstInventarioActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetCrie(FEstInventarioDataSetFormCreator);
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

procedure TRetaguardaModuloBasForm.RetagEstPromoActExecute(Sender: TObject);
begin
  inherited;
  TabSheetCrie(FEstPromoDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstSaidaActExecute(Sender: TObject);
begin
  inherited;
  TabSheetCrie(FEstSaidaDataSetFormCreator);
end;

procedure TRetaguardaModuloBasForm.RetagEstSaldoActExecute(Sender: TObject);
begin
  inherited;
  //
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
{$IFDEF DEBUG}
  // RetagEstEntFornecedorAct.Execute;
  //RetagEstSaidaAct.Execute;
  //RetagEstEntradaAction.Execute;
//  RetagEstProdAction.Execute;
  RetagEstPromoAct.Execute;
{$ENDIF}

  // RetagEstProdICMSAction.Execute;
  // s l e e p(150);
  // RetagEstProdFabrAction.Execute;

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

    FOutputNotify.Exibir('Opção já aberta');

    exit;
  end;

  oTabSheet := TTabSheet.Create(PageControl1);
  oTabSheet.PageControl := PageControl1;
  oTabSheet.Name := sFormClassName + 'TabSheet';
  PageControl1.ActivePage := oTabSheet;

  oFormOwner := oTabSheet;

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
  TestaTesteConfig_Fin;
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
// var
// bDeveExecutar: Boolean;
begin
  // bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Ajuda.BemVindo.
  // Terminais.AutoExec;
  //
  // if bDeveExecutar then
  // begin
  // MenuPageControl.ActivePage := AjudaTabSheet;
  // end;
end;

procedure TRetaguardaModuloBasForm.TestaTesteConfig_Est;
var
  bDeveExecutar: Boolean;
begin
  // teste est cliente
  bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Est.Cliente.AutoExec;

  if bDeveExecutar then
  begin
    MenuPageControl.ActivePage := EstoqueTabSheet;
    RetagEstVenClienteAction.Execute;
  end;

  // teste est produtos
  bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Est.Produtos.AutoExec;

  if bDeveExecutar then
  begin
    MenuPageControl.ActivePage := EstoqueTabSheet;
    RetagEstProdAction.Execute;
  end;
end;

procedure TRetaguardaModuloBasForm.TestaTesteConfig_Fin;
var
  bDeveExecutar: Boolean;
begin
  bDeveExecutar := AppObj.AppTestesConfig.ModuRetag.Fin.PagamentoForma.AutoExec;

  if bDeveExecutar then
  begin
    MenuPageControl.ActivePage := FinTabSheet;
    FinanceiroPagamentoFormaAction.Execute;
  end;
end;

end.
