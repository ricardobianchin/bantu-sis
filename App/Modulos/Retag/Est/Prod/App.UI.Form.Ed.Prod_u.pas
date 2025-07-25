unit App.UI.Form.Ed.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Retag.Est.Prod.Ent,
  Data.DB, App.Ent.DBI, Sis.Usuario,
  App.Ent.Ed, Sis.UI.FormCreator, App.AppObj,
  Sis.UI.Frame.Bas_u, App.UI.Frame.Bas.Retag.Ed_u,
  App.UI.Frame.Bas.Retag.Prod.Ed_u, App.Est.Prod.Barras.DBI

  //
    , Vcl.ComCtrls, App.UI.Frame.Retag.Prod.Ed.Comuns_u,
  App.Retag.Est.Prod.Ed.DBI;

type
  TProdEdForm = class(TEdBasForm)
    MeioPanel: TPanel;
    ComunsPanel: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    FFabrDBI: IEntDBI; //
    FTipoDBI: IEntDBI; //
    FUnidDBI: IEntDBI; //
    FICMSDBI: IEntDBI; //

    FRetagEstProdEdDBI: IRetagEstProdEdDBI;

    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;

    function GetAlterado: boolean;

    procedure PreenchaControles;

    procedure BarrasFrEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BarrasFrEditKeyPress(Sender: TObject; var Key: Char);
    procedure BarrasEditExit(Sender: TObject);

    procedure FabrComboExit(Sender: TObject);

    procedure DescrEditExit(Sender: TObject);

    function FabrOk: boolean;
    function FabrDescrsOk(pAvisaDescrVazia: boolean): boolean;

    procedure UltimoControleEditKeyPress(Sender: TObject; var Key: Char);

    procedure CustoExit(Sender: TObject);
    procedure PrecoExit(Sender: TObject);

    procedure CustoChange(Sender: TObject);
    procedure PrecoChange(Sender: TObject);

    function CustoOk: boolean;
    function PrecoOk: boolean;

  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;
    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function GravouOk: boolean; override;
    function DadosOk: boolean; override;
    function ControlesOk: boolean; override;


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
      pAppObj: IAppObj; //
      pRetagEstProdEdDBI: IRetagEstProdEdDBI;//
      pUsuarioLog: IUsuario
      ); reintroduce;
  end;

var
  ProdEdForm: TProdEdForm;

implementation

uses {App.Retag.Est.Prod.Ent_u,} Sis.UI.Controls.TLabeledEdit, System.StrUtils,
  Sis.UI.Controls.Utils, Sis.Types.Integers, App.Retag.Est.Factory,
  Sis.DB.DBTypes, ShellAPI, System.DateUtils, Sis.Types.strings_u,
  App.Retag.Est.Prod.ComboBox_u, App.Est.Types_u, CustomEditBtu;

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

procedure TProdEdForm.BarrasFrEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  bValor: boolean;
begin
  bValor := Shift = [];
  KeyPressFiltraTeclado := bValor;
end;

procedure TProdEdForm.BarrasFrEditKeyPress(Sender: TObject; var Key: Char);
var
  Resultado: boolean;
begin
  if not KeyPressFiltraTeclado then
    exit;

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

  // WebBrowser1.Navigate('https://www.google.com/search?q=descri��o+do+produto+cujo+codigo+de+barra+�+07896036099117');
  // WebBrowser1.Navigate('descri��o do produto cujo codigo de barra � 07896036099117
  url := 'https://www.google.com/search?q=descri��o+do+produto+cujo+codigo+de+barra+�+07896036099117';
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);
end;

procedure TProdEdForm.UltimoControleEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
  end;

end;

function TProdEdForm.ControlesOk: boolean;
begin
  Result := True;
  if FComunsFr.BarrasFr.LabeledEdit1.Text = '' then
  begin
    if FComunsFr.BarrasFr.ProdBarrasList.Count > 0 then
    begin
      FComunsFr.BarrasFr.ProdBarrasList.ApaguePrimeiro;
    end;
  end;
end;

procedure TProdEdForm.ControlesToEnt;
var
  bBalancaExige: Boolean;
  cCapac: Currency;
  cMargem: Currency;
begin
  inherited;
  ProdEnt.Descr := FComunsFr.DescrEdit.Text;
  ProdEnt.DescrRed := FComunsFr.DescrRedEdit.Text;

  ProdEnt.ProdFabrEnt.Id := FComunsFr.FabrFr.Id;
  ProdEnt.ProdFabrEnt.Descr := FComunsFr.FabrFr.Text;

  ProdEnt.ProdTipoEnt.Id := FComunsFr.TipoFr.Id;
  ProdEnt.ProdTipoEnt.Descr := FComunsFr.TipoFr.Text;

  ProdEnt.ProdUnidEnt.Id := FComunsFr.UnidFr.Id;
  ProdEnt.ProdUnidEnt.Descr := FComunsFr.UnidFr.Text;

  ProdEnt.ProdICMSEnt.Id := FComunsFr.ICMSFr.Id;
  ProdEnt.ProdICMSEnt.Descr := FComunsFr.ICMSFr.Text;

  ProdEnt.ProdNatu := FComunsFr.ProdNatuSelecionada;
  ProdEnt.ProdNatuNome := FComunsFr.ProdNatuComboBox.Text;

  ProdEnt.CustoAtual := FComunsFr.CustoAtuEdit.Valor;
  ProdEnt.CustoNovo := FComunsFr.CustoNovEdit.Valor;
  ProdEnt.PrecoAtual := FComunsFr.PrecoAtuEdit.Valor;
  ProdEnt.PrecoNovo := FComunsFr.PrecoNovEdit.Valor;

  bBalancaExige := FComunsFr.BalancaExigeCheckBox.Checked;

  ProdEnt.ProdBalancaEnt.DptoCod := FComunsFr.BalDpto.Valor;
  ProdEnt.ProdBalancaEnt.ValidadeDias := FComunsFr.BalValidEdit.AsInteger;
  ProdEnt.ProdBalancaEnt.TextoEtiq := FComunsFr.BalTextoEtiqMemo.Text;

  ProdEnt.Ativo := FComunsFr.AtivoCheckBox.Checked;

  cCapac := FComunsFr.CapacEmbEdit.AsCurrency;
  ProdEnt.CapacEmb := cCapac;

  ProdEnt.Localiz := FComunsFr.LocalizLabeledEdit.Text;

  cMargem := FComunsFr.MargemEdit.AsCurrency;
  ProdEnt.Margem := cMargem;

  ProdEnt.Ncm := Trim(FComunsFr.NcmLabeledEdit.Text);

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
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI;//
  pUsuarioLog: IUsuario
  );
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FFabrDBI := pFabrDBI;
  FTipoDBI := pTipoDBI;
  FUnidDBI := pUnidDBI;
  FICMSDBI := pICMSDBI;

  FComunsFr := TRetagProdEdComunsFrame.Create(ComunsPanel, SelecioneProximo,
    ProdEnt, EntDBI, pFabrDBI, pTipoDBI, pUnidDBI, pICMSDBI, pBarrasDBI,
    pFabrDataSetFormCreator //
    , pProdTipoDataSetFormCreator //
    , pProdUnidDataSetFormCreator //
    , pProdICMSDataSetFormCreator //
    , pAppObj, ErroOutput);

  FRetagEstProdEdDBI := pRetagEstProdEdDBI;

  FComunsFr.BarrasFr.LabeledEdit1.OnKeyPress := BarrasFrEditKeyPress;
  FComunsFr.BarrasFr.LabeledEdit1.OnKeyDown := BarrasFrEditKeyDown;

  FComunsFr.BarrasFr.LabeledEdit1.OnExit := BarrasEditExit;

  FComunsFr.FabrFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.FabrFr.ComboBox1.OnExit := FabrComboExit;

  FComunsFr.DescrEdit.OnKeyPress := EditKeyPress;
  FComunsFr.DescrEdit.OnExit := DescrEditExit;

  FComunsFr.DescrRedEdit.OnKeyPress := EditKeyPress;
  FComunsFr.DescrRedEdit.OnExit := DescrEditExit;

  FComunsFr.TipoFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.TipoFr.ComboBox1.OnExit := ComboExit;

  FComunsFr.UnidFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.UnidFr.ComboBox1.OnExit := ComboExit;

  FComunsFr.ICMSFr.ComboBox1.OnKeyPress := ComboKeyPress;
  FComunsFr.ICMSFr.ComboBox1.OnExit := ComboExit;

  FComunsFr.CustoNovEdit.OnKeyPress := EditKeyPress;
  FComunsFr.CustoNovEdit.OnExit := CustoExit;
  FComunsFr.CustoNovEdit.OnChange := CustoChange;

  FComunsFr.PrecoNovEdit.OnKeyPress := EditKeyPress;
  FComunsFr.PrecoNovEdit.OnExit := PrecoExit;
  FComunsFr.PrecoNovEdit.OnChange := PrecoChange;

  FComunsFr.BalancaExigeCheckBox.OnKeyPress := ComboKeyPress;

  FComunsFr.BalDpto.OnKeyPress := EditKeyPress;
  FComunsFr.BalValidEdit.OnKeyPress := EditKeyPress;

  FComunsFr.LocalizLabeledEdit.OnKeyPress := EditKeyPress;

  FComunsFr.CapacEmbEdit.OnKeyPress := EditKeyPress;
  FComunsFr.MargemEdit.OnKeyPress := UltimoControleEditKeyPress;

end;

procedure TProdEdForm.CustoChange(Sender: TObject);
begin
  FComunsFr.CustoErroLabel.Caption := '';
end;

procedure TProdEdForm.CustoExit(Sender: TObject);
begin
  if ActiveControl = CancelBitBtn_DiagBtn then
    exit;
  if CustoOk then
    exit;
end;

function TProdEdForm.CustoOk: boolean;
begin
  Result := FComunsFr.CustoAtuEdit.AsCurrency > 0;
  if Result then
    exit;

  Result := FComunsFr.CustoNovEdit.AsCurrency > 0;

  if Result then
  begin
    FComunsFr.CustoErroLabel.Caption := '';
  end
  else
  begin
    FComunsFr.CustoErroLabel.Caption := 'Primeiro Custo � obrigat�rio';
  end;
end;

function TProdEdForm.DadosOk: boolean;
var
  s: string;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := FComunsFr.BarrasFr.PodeOk;
  if not Result then
  begin
    ErroOutput.Exibir('C�digo de Barras ' +
      FComunsFr.BarrasFr.ErroLabel.Caption);
    exit;
  end;

  Result := FabrOk;
  if not Result then
  begin
    ErroOutput.Exibir('Fabricante ' + FComunsFr.FabrFr.MensLabel.Caption);
    exit;
  end;

  Result := FabrDescrsOk(True);
  if not Result then
  begin
    s := '';
    if FComunsFr.DescrErroLabel.Caption <> '' then
    begin
      s := s + 'Descri��o ' + FComunsFr.DescrErroLabel.Caption;
    end;

    if FComunsFr.DescrRedErroLabel.Caption <> '' then
    begin
      if s <> '' then
        s := s + '. ';
      s := s + 'Descri��o Reduzida' + FComunsFr.DescrRedErroLabel.Caption;
    end;

    ErroOutput.Exibir(s);
    exit;
  end;

  Result := FComunsFr.TipoFr.Id > 0;
  if not Result then
  begin
    ErroOutput.Exibir('Tipo ' + FComunsFr.TipoFr.MensLabel.Caption);
    exit;
  end;

  Result := FComunsFr.UnidFr.Id > 0;
  if not Result then
  begin
    ErroOutput.Exibir('Unidade de Medida ' +
      FComunsFr.UnidFr.MensLabel.Caption);
    exit;
  end;

  Result := FComunsFr.ICMSFr.Id > 0;
  if not Result then
  begin
    ErroOutput.Exibir('Unidade de Medida ' +
      FComunsFr.ICMSFr.MensLabel.Caption);
    exit;
  end;

  Result := CustoOk;
  if not Result then
  begin
    ErroOutput.Exibir(FComunsFr.CustoErroLabel.Caption);
    FComunsFr.CustoNovEdit.SetFocus;
    exit;
  end;

  Result := PrecoOk;
  if not Result then
  begin
    ErroOutput.Exibir(FComunsFr.PrecoErroLabel.Caption);
    FComunsFr.PrecoNovEdit.SetFocus;
    exit;
  end;

  Result := FComunsFr.CapacEmbEdit.Valor > 0;
  if not Result then
  begin
    ErroOutput.Exibir(FComunsFr.CapacEmbEdit.EditLabel.Caption +
      ' � obrigat�ria');
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
  if Ed.Text = '' then
  begin
    if Ed = FComunsFr.DescrEdit then
      FComunsFr.DescrErroLabel.Caption := 'Obrigat�rio'
    else
      FComunsFr.DescrRedErroLabel.Caption := 'Obrigat�rio';
  end;
  FabrDescrsOk(False);
end;

procedure TProdEdForm.EntToControles;
var
  bBalancaExige: Boolean;
begin
  inherited;
  FComunsFr.IdEdit.Valor := ProdEnt.Id;
  FComunsFr.DescrEdit.Text := ProdEnt.Descr;
  FComunsFr.DescrRedEdit.Text := ProdEnt.DescrRed;

  FComunsFr.CustoAtuEdit.Valor := ProdEnt.CustoAtual;
  FComunsFr.CustoNovEdit.Valor := ProdEnt.CustoNovo;
  FComunsFr.PrecoAtuEdit.Valor := ProdEnt.PrecoAtual;
  FComunsFr.PrecoNovEdit.Valor := ProdEnt.PrecoNovo;

  FComunsFr.ProdNatuSelecionada := ProdEnt.ProdNatu;

  FComunsFr.BalancaExigeCheckBox.Checked := bBalancaExige;
  FComunsFr.BalDpto.Valor := ProdEnt.ProdBalancaEnt.DptoCod;
  FComunsFr.BalValidEdit.Valor := ProdEnt.ProdBalancaEnt.ValidadeDias;
  FComunsFr.BalTextoEtiqMemo.Text := ProdEnt.ProdBalancaEnt.TextoEtiq;

  FComunsFr.AtivoCheckBox.Checked := ProdEnt.Ativo;
  FComunsFr.CapacEmbEdit.Valor := ProdEnt.CapacEmb;
  FComunsFr.LocalizLabeledEdit.Text := ProdEnt.Localiz;
  FComunsFr.MargemEdit.Valor := ProdEnt.Margem;

  FComunsFr.NcmLabeledEdit.Text := ProdEnt.Ncm;

  if ProdEnt.ProdBarrasList.Count = 0 then
  begin
    FComunsFr.BarrasFr.LabeledEdit1.Text := '';
    exit;
  end;

  FComunsFr.BarrasFr.LabeledEdit1.Text := ProdEnt.ProdBarrasList[0].Barras;
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
    FComunsFr.FabrFr.ExibaMens('Obrigat�rio');
    Result := False;
  end;

  if (FComunsFr.DescrEdit.Text = '') and pAvisaDescrVazia then
  begin
    FComunsFr.DescrErroLabel.Caption := 'Obrigat�rio';
    FComunsFr.DescrErroLabel.Visible := True;

    Result := False;
  end;

  if (FComunsFr.DescrRedEdit.Text = '') and pAvisaDescrVazia then
  begin
    FComunsFr.DescrRedErroLabel.Caption := 'Obrigat�rio';
    FComunsFr.DescrRedErroLabel.Visible := True;

    Result := False;
  end;

  if FComunsFr.FabrFr.Id = 0 then
    exit;

  oResultSL := TStringList.Create;
  try
    FRetagEstProdEdDBI.FabrDescrsExistentes(ProdEnt.Id, FComunsFr.FabrFr.Id,
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

    if sErroDescr <> '' then
      sErroDescr := 'J� usado em ' + sErroDescr;

    if sErroDescrRed <> '' then
      sErroDescrRed := 'J� usado em ' + sErroDescrRed;

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
    FComunsFr.FabrFr.ExibaMens('Obrigat�rio');
    exit;
  end;
end;

procedure TProdEdForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    key := #0;
    SelecioneProximo;
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

function TProdEdForm.GetProdEnt: IProdEnt;
begin
  Result := EntEdCastToProdEnt(EntEd);
end;

function TProdEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.Gravar;
end;

procedure TProdEdForm.PrecoChange(Sender: TObject);
begin
  FComunsFr.PrecoErroLabel.Caption := '';
end;

procedure TProdEdForm.PrecoExit(Sender: TObject);
begin
  if ActiveControl = CancelBitBtn_DiagBtn then
    exit;
  if PrecoOk then
    exit;
end;

function TProdEdForm.PrecoOk: boolean;
begin
  Result := FComunsFr.PrecoAtuEdit.AsCurrency > 0;
  if Result then
    exit;

  Result := FComunsFr.PrecoNovEdit.AsCurrency > 0;

  if Result then
  begin
    FComunsFr.PrecoErroLabel.Caption := '';
  end
  else
  begin
    FComunsFr.PrecoErroLabel.Caption := 'Primeiro Pre�o � obrigat�rio';
  end;
end;

procedure TProdEdForm.PreenchaControles;
begin
  if EntEd.State = dsEdit then
  begin
    FRetagEstProdEdDBI.PreencherItens(Self);
  end
  else
  begin
    FRetagEstProdEdDBI.PreencherItens(Self);
  end;

  FComunsFr.BarrasFr.LabeledEdit1.SetFocus;
end;

end.
