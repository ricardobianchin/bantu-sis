unit App.UI.Form.Ed.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.UI.Controls.ComboBox.Select.DB.Frame_u,
  Vcl.Mask, App.Retag.Fin.PagForma.Ent, App.Ent.Ed, App.Ent.DBI,
  System.Generics.Collections;

type
  TPagFormaEdForm = class(TEdBasForm)
    UsoComboBox: TComboBox;
    TipoTitLabel: TLabel;
    AtivoCheckBox: TCheckBox;
    RecebComboBox: TComboBox;
    Label1: TLabel;
    TipoComboBox: TComboBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    AutorizExigeCheckBox: TCheckBox;
    CliExigeCheckBox: TCheckBox;
    GroupBox2: TGroupBox;
    ComissPermiteCheckBox: TCheckBox;
    MoldeComissAbaterLabeledEdit: TLabeledEdit;
    GroupBox3: TGroupBox;
    MoldeTaxaAdmLabeledEdit: TLabeledEdit;
    MoldeReembolsoDiasLabeledEdit: TLabeledEdit;
    MoldeValorMinimoLabeledEdit: TLabeledEdit;
    TefExigeCheckBox: TCheckBox;
    DescrLabeledEdit: TLabeledEdit;
    DescrRedLabeledEdit: TLabeledEdit;
    GroupBox4: TGroupBox;
    PromoPermiteCheckBox: TCheckBox;
    DescrErroLabel: TLabel;
    DescrRedErroLabel: TLabel;
  private
    { Private declarations }
    FWinControlList: TList<Vcl.Controls.TWinControl>;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI);
  end;

var
  PagFormaEdForm: TPagFormaEdForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TPagFormaEdForm }

constructor TPagFormaEdForm.Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pEntEd, pEntDBI);
//  PegueFormatoDe
end;

end.
