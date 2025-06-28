unit App.Retag.Est.Factory;

interface

uses Data.DB, Sis.DB.DBTypes, Vcl.StdCtrls, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, System.Classes, Sis.Entidade, Sis.Loja, Sis.Usuario,
  App.UI.Form.Bas.Ed_u, Sis.UI.Controls.ComboBoxManager, App.AppObj,
  Sis.UI.FormCreator, Sis.DB.UltimoId, App.Loja, Sis.Entities.Types,
  Sis.Sis.Constants, Sis.Types, App.Est.EstMovDBI, App.Est.EstMovEnt, App.Types

    , App.Ent.Ed, App.Ent.DBI //

    , App.Retag.Est.Prod.ICMS.Ent // icms ent
    , App.Retag.Est.Prod.Ent // prod ent
    , App.Retag.Est.Prod.Fabr.Ent // fabr ent
    , App.Retag.Est.Prod.Tipo.Ent //
    , App.Retag.Est.Prod.Unid.Ent //

    , App.Retag.Est.Prod.Barras.Ent //
    , App.Retag.Est.Prod.Barras.Ent.List //
    , App.Est.Prod.Barras.DBI //

    , App.Retag.Est.Prod.Balanca.Ent //

    , App.Retag.Est.Prod.Ed.DBI

    , App.Retag.Est.EstSaida.DBI //
    , App.Retag.Est.EstSaida.Ent //
    , App.Retag.Est.EstSaidaItem //

    , App.Retag.Est.Inventario.DBI //
    , App.Retag.Est.Inventario.Ent //
    , App.Retag.Est.InventarioItem //

    , App.Retag.Est.Entrada.DBI //
    , App.Retag.Est.Entrada.Ent //
    , App.Retag.Est.EntradaItem //

    , App.Est.Promo.DBI //
    , App.Est.Promo.Ent //
    , App.Est.PromoItem //

    , App.Est.Prod, App.Est.EstMovItem //

    ;

{$REGION 'est'}
function EntDBICastToEstMovDBI(pEntDBI: IEntDBI): IEstMovDBI;
function EntEdCastToEstMovEnt(pEntEd: IEntEd): IEstMovEnt<IEstMovItem>;

{$ENDREGION}
{$REGION 'prod fabr'}
function EntEdCastToProdFabrEnt(pEntEd: IEntEd): IProdFabrEnt;
function EntDBICastToProdFabrDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdFabrEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = 'NAO INDICADO'): IProdFabrEnt;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabrEnt: IEntEd): IEntDBI;

function ProdFabrEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabr: IEntEd; pProdFabrDBI: IEntDBI): TEdBasForm;

function ProdFabrPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabrEnt: IEntEd; pProdFabrDBI: IEntDBI): boolean;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

function FabrDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
{$ENDREGION}
{$REGION 'prod tipo'}
function EntEdCastToProdTipoEnt(pEntEd: IEntEd): IProdTipoEnt;
function EntDBICastToProdTipoDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdTipoEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = ''): IProdTipoEnt;

function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
  pProdTipoEnt: IEntEd): IEntDBI;

function ProdTipoEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipo: IEntEd; pProdTipoDBI: IEntDBI): TEdBasForm;

function ProdTipoPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipoEnt: IEntEd; pProdTipoDBI: IEntDBI): boolean;

// function DecoratorExclProdTipoCreate(pProdTipo: IEntEd): IDecoratorExcl;

function ProdTipoDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

{$ENDREGION}
{$REGION 'prod unid'}
function EntEdCastToProdUnidEnt(pEntEd: IEntEd): IProdUnidEnt;
function EntDBICastToProdUnidDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdUnidEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = ''): IProdUnidEnt;

function RetagEstProdUnidDBICreate(pDBConnection: IDBConnection;
  pProdUnidEnt: IEntEd): IEntDBI;

function ProdUnidEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnid: IEntEd; pProdUnidDBI: IEntDBI): TEdBasForm;

function ProdUnidPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnidEnt: IEntEd; pProdUnidDBI: IEntDBI): boolean;

// function DecoratorExclProdUnidCreate(pProdUnid: IEntEd): IDecoratorExcl;

function ProdUnidDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
{$ENDREGION}
{$REGION 'prod ICMS'}
function EntEdCastToProdICMSEnt(pEntEd: IEntEd): IProdICMSEnt;
function EntDBICastToProdICMSDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdICMSEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = ''): IProdICMSEnt;

function RetagEstProdICMSDBICreate(pDBConnection: IDBConnection;
  pProdICMSEnt: IEntEd): IEntDBI;

function ProdICMSEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMS: IEntEd; pProdICMSDBI: IEntDBI): TEdBasForm;

function ProdICMSPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMSEnt: IEntEd; pProdICMSDBI: IEntDBI): boolean;

// function DecoratorExclProdICMSCreate(pProdICMS: IEntEd): IDecoratorExcl;

function ProdICMSDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

{$ENDREGION}
{$REGION 'prod'}
function RetagEstProdEdDBICreate(pDBConnection: IDBConnection)
  : IRetagEstProdEdDBI;

function RetagEstProdEntCreate(pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint; //
  //
  // entidades
  pProdFabrEnt: IProdFabrEnt; // fabr
  pProdTipoEnt: IProdTipoEnt; // fabr
  pProdUnidEnt: IProdUnidEnt; // fabr
  pProdICMSEnt: IProdICMSEnt; // fabr
  pProdBarrasList: IProdBarrasList; // prod barras list
  pProdBalancaEnt: IProdBalancaEnt; //
  //
  pState: TDataSetState = dsBrowse;
  // campos
  pId: integer = 0; pDescr: string = ''; pDescrRed: string = ''): IProdEnt;

function RetagEstProdDBICreate(pDBConnection: IDBConnection;
  pProdEnt: IEntEd): IEntDBI;

function ProdEdFormCreate(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;

  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;

  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): TEdBasForm;

function ProdPerg(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;
  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;
  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): boolean;

// function DecoratorExclProdCreate(pProd: IEntEd): IDecoratorExcl;

function EntEdCastToProdEnt(pEntEd: IEntEd): IProdEnt;

function ProdDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

function ProdFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj;
  pDBConnection: IDBConnection): IFormCreator;

function ProdDataSetUltimoIdCreate(pQ: TDataSet): IUltimoId;

{$ENDREGION}
{$REGION 'prod barras'}
function ProdBarrasCreate(pOrdem: smallint = 0; pBarras: string = '')
  : IProdBarras;
function ProdBarrasListCreate: IProdBarrasList;
{$ENDREGION}
{$REGION 'prod balanca'}
function ProdBalancaEntCreate: IProdBalancaEnt;
{$ENDREGION}
{$REGION 'est sai'}
function EntEdCastToEstSaidaEnt(pEntEd: IEntEd): IEstSaidaEnt;
function EntDBICastToEstSaidaDBI(pEntDBI: IEntDBI): IEstSaidaDBI;

function RetagEstSaidaEntCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //

  pEstSaidaId: TId = 0; //
  pSaidaMotivoId: TId = 0; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: boolean = False; //
  pEstMovCancelado: boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  ): IEstSaidaEnt;

function RetagEstSaidaEntDBICreate(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pEstSaidaEnt: IEstSaidaEnt; pUsuarioId: TId): IEntDBI;

function EstSaidaEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil; pOutputNotify: IOutput = nil): TEdBasForm;

function EstSaidaPerg(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
  pOutputNotify: IOutput = nil): boolean;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

function EstSaidaEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

function RetagEstSaidaItemCreate( //
  pOrdem: smallint; //
  pId: TId; pDescrRed, pFabrNome, pUnidSigla: string; //
  pQtd: Currency; //
  pCriadoEm: TDateTime; //
  pCancelado: boolean = False; //
  pAlteradoEm: TDateTime = DATA_ZERADA; //
  pCanceladoEm: TDateTime = DATA_ZERADA //
  ): IRetagEstSaidaItem;

{$ENDREGION}
{$REGION 'est inv'}
function EntEdCastToInventarioEnt(pEntEd: IEntEd): IInventarioEnt;
function EntDBICastToInventarioDBI(pEntDBI: IEntDBI): IInventarioDBI;

function RetagInventarioEntCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //

  pInventarioId: TId = 0; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: boolean = False; //
  pEstMovCancelado: boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  ): IInventarioEnt;

function RetagInventarioEntDBICreate(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pInventarioEnt: IInventarioEnt; pUsuarioId: TId): IEntDBI;

function InventarioEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pInventarioEnt: IEntEd; pInventarioDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil; pOutputNotify: IOutput = nil): TEdBasForm;

function InventarioPerg(AOwner: TComponent; pAppObj: IAppObj;
  pInventarioEnt: IEntEd; pInventarioDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil; pOutputNotify: IOutput = nil): boolean;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

function InventarioEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

function RetagInventarioItemCreate( //
  pOrdem: smallint; //
  pId: TId; pDescrRed, pFabrNome, pUnidSigla: string; //
  pQtd: Currency; //
  pCriadoEm: TDateTime; //
  pCancelado: boolean = False; //
  pAlteradoEm: TDateTime = DATA_ZERADA; //
  pCanceladoEm: TDateTime = DATA_ZERADA //
  ): IRetagInventarioItem;

{$ENDREGION}
{$REGION 'est ent'}
function EntEdCastToEntradaEnt(pEntEd: IEntEd): IEntradaEnt;
function EntDBICastToEntradaDBI(pEntDBI: IEntDBI): IEntradaDBI;

function RetagEntradaEntCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //

  pEntradaId: TId = 0; //
  pNDoc: integer = 0; //
  pSerie: smallint = 0; //
  pFornecedorId: TId = 0; //
  pFornecedorApelido: string = ''; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: boolean = False; //
  pEstMovCancelado: boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  ): IEntradaEnt;

function RetagEntradaEntDBICreate(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pEntradaEnt: IEntradaEnt; pUsuarioId: TId): IEntDBI;

function EntradaEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pEntradaEnt: IEntEd; pEntradaDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil; pOutputNotify: IOutput = nil): TEdBasForm;

function EntradaPerg(AOwner: TComponent; pAppObj: IAppObj; pEntradaEnt: IEntEd;
  pEntradaDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
  pOutputNotify: IOutput = nil): boolean;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

function EntradaEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

function RetagEntradaItemCreate( //
  pOrdem: smallint; //
  pId: TId; //

  pDescrRed, //
  pFabrNome, //
  pUnidSigla: string; //

  pNItem: smallint; //
  pProdIdDeles: string; //

  pQtd: Currency; //
  pCusto: TCusto; //
  pMargem: Currency; //
  pPreco: TPreco; //

  pCriadoEm: TDateTime; //
  pCancelado: boolean = False; //
  pAlteradoEm: TDateTime = DATA_ZERADA; //
  pCanceladoEm: TDateTime = DATA_ZERADA //
  ): IRetagEntradaItem;

{$ENDREGION}
{$REGION 'est promo'}
function EntEdCastToEstPromoEnt(pEntEd: IEntEd): IEstPromoEnt;
function EntDBICastToEstPromoDBI(pEntDBI: IEntDBI): IEstPromoDBI;

function EstPromoEntCreate( //
  pLoja: IAppLoja; //
  pPromoId: integer; //
  pNome: string; //
  pAtivo: boolean; //
  pIniciaEm: TDateTime; //
  pTerminaEm: TDateTime //
  ): IEstPromoEnt;

function EstPromoEntDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pEstPromoEnt: IEstPromoEnt; pUsuarioId: TId): IEntDBI;

function EstPromoEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil; pOutputNotify: IOutput = nil): TEdBasForm;

function EstPromoPerg(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
  pOutputNotify: IOutput = nil): boolean;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

function EstPromoEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

function RetagPromoItemCreate( //
  pOrdem: smallint; //

  pId: TId; //
  pDescrRed, //
  pFabrNome, //
  pUnidSigla: string; //

  pPrecoPromo: Currency; //
  pAtivo: boolean //
  ): IEstPromoItem;

{$ENDREGION}
{$REGION 'xxx'}
{$ENDREGION}

implementation

uses Vcl.Controls, App.UI.FormCreator.DataSet_u, App.Est.Factory_u

{$REGION 'uses fabr'}
  // fabr
    , App.Retag.Est.Prod.Fabr.Ent_u // fabr ent
    , App.Retag.Est.Prod.Fabr.DBI_u // fabr dbi
    , App.UI.Form.Ed.Prod.Fabr_u // fabr ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.Fabr_u
{$ENDREGION}
{$REGION 'uses tipo'}
  // tipo
    , App.Retag.Est.Prod.Tipo.Ent_u // tipo ent
    , App.Retag.Est.Prod.Tipo.DBI_u // tipo dbi
    , App.UI.Form.Ed.Prod.Tipo_u // tipo ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.Tipo_u //
{$ENDREGION}
{$REGION 'uses unid'}
  // unid
    , App.Retag.Est.Prod.Unid.Ent_u // ent
    , App.Retag.Est.Prod.Unid.DBI_u // unid dbi
    , App.UI.Form.Ed.Prod.Unid_u // Unid ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.Unid_u //
{$ENDREGION}
{$REGION 'uses icms'}
  // icms
    , App.Retag.Est.Prod.ICMS.Ent_u // icms ent
    , App.Retag.Est.Prod.ICMS.DBI_u // icms dbi
    , App.UI.Form.Ed.Prod.ICMS_u // icms ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.ICMS_u //
{$ENDREGION}
{$REGION 'uses prod'}
  // prod
    , App.Retag.Est.Prod.Ent_u // prod ent
    , App.Retag.Est.Prod.DBI_u // prod dbi
    , App.UI.Form.Ed.Prod_u // prod ed form
    , App.UI.Form.DataSet.Retag.Est.Prod_u //
    , App.Retag.Est.Prod.UltimoId_u //
  // prod barras
    , App.Retag.Est.Prod.Barras.Ent_u, App.Retag.Est.Prod.Barras.Ent.List_u

  // prod balanca
    , App.Retag.Est.Prod.Balanca.Ent_u

  //
    , App.Retag.Est.Prod.Ed.DBI_u
{$ENDREGION}
{$REGION 'uses est sai'}
    , App.Retag.Est.EstSaida.DBI_u //
    , App.Retag.Est.EstSaida.Ent_u //
    , App.UI.Form.DataSet.Est.EstSaida_u //
    , App.UI.Form.Ed.Est.EstSaida_u //
    , App.Retag.Est.EstSaidaItem_u //
{$ENDREGION}
{$REGION 'uses est inv'}
    , App.Retag.Est.Inventario.DBI_u //
    , App.Retag.Est.Inventario.Ent_u //
    , App.UI.Form.DataSet.Est.Inventario_u //
    , App.UI.Form.Ed.Est.Inventario_u //
    , App.Retag.Est.InventarioItem_u //
{$ENDREGION}
{$REGION 'uses est ent'}
    , App.Retag.Est.Entrada.DBI_u //
    , App.Retag.Est.Entrada.Ent_u //
    , App.UI.Form.DataSet.Est.Entrada_u //
    , App.UI.Form.Ed.Est.Entrada_u //
    , App.Retag.Est.EntradaItem_u //
{$ENDREGION}
{$REGION 'uses est Promo'}
    , App.Est.Promo.DBI_u //
    , App.Est.Promo.Ent_u //
    , App.UI.Form.DataSet.Est.Promo_u //
    , App.UI.Form.Ed.Est.Promo_u //
    , App.Est.PromoItem_u //
{$ENDREGION}
{$REGION 'uses est'}
    , App.Est.EstMovDBI_u //
    , App.Est.EstMovEnt_u //
{$ENDREGION}
    ;

{$REGION 'prod fabr impl'}

function EntEdCastToProdFabrEnt(pEntEd: IEntEd): IProdFabrEnt;
begin
  Result := TProdFabrEnt(pEntEd);
end;

function EntDBICastToProdFabrDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdFabrDBI(pEntDBI);
end;

function RetagEstProdFabrEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdFabrEnt;
begin
  Result := TProdFabrEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabrEnt: IEntEd): IEntDBI;
begin
  Result := TProdFabrDBI.Create(pDBConnection, TProdFabrEnt(pProdFabrEnt));
end;

function ProdFabrEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabr: IEntEd; pProdFabrDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdFabrEdForm.Create(AOwner, pAppObj, pProdFabr, pProdFabrDBI);
end;

function ProdFabrPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabrEnt: IEntEd; pProdFabrDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdFabrEdFormCreate(AOwner, pAppObj, pProdFabrEnt, pProdFabrDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclFabr.Create(pProdFabr);
// end;

function FabrDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdFabrDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod tipo impl'}

function EntEdCastToProdTipoEnt(pEntEd: IEntEd): IProdTipoEnt;
begin
  Result := TProdTipoEnt(pEntEd);
end;

function EntDBICastToProdTipoDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdTipoDBI(pEntDBI);
end;

function RetagEstProdTipoEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdTipoEnt;
begin
  Result := TProdTipoEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
  pProdTipoEnt: IEntEd): IEntDBI;
begin
  Result := TProdTipoDBI.Create(pDBConnection, TProdTipoEnt(pProdTipoEnt));
end;

function ProdTipoEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipo: IEntEd; pProdTipoDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdTipoEdForm.Create(AOwner, pAppObj, pProdTipo, pProdTipoDBI);
end;

function ProdTipoPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipoEnt: IEntEd; pProdTipoDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdTipoEdFormCreate(AOwner, pAppObj, pProdTipoEnt, pProdTipoDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdTipoCreate(pProdTipo: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclTipo.Create(pProdTipo);
// end;

function ProdTipoDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdTipoDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod Unid impl'}

function EntEdCastToProdUnidEnt(pEntEd: IEntEd): IProdUnidEnt;
begin
  Result := TProdUnidEnt(pEntEd);
end;

function EntDBICastToProdUnidDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdUnidDBI(pEntDBI);
end;

function RetagEstProdUnidEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdUnidEnt;
begin
  Result := TProdUnidEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdUnidDBICreate(pDBConnection: IDBConnection;
  pProdUnidEnt: IEntEd): IEntDBI;
begin
  Result := TProdUnidDBI.Create(pDBConnection, TProdUnidEnt(pProdUnidEnt));
end;

function ProdUnidEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnid: IEntEd; pProdUnidDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdUnidEdForm.Create(AOwner, pAppObj, pProdUnid, pProdUnidDBI);
end;

function ProdUnidPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnidEnt: IEntEd; pProdUnidDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdUnidEdFormCreate(AOwner, pAppObj, pProdUnidEnt, pProdUnidDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdUnidCreate(pProdUnid: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclUnid.Create(pProdUnid);
// end;

function ProdUnidDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdUnidDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod ICMS impl'}

function EntEdCastToProdICMSEnt(pEntEd: IEntEd): IProdICMSEnt;
begin
  Result := TProdICMSEnt(pEntEd);

end;

function EntDBICastToProdICMSDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdICMSDBI(pEntDBI);
end;

function RetagEstProdICMSEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdICMSEnt;
begin
  Result := TProdICMSEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdICMSDBICreate(pDBConnection: IDBConnection;
  pProdICMSEnt: IEntEd): IEntDBI;
begin
  Result := TProdICMSDBI.Create(pDBConnection, pProdICMSEnt);
  // Result := TProdICMSDBI.Create(pDBConnection, TProdICMSEnt(pProdICMSEnt));
end;

function ProdICMSEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMS: IEntEd; pProdICMSDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdICMSEdForm.Create(AOwner, pAppObj, pProdICMS, pProdICMSDBI);
end;

function ProdICMSPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMSEnt: IEntEd; pProdICMSDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdICMSEdFormCreate(AOwner, pAppObj, pProdICMSEnt, pProdICMSDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdICMSCreate(pProdICMS: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclICMS.Create(pProdICMS);
// end;

function ProdICMSDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdICMSDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod impl'}

function RetagEstProdEdDBICreate(pDBConnection: IDBConnection)
  : IRetagEstProdEdDBI;
begin
  Result := TRetagEstProdEdDBI.Create(pDBConnection);
end;

function RetagEstProdEntCreate( //
  pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint; //
  //
  // entidades
  pProdFabrEnt: IProdFabrEnt; // fabr
  pProdTipoEnt: IProdTipoEnt; // fabr
  pProdUnidEnt: IProdUnidEnt; // fabr
  pProdICMSEnt: IProdICMSEnt; // fabr
  pProdBarrasList: IProdBarrasList; // prod barras list
  pProdBalancaEnt: IProdBalancaEnt; //
  // campos
  pState: TDataSetState; pId: integer; pDescr: string; pDescrRed: string)
  : IProdEnt;
begin

  Result := TProdEnt.Create(pLojaId, pUsuarioId, pMachineIdentId, pProdFabrEnt,
    pProdTipoEnt, pProdUnidEnt, pProdICMSEnt, pProdBarrasList, pProdBalancaEnt,
    pState, pId, pDescr, pDescrRed);
end;

function RetagEstProdDBICreate(pDBConnection: IDBConnection;
  pProdEnt: IEntEd): IEntDBI;
begin
  Result := TProdDBI.Create(pDBConnection, pProdEnt);
end;

function ProdEdFormCreate(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;

  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;

  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): TEdBasForm;
begin
  Result := TProdEdForm.Create(AOwner, pProdEnt, pProdDBI, pProdFabrDBI,
    pProdTipoDBI, pProdUnidDBI, pProdICMSDBI, pBarrasDBI,
    pFabrDataSetFormCreator, pProdTipoDataSetFormCreator,
    pProdUnidDataSetFormCreator, pProdICMSDataSetFormCreator, pAppObj,
    pRetagEstProdEdDBI, pUsuarioLog);
end;

function ProdPerg(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;

  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;
  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): boolean;
var
  F: TEdBasForm;
begin
  F := ProdEdFormCreate(AOwner, pProdEnt, pProdDBI, pProdFabrDBI, pProdTipoDBI,
    pProdUnidDBI, pProdICMSDBI, pBarrasDBI, pFabrDataSetFormCreator,
    pProdTipoDataSetFormCreator, pProdUnidDataSetFormCreator,
    pProdICMSDataSetFormCreator, pAppObj, pRetagEstProdEdDBI, pUsuarioLog);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdCreate(pProd: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExcl.Create(pProd);
// end;

function EntEdCastToProdEnt(pEntEd: IEntEd): IProdEnt;
begin
  Result := TProdEnt(pEntEd);
end;

function ProdDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

function ProdDataSetUltimoIdCreate(pQ: TDataSet): IUltimoId;
begin
  Result := TProdEdUltimoId.Create(pQ);
end;

function ProdFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj;
  pDBConnection: IDBConnection): IFormCreator;
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

  oTipoEnt := RetagEstProdTipoEntCreate;
  oTipoDBI := RetagEstProdTipoDBICreate(pDBConnection, oTipoEnt);

  oUnidEnt := RetagEstProdUnidEntCreate;
  oUnidDBI := RetagEstProdUnidDBICreate(pDBConnection, oUnidEnt);

  oICMSEnt := RetagEstProdICMSEntCreate;
  oICMSDBI := RetagEstProdICMSDBICreate(pDBConnection, oICMSEnt);

  oProdBarrasList := ProdBarrasListCreate;
  oProdBalancaEnt := ProdBalancaEntCreate;

  oProdEnt := RetagEstProdEntCreate(pAppObj.Loja.Id, pUsuarioLog.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId, oFabrEnt, oTipoEnt, oUnidEnt,
    oICMSEnt, oProdBarrasList, oProdBalancaEnt);
  oProdDBI := RetagEstProdDBICreate(pDBConnection, oProdEnt);

  Result := ProdDataSetFormCreatorCreate(pFormClassNamesSL, pUsuarioLog, pDBMS,
    pOutput, pProcessLog, pOutputNotify, oProdEnt, oProdDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod barras impl'}

function ProdBarrasCreate(pOrdem: smallint; pBarras: string): IProdBarras;
begin
  Result := TProdBarras.Create(pOrdem, pBarras);
end;

function ProdBarrasListCreate: IProdBarrasList;
begin
  Result := TProdBarrasList.Create;
end;

{$ENDREGION}
{$REGION 'prod balanca impl'}

function ProdBalancaEntCreate: IProdBalancaEnt;
begin
  Result := TProdBalancaEnt.Create;
end;
{$ENDREGION}
{$REGION 'est sai impl'}

function EntEdCastToEstSaidaEnt(pEntEd: IEntEd): IEstSaidaEnt;
begin
  Result := TEstSaidaEnt(pEntEd);
  // Result := pEntEd as IEstSaidaEnt;
end;

function EntDBICastToEstSaidaDBI(pEntDBI: IEntDBI): IEstSaidaDBI;
begin
  Result := TEstSaidaDBI(pEntDBI);
end;

function RetagEstSaidaEntCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //

  pEstSaidaId: TId = 0; //
  pSaidaMotivoId: TId = 0; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: boolean = False; //
  pEstMovCancelado: boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  ): IEstSaidaEnt;
begin
  Result := TEstSaidaEnt.Create(pLoja, pTerminalId, pDtHDoc, pEstMovCriadoEm,
    pEstSaidaId, pSaidaMotivoId, pEstMovId, pEstMovFinalizado, pEstMovCancelado,
    pEstMovAlteradoEm, pEstMovFinalizadoEm, pEstMovCanceladoEm);
end;

function RetagEstSaidaEntDBICreate(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pEstSaidaEnt: IEstSaidaEnt; pUsuarioId: TId): IEntDBI;
begin
  Result := TEstSaidaDBI.Create(pDBConnection, pAppObj, pEstSaidaEnt,
    pUsuarioId);
end;

function EstSaidaEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput): TEdBasForm;
begin
  Result := TEstSaidaEdForm.Create(AOwner, pAppObj, pEntEd, pEntDBI,
    pDBConnection, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify);
end;

function EstSaidaPerg(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): boolean;
var
  F: TEdBasForm;
begin
  F := EstSaidaEntEdFormCreate(AOwner, pAppObj, pEntEd, pEntDBI, pDBConnection,
    pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclFabr.Create(pProdFabr);
// end;

function EstSaidaEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TAppEstSaidaDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

function RetagEstSaidaItemCreate( //
  pOrdem: smallint; //
  pId: TId; pDescrRed, pFabrNome, pUnidSigla: string; //
  pQtd: Currency; //
  pCriadoEm: TDateTime; //
  pCancelado: boolean = False; //
  pAlteradoEm: TDateTime = DATA_ZERADA; //
  pCanceladoEm: TDateTime = DATA_ZERADA //
  ): IRetagEstSaidaItem;
var
  oProd: IProd;
begin
  oProd := ProdCreate(pId, pDescrRed, pFabrNome, pUnidSigla);
  Result := TRetagEstSaiItem.Create(pOrdem, oProd, pQtd, pCriadoEm);
end;

{$ENDREGION}
{$REGION 'est inv impl'}

function EntEdCastToInventarioEnt(pEntEd: IEntEd): IInventarioEnt;
begin
  Result := TInventarioEnt(pEntEd);
  // Result := pEntEd as IInventarioEnt;
end;

function EntDBICastToInventarioDBI(pEntDBI: IEntDBI): IInventarioDBI;
begin
  Result := TInventarioDBI(pEntDBI);
end;

function RetagInventarioEntCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //

  pInventarioId: TId = 0; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: boolean = False; //
  pEstMovCancelado: boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  ): IInventarioEnt;
begin
  Result := TInventarioEnt.Create(pLoja, pTerminalId, pDtHDoc, pEstMovCriadoEm,
    pInventarioId, pEstMovId, pEstMovFinalizado, pEstMovCancelado,
    pEstMovAlteradoEm, pEstMovFinalizadoEm, pEstMovCanceladoEm);
end;

function RetagInventarioEntDBICreate(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pInventarioEnt: IInventarioEnt; pUsuarioId: TId): IEntDBI;
begin
  Result := TInventarioDBI.Create(pDBConnection, pAppObj, pInventarioEnt,
    pUsuarioId);
end;

function InventarioEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pInventarioEnt: IEntEd; pInventarioDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput): TEdBasForm;
begin
  Result := TInventarioEdForm.Create(AOwner, pAppObj, pInventarioEnt,
    pInventarioDBI, pDBConnection, pUsuarioLog, pDBMS);
end;

function InventarioPerg(AOwner: TComponent; pAppObj: IAppObj;
  pInventarioEnt: IEntEd; pInventarioDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput): boolean;
var
  F: TEdBasForm;
begin
  F := InventarioEntEdFormCreate(AOwner, pAppObj, pInventarioEnt,
    pInventarioDBI, pDBConnection, pUsuarioLog, pDBMS);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclFabr.Create(pProdFabr);
// end;

function InventarioEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TAppInventarioDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

function RetagInventarioItemCreate( //
  pOrdem: smallint; //
  pId: TId; pDescrRed, pFabrNome, pUnidSigla: string; //
  pQtd: Currency; //
  pCriadoEm: TDateTime; //
  pCancelado: boolean = False; //
  pAlteradoEm: TDateTime = DATA_ZERADA; //
  pCanceladoEm: TDateTime = DATA_ZERADA //
  ): IRetagInventarioItem;
var
  oProd: IProd;
begin
  oProd := ProdCreate(pId, pDescrRed, pFabrNome, pUnidSigla);
  Result := TRetagInventarioItem.Create(pOrdem, oProd, pQtd, pCriadoEm);
end;

{$ENDREGION}
{$REGION 'est ent impl'}

function EntEdCastToEntradaEnt(pEntEd: IEntEd): IEntradaEnt;
begin
  Result := TEntradaEnt(pEntEd);
  // Result := pEntEd as IEntradaEnt;
end;

function EntDBICastToEntradaDBI(pEntDBI: IEntDBI): IEntradaDBI;
begin
  Result := TEntradaDBI(pEntDBI);
end;

function RetagEntradaEntCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //

  pEntradaId: TId = 0; //
  pNDoc: integer = 0; //
  pSerie: smallint = 0; //
  pFornecedorId: TId = 0; //
  pFornecedorApelido: string = ''; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: boolean = False; //
  pEstMovCancelado: boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  ): IEntradaEnt;
begin
  Result := TEntradaEnt.Create(pLoja, //
    pTerminalId, //
    pDtHDoc, //
    pEstMovCriadoEm, //

    pEntradaId, //
    pNDoc, //
    pSerie, //
    pFornecedorId, //
    pFornecedorApelido, //

    pEstMovId, //
    pEstMovFinalizado, //
    pEstMovCancelado, //
    pEstMovAlteradoEm, //
    pEstMovFinalizadoEm, //
    pEstMovCanceladoEm //
    );
end;

function RetagEntradaEntDBICreate(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pEntradaEnt: IEntradaEnt; pUsuarioId: TId): IEntDBI;
begin
  Result := TEntradaDBI.Create(pDBConnection, pAppObj, pEntradaEnt, pUsuarioId);
end;

function EntradaEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pEntradaEnt: IEntEd; pEntradaDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput): TEdBasForm;
begin
  Result := TEntradaEdForm.Create(AOwner, pAppObj, pEntradaEnt, pEntradaDBI,
    pDBConnection, pUsuarioLog, pDBMS);
end;

function EntradaPerg(AOwner: TComponent; pAppObj: IAppObj; pEntradaEnt: IEntEd;
  pEntradaDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): boolean;
var
  F: TEdBasForm;
begin
  F := EntradaEntEdFormCreate(AOwner, pAppObj, pEntradaEnt, pEntradaDBI,
    pDBConnection, pUsuarioLog, pDBMS);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclFabr.Create(pProdFabr);
// end;

function EntradaEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TAppEntradaDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

function RetagEntradaItemCreate( //
  pOrdem: smallint; //
  pId: TId; pDescrRed, pFabrNome, pUnidSigla: string; //
  pNItem: smallint; //
  pProdIdDeles: string; //

  pQtd: Currency; //
  pCusto: TCusto; //
  pMargem: Currency; //
  pPreco: TPreco; //

  pCriadoEm: TDateTime; //
  pCancelado: boolean = False; //
  pAlteradoEm: TDateTime = DATA_ZERADA; //
  pCanceladoEm: TDateTime = DATA_ZERADA //
  ): IRetagEntradaItem;
var
  oProd: IProd;
begin
  oProd := ProdCreate(pId, pDescrRed, pFabrNome, pUnidSigla);
  Result := TRetagEntradaItem.Create(pOrdem, pNItem, pProdIdDeles, oProd, pQtd,
    pCusto, pMargem, pPreco, pCriadoEm);
end;

{$ENDREGION}
{$REGION 'est promo impl'}

function EntEdCastToEstPromoEnt(pEntEd: IEntEd): IEstPromoEnt;
begin
  Result := TEstPromoEnt(pEntEd);
  // Result := pEntEd as IPromoEnt;
end;

function EntDBICastToEstPromoDBI(pEntDBI: IEntDBI): IEstPromoDBI;
begin
  Result := TEstPromoDBI(pEntDBI);
end;

function EstPromoEntCreate( //
  pLoja: IAppLoja; //
  pPromoId: integer; //
  pNome: string; //
  pAtivo: boolean; //
  pIniciaEm: TDateTime; //
  pTerminaEm: TDateTime //
  ): IEstPromoEnt;
begin
  Result := TEstPromoEnt.Create( //
    pLoja, //
    pPromoId, //
    pNome, //
    pAtivo, //
    pIniciaEm, //
    pTerminaEm //
    );
end;

function EstPromoEntDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pEstPromoEnt: IEstPromoEnt; pUsuarioId: TId): IEntDBI;
begin
  Result := TEstPromoDBI.Create(pDBConnection, pEstPromoEnt, pAppObj,
    pUsuarioId);
end;

function EstPromoEntEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput): TEdBasForm;
begin
  Result := TPromoEdForm.Create(AOwner, pAppObj, pEntEd, pEntDBI, pDBConnection,
    pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify);
end;

function EstPromoPerg(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): boolean;
var
  F: TEdBasForm;
begin
  F := EstPromoEntEdFormCreate(AOwner, pAppObj, pEntEd, pEntDBI, pDBConnection,
    pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclFabr.Create(pProdFabr);
// end;

function EstPromoEntDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TAppPromoDataSetForm, pFormClassNamesSL,
    pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify, pEntEd,
    pEntDBI, pAppObj);
end;

function RetagPromoItemCreate(pOrdem: smallint; //

  pId: TId; //
  pDescrRed, //
  pFabrNome, //
  pUnidSigla: string; //

  pPrecoPromo: Currency; //
  pAtivo: boolean //
  ): IEstPromoItem;
var
  oProd: IProd;
begin
  oProd := ProdCreate(pId, pDescrRed, pFabrNome, pUnidSigla);
  Result := TEstPromoItem.Create(oProd, pPrecoPromo, pAtivo);
end;

{$ENDREGION}
{$REGION 'est impl'}

function EntDBICastToEstMovDBI(pEntDBI: IEntDBI): IEstMovDBI;
begin
  Result := TEstMovDBI(pEntDBI);
end;

function EntEdCastToEstMovEnt(pEntEd: IEntEd): IEstMovEnt<IEstMovItem>;
begin
  Result := TEstMovEnt(pEntEd);
  // Result := pEntEd as IEstMovEnt<IEstMovItem>;
  // if Supports(pEntEd, IEstMov<IEstMovItem>, Result) then
  // Exit(Result)
  // else
  // Result := nil; // Ou lan�ar uma exce��o personalizada
end;

{$ENDREGION}
{$REGION 'xxx impl'}
{$ENDREGION}

end.
