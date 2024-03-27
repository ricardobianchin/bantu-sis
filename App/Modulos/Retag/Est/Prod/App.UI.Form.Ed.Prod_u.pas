unit App.UI.Form.Ed.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Retag.Est.Prod.Ent,
  App.Retag.Est.Prod.DBI, Data.DB, App.Ent.DBI,
  App.Ent.Ed, Sis.UI.FormCreator, App.AppInfo, Sis.Config.SisConfig,
  Sis.UI.Frame.Bas_u, App.UI.Frame.Bas.Retag.Ed_u,
  App.UI.Frame.Bas.Retag.Prod.Ed_u, App.Est.Prod.Barras.DBI

  //
  , Vcl.ComCtrls, App.UI.Frame.Retag.Prod.Ed.Comuns_u, App.Retag.Est.Prod.Ed.DBI
    ;

type
  TProdEdForm = class(TEdBasForm)
    MeioPanel: TPanel;
    ComunsPanel: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FAppInfo: IAppInfo;

    FFabrDBI: IEntDBI; //
    FTipoDBI: IEntDBI; //
    FUnidDBI: IEntDBI; //
    FICMSDBI: IEntDBI; //

    FRetagEstProdEdDBI: IRetagEstProdEdDBI;

    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;

    function GetProdDBI: IProdDBI;
    property ProdDBI: IProdDBI read GetProdDBI;

    function GetAlterado: boolean;

    procedure PreenchaControles;

  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;
    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
  public
    { Public declarations }
    FComunsFr: TRetagProdEdComunsFrame;

    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI;

      //
      pFabrDBI: IEntDBI; //
      pTipoDBI: IEntDBI; //
      pUnidDBI: IEntDBI; //
      pICMSDBI: IEntDBI; //
      pBarrasDBI: IBarrasDBI; //

      //
      pFabrDataSetFormCreator: IFormCreator;
      pProdTipoDataSetFormCreator: IFormCreator;
      pProdUnidDataSetFormCreator: IFormCreator;
      pProdICMSDataSetFormCreator: IFormCreator;

      //
      pAppInfo: IAppInfo;//
      pRetagEstProdEdDBI: IRetagEstProdEdDBI//


      ); reintroduce;
  end;

var
  ProdEdForm: TProdEdForm;

implementation

uses {App.Retag.Est.Prod.Ent_u,} Sis.UI.Controls.TLabeledEdit, System.StrUtils,
  Sis.UI.Controls.Utils, Sis.Types.Integers, App.Retag.Est.Factory,
  Sis.DB.DBTypes, ShellAPI, System.DateUtils, Sis.Types.strings_u;

{$R *.dfm}

procedure TProdEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := ProdEnt.NomeEnt;
        sDes := ProdEnt.Descr;

        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [sNom, sDes]);
      end;

    dsInsert:
      ;
  end;
  PreenchaControles;
end;

procedure TProdEdForm.Button1Click(Sender: TObject);
var
  url: string;
begin
  inherited;
  // EdgeBrowser1.Navigate('https://www.google.com/search?q=qual+e+a+capital+do+brasil');
  // WebBrowser1.Navigate('https://www.google.com/search?q=qual+e+a+capital+do+brasil');

  // WebBrowser1.Navigate('https://www.google.com/search?q=descrição+do+produto+cujo+codigo+de+barra+é+07896036099117');
  // WebBrowser1.Navigate('descrição do produto cujo codigo de barra é 07896036099117
  url := 'https://www.google.com/search?q=descrição+do+produto+cujo+codigo+de+barra+é+07896036099117';
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);
end;

function TProdEdForm.ControlesOk: boolean;
var
  I: integer;
begin
//  Result := TesteLabeledEditVazio(FObrigFr.DescrEdit, ErroOutput);
//  if not Result then
//    exit;
//
//  Result := TesteLabeledEditVazio(FObrigFr.DescrRedEdit, ErroOutput);
//  if not Result then
//    exit;
//
//  I := FObrigFr.FabrFr.Id;
//  Result := I > 0;
//  if not Result then
//  begin
//    ErroOutput.Exibir('Campo Fabricante é obrigatório');
//    exit;
//  end;
end;

procedure TProdEdForm.ControlesToEnt;
begin
  inherited;
//  ProdEnt.Id := FObrigFr.IdEdit.AsInteger;
//  ProdEnt.Descr := FObrigFr.DescrEdit.Text;
//  ProdEnt.DescrRed := FObrigFr.DescrrEDEdit.Text;
//  ProdEnt.ProdFabrEnt.Id := FObrigFr.FabrFr.Id;
//  ProdEnt.ProdFabrEnt.Descr := FObrigFr.FabrFr.Text;
end;

constructor TProdEdForm.Create(AOwner: TComponent; pEntEd: IEntEd;
  pEntDBI: IEntDBI;

  //
  pFabrDBI: IEntDBI; //
  pTipoDBI: IEntDBI; //
  pUnidDBI: IEntDBI; //
  pICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;

  //
  pAppInfo: IAppInfo;//
  pRetagEstProdEdDBI: IRetagEstProdEdDBI//
  );
begin
  inherited Create(AOwner, pEntEd, pEntDBI);

  FAppInfo := pAppInfo;

  FFabrDBI := pFabrDBI;
  FTipoDBI := pTipoDBI;
  FUnidDBI := pUnidDBI;
  FICMSDBI := pICMSDBI;
  FComunsFr := TRetagProdEdComunsFrame.Create(ComunsPanel, SelecioneProximo, ProdEnt, ProdDBI
    , pFabrDBI, pTipoDBI, pUnidDBI, pICMSDBI, pBarrasDBI
    , pFabrDataSetFormCreator //
    , pProdTipoDataSetFormCreator //
    , pProdUnidDataSetFormCreator //
    , pProdICMSDataSetFormCreator //
    , FAppInfo, ErroOutput);

  FRetagEstProdEdDBI := pRetagEstProdEdDBI;
end;

function TProdEdForm.DadosOk: boolean;
var
  sId: string;
  sIdAtual: string;
  sFrase: string;
begin
  Result := inherited DadosOk;
  if not Result then
    exit;

//  sId := VarToStr(EntDBI.GetExistente(FObrigFrame.GetUniqueValues, sFrase));
//  Result := sId = '';
//  if not Result then
//  begin
//    ErroOutput.Exibir(sFrase);
//    FObrigFrame.Foque;
//    exit;
//  end;
end;

procedure TProdEdForm.EntToControles;
begin
  inherited;

//  FObrigFr.IdEdit.Valor := ProdEnt.Id;
//  FObrigFr.DescrEdit.Text := ProdEnt.Descr;
//  FObrigFr.DescrRedEdit.Text := ProdEnt.DescrRed;
//  FObrigFr.FabrFr.Id := ProdEnt.ProdFabrEnt.Id;
end;

function TProdEdForm.GetAlterado: boolean;
begin
  Result := true;
end;

function TProdEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sDes: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := ProdEnt.NomeEnt;
  sDes := ProdEnt.Descr;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sDes]);
end;

function TProdEdForm.GetProdDBI: IProdDBI;
begin
  Result := EntDBICastToProdDBI(EntDBI);
end;

function TProdEdForm.GetProdEnt: IProdEnt;
begin
  Result := EntEdCastToProdEnt(EntEd);
end;

function TProdEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.GarantirReg;
  if not Result then
  begin
    sFrase := 'Erro ao gravar ' + EntEd.NomeEnt;
    ErroOutput.Exibir(sFrase);
//    FObrigFrame.Foque;
    exit;
  end;

end;

procedure TProdEdForm.PreenchaControles;
begin
  if EntEd.State = dsEdit then
  begin

  end
  else
  begin
    FRetagEstProdEdDBI.PreencherItens(Self);
  end;
  FComunsFr.BarrasFr.LabeledEdit1.SetFocus;

end;

procedure TProdEdForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  sNomeArq: string;
  sl: tstringlist;
  S: string;
begin
  inherited;
//  FComunsFr.
  sNomeArq := 'C:\Pr\app\bantu\bantu-sis\Exe\Configs\Debug\App.UI.Form.Ed.Prod_u.Teclas.txt';

  sl := tstringlist.create;
  try
    sl.LoadFromFile(sNomeArq);
    s := sl.Text;
    DigiteStr(s, 0);
  finally
    sl.Free;
  end;
//  FObrigFrame.Foque;
//  FObrigFrame.SimuleDig;

  // OkAct_Diag.Execute;

  // ObrigatoriosProdEdFrame.FCustoAtualNumEdit
  // ObrigatoriosProdEdFrame.FPrecoAtualNumEdit: TNumEditBtu;



  // FFabrSelectEditFrame.IdNumEdit.Valor := 2;

  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYDOWN, VK_RETURN, 0);
  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYUP, VK_RETURN, 0);
end;

end.

