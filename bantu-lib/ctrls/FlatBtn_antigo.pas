unit FlatBtn_antigo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, CustomFlatBtn;

type
  TFlatBtn = class(TCustomFlatBtn)
  private
  protected
  public
  published
    property Caption;
    property OnClick;
    property OnPaint;
    property Action;
    property ImageList;
    property ImageIndex;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('bntControls', [TFlatBtn]);
end;

{ TFlatBtn }

end.
