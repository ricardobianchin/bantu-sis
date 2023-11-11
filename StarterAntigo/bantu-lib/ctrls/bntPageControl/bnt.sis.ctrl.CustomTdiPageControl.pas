unit bnt.sis.ctrl.CustomTdiPageControl;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ComCtrls;

type
  TCustomTdiPageControl = class(TCustomPageControl)
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
  RegisterComponents('Samples', [TbntPageControl]);
end;

end.
