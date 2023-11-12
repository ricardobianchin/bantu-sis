unit bnt.sis.ctrls.FlatBtnFace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, bnt.sis.ctrls.CustomFlatBtnFace;

type
  TFlatBtnFace = class(TCustomFlatBtnFace)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property Caption;
    property Color;
    property HoverColor;
    property font;
    property Action;
  end;

procedure Register;

implementation

procedure Register;
begin
//  RegisterComponents('bntCtrls', [TFlatBtnFace]);
end;

end.
