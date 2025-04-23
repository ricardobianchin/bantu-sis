unit App.UI.Form.Perg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TPergForm = class(TBasForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Perg: Boolean;

//var
//  PergForm: TPergForm;

implementation

{$R *.dfm}

function Perg: Boolean;
var
  PergForm: TPergForm;
begin
  PergForm := TPergForm.Create(nil);
  result := IsPositiveResult(PergForm.ShowModal);
  PergForm.Free;
end;

end.
