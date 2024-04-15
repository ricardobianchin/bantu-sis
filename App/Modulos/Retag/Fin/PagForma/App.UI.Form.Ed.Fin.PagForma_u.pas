unit App.UI.Form.Ed.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.UI.Controls.ComboBox.Select.DB.Frame_u,
  Vcl.Mask, App.Retag.Fin.PagForma.Ent, App.Ent.Ed, App.Ent.DBI, NumEditBtu,
  System.Generics.Collections, App.AppInfo,
  Sis.Types.Bool_u, Sis.Usuario, App.Retag.Fin.PagForma.Ed.DBI;

type
  TPagFormaEdForm = class(TEdBasForm)
    UsoComboBox: TComboBox;
    TipoTitLabel: TLabel;
    AtivoCheckBox: TCheckBox;
    RecebComboBox: TComboBox;
    Label1: TLabel;
    PagFormaTipoComboBox: TComboBox;
    Label2: TLabel;
    VendaExigeGroupBox: TGroupBox;
    AutorizExigeCheckBox: TCheckBox;
    CliExigeCheckBox: TCheckBox;
    ComissGroupBox: TGroupBox;
    ComissPermiteCheckBox: TCheckBox;
    MoldeComissAbaterLabeledEdit: TLabeledEdit;
    AdminstradoraGroupBox: TGroupBox;
    MoldeTaxaAdmLabeledEdit: TLabeledEdit;
    MoldeReembolsoDiasLabeledEdit: TLabeledEdit;
    MoldeValorMinimoLabeledEdit: TLabeledEdit;
    TefExigeCheckBox: TCheckBox;
    DescrLabeledEdit: TLabeledEdit;
    DescrRedLabeledEdit: TLabeledEdit;
    PromoGroupBox: TGroupBox;
    PromoPermiteCheckBox: TCheckBox;
    DescrErroLabel: TLabel;
    DescrRedErroLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure DescrLabeledEditExit(Sender: TObject);
    procedure DescrRedLabeledEditExit(Sender: TObject);
    procedure DescrLabeledEditChange(Sender: TObject);
    procedure DescrRedLabeledEditChange(Sender: TObject);
  private
    { Private declarations }
    FPagFormaEdDBI: IPagFormaEdDBI;

    FWinControlList: TList<Vcl.Controls.TWinControl>;

    FComissAbaterEdit: TNumEditBtu;
    FTaxaAdmEdit: TNumEditBtu;
    FReembolsoDiasEdit: TNumEditBtu;
    FValorMinimoEdit: TNumEditBtu;

    function GetPagFormaEnt: IPagFormaEnt;
    property PagFormaEnt: IPagFormaEnt read GetPagFormaEnt;

    function PagFormaTipoSelecionado: char;

    function DescrOk(pAvisaDescrVazia: boolean = true): boolean;
  protected
    function GetObjetivoStr: string; override;
    procedure CriarControles; override;
    procedure AjusteControles; override;
    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pPagFormaEdDBI: IPagFormaEdDBI); reintroduce;
  end;

var
  PagFormaEdForm: TPagFormaEdForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Data.DB, Sis.Types.strings_u, App.Retag.Fin.Factory;

{ TPagFormaEdForm }

procedure TPagFormaEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sVal: string;
begin
  inherited;
  DescrErroLabel.Caption := '';
  DescrRedErroLabel.Caption := '';

  DescrLabeledEdit.OnKeyPress := EditKeyPress;
  DescrRedLabeledEdit.OnKeyPress := EditKeyPress;
//  FTaxaAdmEdit.OnKeyPress := EditKeyPress;
//  FReembolsoDiasEdit.OnKeyPress := EditKeyPress;
//  FComissAbaterEdit.OnKeyPress := EditKeyPress;
//  FValorMinimoEdit.OnKeyPress := EditKeyPress;

  PagFormaTipoComboBox.OnKeyPress := ComboKeyPress;
  UsoComboBox.OnKeyPress := ComboKeyPress;
  RecebComboBox.OnKeyPress := ComboKeyPress;

  AtivoCheckBox.OnKeyPress := CheckBoxKeyPress;
  AutorizExigeCheckBox.OnKeyPress := CheckBoxKeyPress;
  CliExigeCheckBox.OnKeyPress := CheckBoxKeyPress;
  ComissPermiteCheckBox.OnKeyPress := CheckBoxKeyPress;
  TefExigeCheckBox.OnKeyPress := CheckBoxKeyPress;
  PromoPermiteCheckBox.OnKeyPress := CheckBoxKeyPress;

  case PagFormaEnt.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sFormat := 'Alterando %s: %s';
        sNom := PagFormaEnt.NomeEnt;
        sVal := PagFormaEnt.strDescreve;
        sCaption := Format(sFormat, [sNom, sVal]);
        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

procedure TPagFormaEdForm.ControlesToEnt;
var
  i: integer;
begin
  inherited;
  i := PagFormaTipoComboBox.ItemIndex + 33;
  PagFormaEnt.PagFormaTipo.Id := i;
  PagFormaEnt.PagFormaTipo.Descr := PagFormaTipoComboBox.Text;

  PagFormaEnt.Descr := DescrLabeledEdit.Text;
  PagFormaEnt.DescrRed := DescrRedLabeledEdit.Text;

  PagFormaEnt.ParaVenda := UsoComboBox.ItemIndex = 0;

  PagFormaEnt.Ativo := AtivoCheckBox.Checked;
  PagFormaEnt.PromocaoPermite := PromoPermiteCheckBox.Checked;
  PagFormaEnt.ComicaoPermite := ComissPermiteCheckBox.Checked;

  PagFormaEnt.TaxaAdmPerc := FTaxaAdmEdit.Valor;
  PagFormaEnt.ValorMinimo := FValorMinimoEdit.Valor;
  PagFormaEnt.ComissaoAbaterPerc := FComissAbaterEdit.Valor;
  PagFormaEnt.ReembolsoDias := FReembolsoDiasEdit.Valor;

  PagFormaEnt.TEFUsa := TefExigeCheckBox.Checked;
  PagFormaEnt.AutorizacaoExige := AutorizExigeCheckBox.Checked;
  PagFormaEnt.PessoaExige := CliExigeCheckBox.Checked;

  PagFormaEnt.AVista := RecebComboBox.ItemIndex = 0;
end;

constructor TPagFormaEdForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pPagFormaEdDBI: IPagFormaEdDBI);
begin
  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
  FPagFormaEdDBI := pPagFormaEdDBI;
end;

procedure TPagFormaEdForm.CriarCOntroles;
var
  I: integer;
begin
  inherited;
  FWinControlList := TList<Vcl.Controls.TWinControl>.Create;

  FTaxaAdmEdit := TNumEditBtu.Create(Self);
  FTaxaAdmEdit.Alignment := taRightJustify;
  FTaxaAdmEdit.NCasas := 2;
  FTaxaAdmEdit.NCasasEsq := 3;
  FTaxaAdmEdit.MascEsq := '##0';
  FTaxaAdmEdit.Caption := MoldeTaxaAdmLabeledEdit.EditLabel.Caption;
  FTaxaAdmEdit.LabelPosition := lpLeft;
  FTaxaAdmEdit.LabelSpacing := 4;
  FTaxaAdmEdit.Valor := 0;
  PegueFormatoDe(FTaxaAdmEdit, MoldeTaxaAdmLabeledEdit);

  FReembolsoDiasEdit := TNumEditBtu.Create(Self);
  FReembolsoDiasEdit.Alignment := taCenter;
  FReembolsoDiasEdit.Caption := MoldeReembolsoDiasLabeledEdit.EditLabel.Caption;
  FReembolsoDiasEdit.MaxLength := 5;
  FReembolsoDiasEdit.NCasas := 0;
  FReembolsoDiasEdit.NCasasEsq := 4;
  FReembolsoDiasEdit.Valor := 0;
  FReembolsoDiasEdit.MascEsq := '###0';
  FReembolsoDiasEdit.Valor := 0;
  PegueFormatoDe(FReembolsoDiasEdit, MoldeReembolsoDiasLabeledEdit);

  FComissAbaterEdit := TNumEditBtu.Create(Self);
  FComissAbaterEdit.Alignment := taRightJustify;
  FComissAbaterEdit.NCasas := 2;
  FComissAbaterEdit.NCasasEsq := 3;
  FComissAbaterEdit.MascEsq := '##0';
  FComissAbaterEdit.Caption := MoldeComissAbaterLabeledEdit.EditLabel.Caption;
  FComissAbaterEdit.LabelPosition := lpLeft;
  FComissAbaterEdit.LabelSpacing := 4;
  FComissAbaterEdit.Valor := 0;
  PegueFormatoDe(FComissAbaterEdit, MoldeComissAbaterLabeledEdit);

  FValorMinimoEdit := TNumEditBtu.Create(Self);
  FValorMinimoEdit.Alignment := taRightJustify;
  FValorMinimoEdit.NCasas := 2;
  FValorMinimoEdit.NCasasEsq := 5;
  FValorMinimoEdit.MascEsq := '####0';
  FValorMinimoEdit.Caption := MoldeValorMinimoLabeledEdit.EditLabel.Caption;
  FValorMinimoEdit.LabelPosition := lpLeft;
  FValorMinimoEdit.LabelSpacing := 4;
  FValorMinimoEdit.Valor := 0;
  PegueFormatoDe(FValorMinimoEdit, MoldeValorMinimoLabeledEdit);

  FWinControlList.Add(DescrLabeledEdit);
  FWinControlList.Add(DescrRedLabeledEdit);
  FWinControlList.Add(PagFormaTipoComboBox);
  FWinControlList.Add(UsoComboBox);
  FWinControlList.Add(RecebComboBox);
  FWinControlList.Add(AtivoCheckBox);
  FWinControlList.Add(AdminstradoraGroupBox);
  FWinControlList.Add(ComissGroupBox);
  FWinControlList.Add(PromoGroupBox);
  FWinControlList.Add(VendaExigeGroupBox);

  FTaxaAdmEdit.TabOrder := 0;
  FReembolsoDiasEdit.TabOrder := 1;

  FComissAbaterEdit.TabOrder := 1;
  FValorMinimoEdit.TabOrder := 3;

  for I := 0 to FWinControlList.Count - 1 do
  begin
    FWinControlList[I].TabOrder := I;
  end;
end;

function TPagFormaEdForm.DadosOk: boolean;
begin
  Result := DescrOk;
  if not Result then
    exit;
end;

procedure TPagFormaEdForm.DescrLabeledEditChange(Sender: TObject);
begin
  inherited;
  DescrErroLabel.Caption := '';

end;

procedure TPagFormaEdForm.DescrLabeledEditExit(Sender: TObject);
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
    if Ed = DescrLabeledEdit then
      DescrErroLabel.Caption := 'Obrigatório'
    else
      DescrRedErroLabel.Caption := 'Obrigatório';
  end;

  DescrOk;
end;

function TPagFormaEdForm.DescrOk(pAvisaDescrVazia: boolean): boolean;
var
  oResultSL: TStringList;
  I: Integer;
  sLinhaAtual, pLinhaTipo, pLinhaConteudo: string;
  sErroDescr, sErroDescrRed: string;
  oPagFormaEdDBI: IPagFormaEdDBI;
  cPagFormaTipoId: char;
begin
  Result := True;
  DescrLabeledEdit.Text := Trim(DescrLabeledEdit.Text);
  DescrRedLabeledEdit.Text := Trim(DescrRedLabeledEdit.Text);

  if (DescrLabeledEdit.Text = '') and pAvisaDescrVazia then
  begin
    DescrErroLabel.Caption := 'Obrigatório';

    Result := False;
  end;

  if (DescrRedLabeledEdit.Text = '') and pAvisaDescrVazia then
  begin
    DescrRedErroLabel.Caption := 'Obrigatório';

    Result := False;
  end;

  oResultSL := TStringList.Create;
  try
    cPagFormaTipoId := PagFormaTipoSelecionado;
    FPagFormaEdDBI.DescrsExistentesGet(PagFormaEnt.Id, cPagFormaTipoId,
      DescrLabeledEdit.Text, DescrRedLabeledEdit.Text, oResultSL);
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
      sErroDescr := 'Já usado em ' + sErroDescr;

    if sErroDescrRed <> '' then
      sErroDescrRed := 'Já usado em ' + sErroDescrRed;

    DescrErroLabel.Caption := sErroDescr;
    DescrRedErroLabel.Caption := sErroDescrRed;
  finally
    oResultSL.Free;
  end;
end;

procedure TPagFormaEdForm.DescrRedLabeledEditChange(Sender: TObject);
begin
  inherited;
  DescrRedErroLabel.Caption := '';
end;

procedure TPagFormaEdForm.DescrRedLabeledEditExit(Sender: TObject);
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
    if Ed = DescrLabeledEdit then
      DescrErroLabel.Caption := 'Obrigatório'
    else
      DescrRedErroLabel.Caption := 'Obrigatório';
  end;

  DescrOk;
end;

procedure TPagFormaEdForm.EntToControles;
var
  i: integer;
begin
  inherited;
  i := PagFormaEnt.PagFormaTipo.Id - 33;
  PagFormaTipoComboBox.ItemIndex := i;

  DescrLabeledEdit.Text := PagFormaEnt.Descr;
  DescrRedLabeledEdit.Text := PagFormaEnt.DescrRed;

  UsoComboBox.ItemIndex := Iif(PagFormaEnt.ParaVenda, 0, 1);
  AtivoCheckBox.Checked := PagFormaEnt.Ativo;
  PromoPermiteCheckBox.Checked := PagFormaEnt.PromocaoPermite;
  ComissPermiteCheckBox.Checked := PagFormaEnt.ComicaoPermite;

  FTaxaAdmEdit.Valor := PagFormaEnt.TaxaAdmPerc;
  FValorMinimoEdit.Valor := PagFormaEnt.ValorMinimo;
  FComissAbaterEdit.Valor := PagFormaEnt.ComissaoAbaterPerc;
  FReembolsoDiasEdit.Valor := PagFormaEnt.ReembolsoDias;

  TefExigeCheckBox.Checked := PagFormaEnt.TEFUsa;
  AutorizExigeCheckBox.Checked := PagFormaEnt.AutorizacaoExige;
  CliExigeCheckBox.Checked := PagFormaEnt.PessoaExige;
  RecebComboBox.ItemIndex := iif(PagFormaEnt.AVista, 0, 1);
end;

function TPagFormaEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := PagFormaEnt.NomeEnt;
  sVal := PagFormaEnt.StrDescreve;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TPagFormaEdForm.GetPagFormaEnt: IPagFormaEnt;
begin
  Result := EntEdCastToPagFormaEnt(EntEd);
end;

function TPagFormaEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.Gravar;
end;

function TPagFormaEdForm.PagFormaTipoSelecionado: char;
var
  I: integer;
  ch: char;
begin
  I := PagFormaTipoComboBox.ItemIndex;
  ch := char(I + 33);
  Result := ch;
end;

procedure TPagFormaEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//
end;

end.
