unit App.UI.Form.Ed.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.UI.Controls.ComboBox.Select.DB.Frame_u,
  Vcl.Mask;

type
  TPagFormaEdForm = class(TEdBasForm)
    MoldeTipoPanel: TPanel;
    TitLabel: TLabel;
    BuscaSpeedButton: TSpeedButton;
    EspacadorLabel: TLabel;
    Espacador2Label: TLabel;
    ComboBox1: TComboBox;
    DescrLabeledEdit: TLabeledEdit;
    PagFormaTipoComboBox: TComboBox;
    TipoTitLabel: TLabel;
    AtivoCheckBox: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    MoldeTaxaAdmLabeledEdit: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
  private
    { Private declarations }
    FabrFr: TComboBoxSelectDBFrame;
  public
    { Public declarations }
  end;

var
  PagFormaEdForm: TPagFormaEdForm;

implementation

{$R *.dfm}

end.
