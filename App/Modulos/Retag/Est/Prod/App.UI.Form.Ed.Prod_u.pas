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
    , Vcl.ComCtrls, App.UI.Frame.Retag.Prod.Ed.Comuns_u,
  App.Retag.Est.Prod.Ed.DBI;

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
    procedure DescrRedEditKeyPress(Sender: TObject; var Key: Char);
    property ProdEnt: IProdEnt read GetProdEnt;

    function GetProdDBI: IProdDBI;
    property ProdDBI: IProdDBI read GetProdDBI;

    function GetAlterado: boolean;

    procedure PreenchaControles;

    procedure BarrasFrEditKeyPress(Sender: TObject; var Key: Char);
    procedure BarrasEditExit(Sender: TObject);

    procedure ComboKeyPress(Sender: TObject; var Key: Char);
    procedure ComboExit(Sender: TObject);

    procedure FabrComboExit(Sender: TObject);

    procedure EditKeyPress(Sender: TObject; var Key: Char);

    procedure DescrEditExit(Sender: TObject);

    function FabrOk: boolean;
    function FabrDescrsOk(pAvisaDescrVazia: boolean): boolean;

    procedure CapacEmbEditKeyPress(Sender: TObject; var Key: Char);

  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;
    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function GravouOk: boolean; override;
    function DadosOk: Boolean; override;

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
      pAppInfo: IAppInfo; //
      pRetagEstProdEdDBI: IRetagEstProdEdDBI //

      ); reintroduce;
  end;

var
  ProdEdForm: TProdEdForm;

implementation

uses {App.Retag.Est.Prod.Ent_u,} Sis.UI.Controls.TLabeledEdit, System.StrUtils,
  Sis.UI.Controls.Utils, Sis.Types.Integers, App.Retag.Est.Factory,
  Sis.DB.DBTypes, ShellAPI, System.DateUtils, Sis.Types.strings_u,
  App.Retag.Est.Prod.ComboBox_u;

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

procedure TProdEdForm.BarrasEditExit(Sender: TObject);
begin
  if ActiveControl = CancelBitBtn_DiagBtn then
    exit;

  FComunsFr.BarrasFr.PodeOk;
end;

procedure TProdEdForm.BarrasFrEditKeyPress(Sender: TObject; var Key: Char);
var
  Resultado: boolean;
begin
  if Key = #13 then
  begin
    Key := #0;
    SelecioneProximo;
  end
  else if Pos(Key, '0123456789'#8) = 0 then
  begin
    Key := #0;
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

procedure TProdEdForm.CapacEmbEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
  end;

end;

procedure TProdEdForm.ComboExit(Sender: TObject);
var
  Combo: TComboBox;
  Fr: TComboBoxProdEdFrame;
begin
  if not(Sender is TComboBox) then
    exit;

  Combo := TComboBox(Sender);

  if not(Combo.Owner is TComboBoxProdEdFrame) then
    exit;
  Fr := TComboBoxProdEdFrame(Combo.Owner);
  if Fr.Id = 0 then
  begin
    Fr.ExibaMens('Obrigatório');
  end;
end;

procedure TProdEdForm.ComboKeyPress(Sender: TObject; var Key: Char);
var
  Combo: TComboBox;
  Fr: TComboBoxProdEdFrame;
begin
  if not(Sender is TComboBox) then
    exit;

  Combo := TComboBox(Sender);

  if (Combo.Owner is TComboBoxProdEdFrame) then
  begin
    Fr := TComboBoxProdEdFrame(Combo.Owner);
    Fr.ComboBox1KeyPress(Combo, Key);
  end;

  if Key = #13 then
  begin
    Key := #0;
    SelecioneProximo;
  end;
end;

procedure TProdEdForm.ControlesToEnt;
begin
  inherited;
  // ProdEnt.Id := FObrigFr.IdEdit.AsInteger;
  // ProdEnt.Descr := FObrigFr.DescrEdit.Text;
  // ProdEnt.DescrRed := FObrigFr.DescrrEDEdit.Text;
  // ProdEnt.ProdFabrEnt.Id := FObrigFr.FabrFr.Id;
  // ProdEnt.ProdFabrEnt.Descr := FObrigFr.FabrFr.Text;
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
  pAppInfo: IAppInfo; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI //
  );
begin
  inherited Create(AOwner, pEntEd, pEntDBI);
  FAppInfo := pAppInfo;

  FFabrDBI := pFabrDBI;
  FTipoDBI := pTipoDBI;
  FUnidDBI := pUnidDBI;
  FICMSDBI := pICMSDBI;

  FComunsFr := TRetagProdEdComunsFrame.Create(ComunsPanel, SelecioneProximo,
    ProdEnt, ProdDBI, pFabrDBI, pTipoDBI, pUnidDBI, pICMSDBI, pBarrasDBI,
    pFabrDataSetFormCreator //
    , pProdTipoDataSetFormCreator //
    , pProdUnidDataSetFormCreator //
    , pProdICMSDataSetFormCreator //
    , FAppInfo, ErroOutput);

  FRetagEstProdEdDBI := pRetagEstProdEdDBI;

  FComunsFr.BarrasFr.LabeledEdit1.OnKeyPress := BarrasFrEditKeyPress;
  FComunsFr.BarrasFr.LabeledEdit1.OnExit := BarrasEditExit;

  FComunsFr.FabrFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.FabrFr.ComboBox1.OnExit := FabrComboExit;

  FComunsFr.DescrEdit.OnKeyPress := EditKeyPress;
  FComunsFr.DescrEdit.OnExit := DescrEditExit;

  FComunsFr.DescrRedEdit.OnKeyPress := EditKeyPress;
  FComunsFr.DescrRedEdit.OnExit := DescrEditExit;

  FComunsFr.TipoFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.TipoFr.ComboBox1.OnExit :=     ComboExit;

  FComunsFr.UnidFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.UnidFr.ComboBox1.OnExit :=     ComboExit;

  FComunsFr.ICMSFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.ICMSFr.ComboBox1.OnExit :=     ComboExit;

  FComunsFr.CustoNovEdit.OnKeyPress := EditKeyPress;
  FComunsFr.PrecoNovEdit.OnKeyPress := EditKeyPress;

  FComunsFr.BalUtilizaComboBox.OnKeyPress := ComboKeyPress;

  FComunsFr.BalDpto.OnKeyPress := EditKeyPress;
  FComunsFr.BalValidEdit.OnKeyPress := EditKeyPress;

  FComunsFr.LocalizLabeledEdit.OnKeyPress := EditKeyPress;


  FComunsFr.CapacEmbEdit.OnKeyPress := CapacEmbEditKeyPress;
end;

function TProdEdForm.DadosOk: Boolean;
var
  s: string;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := FComunsFr.BarrasFr.PodeOk;
  if not Result then
  begin
    ErroOutput.Exibir('Código de Barras '+FComunsFr.BarrasFr.ErroLabel.Caption);
    exit;
  end;

  Result := FabrOk;
  if not Result then
  begin
    ErroOutput.Exibir('Fabricante '+FComunsFr.FabrFr.MensLabel.Caption);
    exit;
  end;

  Result := FabrDescrsOk(True);
  if not Result then
  begin
    s := '';
    if FComunsFr.DescrErroLabel.Caption <> '' then
    begin
      s := s + 'Descrição '+FComunsFr.DescrErroLabel.Caption;
    end;

    if FComunsFr.DescrRedErroLabel.Caption <> '' then
    begin
      if s <> '' then
        s := s + '. ';
      s := s + 'Descrição Reduzida'+FComunsFr.DescrRedErroLabel.Caption;
    end;

    ErroOutput.Exibir(s);
    exit;
  end;

  Result := FComunsFr.TipoFr.Id > 0;
  if not Result then
  begin
    ErroOutput.Exibir('Setor '+FComunsFr.TipoFr.MensLabel.Caption);
    exit;
  end;


  Result := FComunsFr.UnidFr.Id > 0;
  if not Result then
  begin
    ErroOutput.Exibir('Unidade de Medida '+FComunsFr.UnidFr.MensLabel.Caption);
    exit;
  end;

  Result := FComunsFr.ICMSFr.Id > 0;
  if not Result then
  begin
    ErroOutput.Exibir('Unidade de Medida '+FComunsFr.ICMSFr.MensLabel.Caption);
    exit;
  end;

  Result := FComunsFr.CapacEmbEdit.Valor > 0;
  if not Result then
  begin
    ErroOutput.Exibir(FComunsFr.CapacEmbEdit.EditLabel.Caption +' é obrigatória');
    exit;
  end;
end;

procedure TProdEdForm.DescrEditExit(Sender: TObject);
var
  Ed: TLabeledEdit;
  Resultado: boolean;
begin
  Resultado := ActiveControl = CancelBitBtn_DiagBtn;
  if Resultado then
    exit;

  Ed := TLabeledEdit(Sender);
  if Ed.text = '' then
  begin
    if Ed = FComunsFr.DescrEdit then
      FComunsFr.DescrErroLabel.Caption := 'Obrigatório'
    else
      FComunsFr.DescrRedErroLabel.Caption := 'Obrigatório';
  end;
  FabrDescrsOk(False);
end;

procedure TProdEdForm.EditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited EditKeyPress(Sender, Key);
  if Key = #13 then
  begin
    Key := #0;
    SelecioneProximo;
  end;
end;

procedure TProdEdForm.DescrRedEditKeyPress(Sender: TObject; var Key: Char);
begin

end;

procedure TProdEdForm.EntToControles;
begin
  inherited;
  FComunsFr.IdEdit.Valor := ProdEnt.Id;
  FComunsFr.DescrEdit.Text := ProdEnt.Descr;
  FComunsFr.DescrRedEdit.Text := ProdEnt.DescrRed;

  FComunsFr.CustoAtuEdit.Valor := ProdEnt.CustoAtual;
  FComunsFr.CustoNovEdit.Valor :=  ProdEnt.CustoNovo;
  FComunsFr.PrecoAtuEdit.Valor := ProdEnt.PrecoAtual;
  FComunsFr.PrecoNovEdit.Valor :=  ProdEnt.PrecoNovo;

  FComunsFr.BalUtilizaComboBox.ItemIndex := Integer(ProdEnt.ProdBalancaEnt.BalancaTipo);
  FComunsFr.BalDpto.Valor := ProdEnt.ProdBalancaEnt.DptoCod;
  FComunsFr.BalValidEdit.Valor := ProdEnt.ProdBalancaEnt.ValidadeDias;

  FComunsFr.AtivoCheckBox.Checked := ProdEnt.Ativo;
  FComunsFr.CapacEmbEdit.Valor := ProdEnt.CapacEmb;
  FComunsFr.LocalizLabeledEdit.Text := ProdEnt.Localiz;
end;

procedure TProdEdForm.FabrComboExit(Sender: TObject);
var
  Resultado: boolean;
begin
  Resultado := ActiveControl = CancelBitBtn_DiagBtn;
  if Resultado then
    exit;

  Resultado := FabrOk;
  if not Resultado then
    exit;

  FabrDescrsOk(False);
end;

function TProdEdForm.FabrDescrsOk(pAvisaDescrVazia: boolean): boolean;
var
  oResultSL: TStringList;
  I: Integer;
  sLinhaAtual, pLinhaTipo, pLinhaConteudo: string;
  sErroDescr, sErroDescrRed: string;
begin
  Result := True;
  FComunsFr.DescrEdit.Text := Trim(FComunsFr.DescrEdit.Text);
  FComunsFr.DescrRedEdit.Text := Trim(FComunsFr.DescrRedEdit.Text);

  if FComunsFr.FabrFr.Id = 0 then
  begin
    FComunsFr.FabrFr.ExibaMens('Obrigatório');
    Result := False;
  end;

  if (FComunsFr.DescrEdit.Text = '') and pAvisaDescrVazia then
  begin
    FComunsFr.DescrErroLabel.Caption := 'Obrigatório';
    FComunsFr.DescrErroLabel.Visible := True;

    Result := False;
  end;

  if (FComunsFr.DescrRedEdit.Text = '') and pAvisaDescrVazia then
  begin
    FComunsFr.DescrRedErroLabel.Caption := 'Obrigatório';
    FComunsFr.DescrRedErroLabel.Visible := True;

    Result := False;
  end;

  if FComunsFr.FabrFr.Id = 0 then
    exit;

  oResultSL := TStringList.Create;
  try
    FRetagEstProdEdDBI.FabrDescrsExistentes(FComunsFr.FabrFr.Id,
      FComunsFr.DescrEdit.Text, FComunsFr.DescrRedEdit.Text, oResultSL);
    Result := oResultSL.Count = 0;

    if Result then
      exit;

    sErroDescr := '';
    sErroDescrRed := '';

    for I := 0 to oResultSL.Count - 1 do
    begin
      sLinhaAtual := oResultSL[I];
      StrSepareInicio(sLinhaAtual, 1, pLinhaTipo, pLinhaConteudo);
      if pLinhaTipo = '1' then
        sErroDescr := pLinhaConteudo
      else
        sErroDescrRed := pLinhaConteudo;
    end;
    FComunsFr.DescrErroLabel.Caption := sErroDescr;
    FComunsFr.DescrRedErroLabel.Caption := sErroDescrRed;
  finally
    oResultSL.Free;
  end;
end;

function TProdEdForm.FabrOk: boolean;
begin
  Result := FComunsFr.FabrFr.Id > 0;
  if not Result then
  begin
    FComunsFr.FabrFr.ExibaMens('Obrigatório');
    exit;
  end;
end;

function TProdEdForm.GetAlterado: boolean;
begin
  Result := True;
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
    // FObrigFrame.Foque;
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
  sl: TStringList;
  S: string;
begin
  inherited;
  // FComunsFr.
  sNomeArq :=
    'C:\Pr\app\bantu\bantu-sis\Exe\Configs\Debug\App.UI.Form.Ed.Prod_u.Teclas.txt';
  if not FileExists(sNomeArq) then
    exit;

  sl := TStringList.Create;
  try
    sl.LoadFromFile(sNomeArq);
    S := sl.Text;
    DigiteStr(S, 0);
  finally
    sl.Free;
  end;
  // FObrigFrame.Foque;
  // FObrigFrame.SimuleDig;

  // OkAct_Diag.Execute;

  // ObrigatoriosProdEdFrame.FCustoAtualNumEdit
  // ObrigatoriosProdEdFrame.FPrecoAtualNumEdit: TNumEditBtu;



  // FFabrSelectEditFrame.IdNumEdit.Valor := 2;

  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYDOWN, VK_RETURN, 0);
  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYUP, VK_RETURN, 0);
end;

end.
