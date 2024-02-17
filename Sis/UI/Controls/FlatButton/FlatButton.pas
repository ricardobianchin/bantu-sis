unit FlatButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, CustomFlatButton;

type
  TFlatButton = class(TCustomFlatButton)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Btu', [TFlatButton]);
end;

end.
