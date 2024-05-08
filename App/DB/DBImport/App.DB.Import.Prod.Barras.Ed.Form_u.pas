unit App.DB.Import.Prod.Barras.Ed.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.IO.Input.Str.Form_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  TImportBarEdForm = class(TInputStrForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImportBarEdForm: TImportBarEdForm;

implementation

{$R *.dfm}

end.
