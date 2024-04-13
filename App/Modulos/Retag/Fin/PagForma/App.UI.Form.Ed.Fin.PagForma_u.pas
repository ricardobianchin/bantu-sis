unit App.UI.Form.Ed.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.UI.Controls.ComboBox.Select.DB.Frame_u,
  Vcl.Mask, App.Retag.Fin.PagForma.Ent, App.Ent.Ed, App.Ent.DBI, NumEditBtu,
  System.Generics.Collections, App.AppInfo, App.Retag.Fin.Factory,
  Sis.Types.Bool_u;

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
  private
    { Private declarations }
    FWinControlList: TList<Vcl.Controls.TWinControl>;

    FComissAbaterEdit: TNumEditBtu;
    FTaxaAdmEdit: TNumEditBtu;
    FReembolsoDiasEdit: TNumEditBtu;
    FValorMinimoEdit: TNumEditBtu;

    function GetPagFormaEnt: IPagFormaEnt;
    property PagFormaEnt: IPagFormaEnt read GetPagFormaEnt;
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
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI);
  end;

var
  PagFormaEdForm: TPagFormaEdForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Data.DB;

{ TPagFormaEdForm }

procedure TPagFormaEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sVal: string;
begin
  inherited;
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

function TPagFormaEdForm.ControlesOk: boolean;
begin

end;

procedure TPagFormaEdForm.ControlesToEnt;
var
  i: integer;
begin
  inherited;
  i := PagFormaTipoComboBox.ItemIndex + 33;
  PagFormaEnt.PagFormaTipo.Id := i;

  PagFormaEnt.Descr := DescrLabeledEdit.Text;
  PagFormaEnt.DescrRed := DescrRedLabeledEdit.Text;

  PagFormaEnt.ParaVenda := UsoComboBox.ItemIndex = 0;

  PagFormaEnt.Ativo := AtivoCheckBox.Checked;
  PagFormaEnt.PromocaoPermite := PromoPermiteCheckBox.Checked;
  PagFormaEnt.ComicaoPermite := ComissPermiteCheckBox.Checked;

  PagFormaEnt.TaxaAdmPerc := FTaxaAdmEdit.Valor;
  PagFormaEnt.VendaMinima := FValorMinimoEdit.Valor;
  PagFormaEnt.ComissaoAbaterPerc := FComissAbaterEdit.Valor;
  PagFormaEnt.ReembolsoDias := FReembolsoDiasEdit.Valor;

  PagFormaEnt.TEFUsa := TefExigeCheckBox.Checked;
  PagFormaEnt.AutorizacaoExige := AutorizExigeCheckBox.Checked;
  PagFormaEnt.PessoaExige := CliExigeCheckBox.Checked;

  PagFormaEnt.AVista := RecebComboBox.ItemIndex = 0;
end;

constructor TPagFormaEdForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
  // PegueFormatoDe
end;

function TPagFormaEdForm.DadosOk: boolean;
begin

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
  FValorMinimoEdit.Valor := PagFormaEnt.VendaMinima;
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
begin

end;

procedure TPagFormaEdForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  I: integer;
begin
  inherited;
  FWinControlList := TList<Vcl.Controls.TWinControl>.Create;

  FTaxaAdmEdit := TNumEditBtu.Create(Self);
  PegueFormatoDe(FTaxaAdmEdit, MoldeTaxaAdmLabeledEdit);
  FTaxaAdmEdit.Alignment := taRightJustify;
  FTaxaAdmEdit.NCasas := 2;
  FTaxaAdmEdit.NCasasEsq := 3;
  FTaxaAdmEdit.MascEsq := '##0';
  FTaxaAdmEdit.Caption := MoldeTaxaAdmLabeledEdit.EditLabel.Caption;
  FTaxaAdmEdit.LabelPosition := lpLeft;
  FTaxaAdmEdit.LabelSpacing := 4;
  FTaxaAdmEdit.Valor := 0;

  FReembolsoDiasEdit := TNumEditBtu.Create(Self);
  PegueFormatoDe(FComissAbaterEdit, MoldeReembolsoDiasLabeledEdit);
  FReembolsoDiasEdit.Alignment := taCenter;
  FReembolsoDiasEdit.Caption := MoldeReembolsoDiasLabeledEdit.EditLabel.Caption;
  FReembolsoDiasEdit.MaxLength := 5;
  FReembolsoDiasEdit.NCasas := 0;
  FReembolsoDiasEdit.NCasasEsq := 4;
  FReembolsoDiasEdit.Valor := 0;
  FReembolsoDiasEdit.MascEsq := '###0';
  FReembolsoDiasEdit.Valor := 0;

  FComissAbaterEdit := TNumEditBtu.Create(Self);
  PegueFormatoDe(FComissAbaterEdit, MoldeComissAbaterLabeledEdit);
  FComissAbaterEdit.Alignment := taRightJustify;
  FComissAbaterEdit.NCasas := 2;
  FComissAbaterEdit.NCasasEsq := 3;
  FComissAbaterEdit.MascEsq := '##0';
  FComissAbaterEdit.Caption := MoldeComissAbaterLabeledEdit.EditLabel.Caption;
  FComissAbaterEdit.LabelPosition := lpLeft;
  FComissAbaterEdit.LabelSpacing := 4;
  FComissAbaterEdit.Valor := 0;

  FValorMinimoEdit := TNumEditBtu.Create(Self);
  PegueFormatoDe(FValorMinimoEdit, MoldeValorMinimoLabeledEdit);
  FValorMinimoEdit.Alignment := taRightJustify;
  FValorMinimoEdit.NCasas := 2;
  FValorMinimoEdit.NCasasEsq := 5;
  FValorMinimoEdit.MascEsq := '####0';
  FValorMinimoEdit.Caption := MoldeValorMinimoLabeledEdit.EditLabel.Caption;
  FValorMinimoEdit.LabelPosition := lpLeft;
  FValorMinimoEdit.LabelSpacing := 4;
  FValorMinimoEdit.Valor := 0;

  FWinControlList.Add(DescrLabeledEdit);
  FWinControlList.Add(DescrRedLabeledEdit);
  FWinControlList.Add(TipoComboBox);
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

end.
