unit App.UI.Form.Ed.Unid_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed.Descr_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask;

type
  TEdUnidForm = class(TEdDescrBasForm)
    SiglaLabeledEdit: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EdUnidForm: TEdUnidForm;

implementation

{$R *.dfm}

end.
