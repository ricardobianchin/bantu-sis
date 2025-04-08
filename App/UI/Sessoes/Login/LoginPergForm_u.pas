unit LoginPergForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TLoginPergForm = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginPerg: Boolean;

//var
//  LoginPergForm: TLoginPergForm;

implementation

{$R *.dfm}

function LoginPerg: Boolean;
begin
  Result := True;
end;

end.
