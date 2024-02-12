unit App.UI.Form.Ed.Retag.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask;

type
  TProdFabrRetagEdBasForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProdFabrRetagEdBasForm: TProdFabrRetagEdBasForm;

implementation

{$R *.dfm}

end.
