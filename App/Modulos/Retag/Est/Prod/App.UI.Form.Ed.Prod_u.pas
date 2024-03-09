unit App.UI.Form.Ed.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Retag.Est.Prod.Ent,
  App.Retag.Est.Prod.DBI, Data.DB, Sis.UI.Controls.Sanfona_u, App.Ent.DBI,
  App.Ent.Ed, Sis.UI.FormCreator, App.AppInfo, Sis.Config.SisConfig

  // sanfona item
    , App.Retag.Prod.Obrigatorios.SanfonaItem_u

  //
    ;

type
  TProdEdForm = class(TEdBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    // FFabrSelectEditFrame: TFabrSelectEditFrame;
    FSanfonaFrame: TSanfonaFrame;
    FObrigFrame: TObrigatoriosProdEdFrame;

    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;

    function GetProdDBI: IProdDBI;
    property ProdDBI: IProdDBI read GetProdDBI;

    function GetAlterado: boolean;
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
    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI;

      //
      pFabrDBI: IEntDBI;

      //
      pFabrDataSetFormCreator: IFormCreator;
      pProdTipoDataSetFormCreator: IFormCreator;
      pProdUnidDataSetFormCreator: IFormCreator;
      pProdICMSDataSetFormCreator: IFormCreator

      //
      ); reintroduce;
  end;

var
  ProdEdForm: TProdEdForm;

implementation

uses {App.Retag.Est.Prod.Ent_u,} Sis.UI.Controls.TLabeledEdit,
  Sis.UI.Controls.Utils, Sis.Types.Integers, App.Retag.Est.Factory,
  Sis.DB.DBTypes, ShellAPI;

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

        FSanfonaFrame.TitLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;

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
begin
  Result := FObrigFrame.ControlesOk;
  if not Result then
    exit;
end;

procedure TProdEdForm.ControlesToEnt;
begin
  inherited;
  FObrigFrame.ControlesToEnt;
end;

constructor TProdEdForm.Create(AOwner: TComponent; pEntEd: IEntEd;
  pEntDBI: IEntDBI;

  //
  pFabrDBI: IEntDBI;

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator

  //
  );
var
  oAppInfo: IAppInfo;
  oSisConfig: ISisConfig;
  oDBConnection: IDBConnection;

begin
  inherited Create(AOwner, pEntEd, pEntDBI);
  FSanfonaFrame := TSanfonaFrame.Create(Self, ErroOutput);
  FSanfonaFrame.Parent := Self;
  FSanfonaFrame.Align := alClient;
  FSanfonaFrame.TitLabel.Caption := GetObjetivoStr;
  ObjetivoLabel.Visible := false;

  FObrigFrame := TObrigatoriosProdEdFrame.Create(FSanfonaFrame, ProdEnt,
    ProdDBI, pFabrDBI, pFabrDataSetFormCreator, pProdTipoDataSetFormCreator,
    pProdUnidDataSetFormCreator, pProdICMSDataSetFormCreator, oAppInfo, ErroOutput);

  FSanfonaFrame.PegarItem(FObrigFrame);

  oDBConnection := pFabrDBI.DBConnection;

  if not oDBConnection.Abrir then
    exit;
  try
    FObrigFrame.PreenchaCombos(oDBConnection);
  finally
    oDBConnection.Fechar;
  end;

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

  sId := VarToStr(EntDBI.GetExistente(FObrigFrame.GetUniqueValues, sFrase));
  Result := sId = '';
  if not Result then
  begin
    ErroOutput.Exibir(sFrase);
    FObrigFrame.Foque;
    exit;
  end;
end;

procedure TProdEdForm.EntToControles;
begin
  inherited;
  FObrigFrame.EntToControles;
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
    FObrigFrame.Foque;
    exit;
  end;

end;

procedure TProdEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  // FObrigFrame.FIdNumEdit
  FObrigFrame.Foque;
  FObrigFrame.SimuleDig;

  // OkAct_Diag.Execute;

  // ObrigatoriosProdEdFrame.FCustoAtualNumEdit
  // ObrigatoriosProdEdFrame.FPrecoAtualNumEdit: TNumEditBtu;



  // FFabrSelectEditFrame.IdNumEdit.Valor := 2;

  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYDOWN, VK_RETURN, 0);
  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYUP, VK_RETURN, 0);
end;

end.
