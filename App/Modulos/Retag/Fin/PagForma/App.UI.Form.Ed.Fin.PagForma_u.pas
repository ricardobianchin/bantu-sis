unit App.UI.Form.Ed.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.UI.Controls.ComboBox.Select.DB.Frame_u,
  Vcl.Mask, App.Retag.Fin.PagForma.Ent;

type
  TPagFormaEdForm = class(TEdBasForm)
    DescrLabeledEdit: TLabeledEdit;
    PagFormaTipoComboBox: TComboBox;
    TipoTitLabel: TLabel;
    AtivoCheckBox: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    CheckBox1: TCheckBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox2: TCheckBox;
    LabeledEdit2: TLabeledEdit;
    GroupBox3: TGroupBox;
    MoldeTaxaAdmLabeledEdit: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    CheckBox3: TCheckBox;
  private
    { Private declarations }
    FWinControlList: TList<Vcl.Controls.TWinControl>;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);
  end;

var
  PagFormaEdForm: TPagFormaEdForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TPagFormaEdForm }

constructor TPagFormaEdForm.Create(AOwner: TComponent);
begin

//  PegueFormatoDe
end;

end.
