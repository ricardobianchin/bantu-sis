unit NumEditTesteForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Btu.UI.Controls.Edit.Custom_u, Btu.UI.Controls.Edit.Numeric.Custom_u,
  Btu.UI.Controls.NumericEdit;

type
  TNumEditTesteForm = class(TForm)
    BtuNumEdit1: TBtuNumEdit;
    LabeledEdit1: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NumEditTesteForm: TNumEditTesteForm;

implementation

{$R *.dfm}

end.
