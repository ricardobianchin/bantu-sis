unit FlatBtn;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, CustomFlatBtn;

type
  TFlatBtn = class(TCustomFlatBtn)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    property Caption;
  published
    { Published declarations }
    property Action;
    property Height;
    property Width;
    property Top;
    property Left;
    property ShowCaption;
    property ShowIcon;
    property Enabled;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Btu', [TFlatBtn]);
end;

end.
