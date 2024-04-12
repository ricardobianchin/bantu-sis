unit App.UI.Form.Ed.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.UI.Controls.ComboBox.Select.DB.Frame_u,
  Vcl.Mask, App.Retag.Fin.PagForma.Ent, App.Ent.Ed, App.Ent.DBI, NumEditBtu,
  System.Generics.Collections, App.AppInfo, App.Retag.Fin.Factory;

type
  TPagFormaEdForm = class(TEdBasForm)
    UsoComboBox: TComboBox;
    TipoTitLabel: TLabel;
    AtivoCheckBox: TCheckBox;
    RecebComboBox: TComboBox;
    Label1: TLabel;
    TipoComboBox: TComboBox;
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
begin
  inherited;

end;

constructor TPagFormaEdForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
var
  I: integer;
begin
  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
  FWinControlList := TList<Vcl.Controls.TWinControl>.Create;

  FTaxaAdmEdit := TNumEditBtu.Create(Self);
  FReembolsoDiasEdit := TNumEditBtu.Create(Self);

  FComissAbaterEdit := TNumEditBtu.Create(Self);
  PegueFormatoDe(FComissAbaterEdit, MoldeComissAbaterLabeledEdit);
  FComissAbaterEdit.Alignment := taCenter;
  FComissAbaterEdit.NCasas := 0;
  FComissAbaterEdit.NCasasEsq := 7;
  FComissAbaterEdit.MascEsq := '0000000';
  FComissAbaterEdit.Caption := 'Código';
  FComissAbaterEdit.LabelPosition := lpLeft;
  FComissAbaterEdit.LabelSpacing := 4;
  FComissAbaterEdit.ReadOnly := true;


  FValorMinimoEdit := TNumEditBtu.Create(Self);


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

  for I := 0 to FWinControlList.Count - 1 do
  begin
    FWinControlList[I].TabOrder := I;
  end;

  // PegueFormatoDe
end;

function TPagFormaEdForm.DadosOk: boolean;
begin

end;

procedure TPagFormaEdForm.EntToControles;
begin
  inherited;

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

end.
