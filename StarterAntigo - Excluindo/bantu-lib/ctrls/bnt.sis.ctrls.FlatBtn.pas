unit bnt.sis.ctrls.FlatBtn;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, bnt.sis.ctrls.CustomFlatBtn;

type
  TFlatBtn = class(TCustomFlatBtn)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property Face;
    property TabOrder;
    property TabStop;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('bntCtrls', [TFlatBtn]);
end;

end.
