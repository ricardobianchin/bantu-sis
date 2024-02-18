unit Sis.UI.Controls.TFlatBtn;

interface

uses Vcl.ActnList, Vcl.Controls, FlatBtn;

function FlatBtnCreate(pAction: TAction; pParent: TWinControl;
  var pLeft: integer; pTop: integer; pWidth: integer; pHeight: integer)
  : TFlatBtn;

implementation

uses Sis.UI.Controls.TAction;

function FlatBtnCreate(pAction: TAction; pParent: TWinControl;
  var pLeft: integer; pTop: integer; pWidth: integer; pHeight: integer)
  : TFlatBtn;
var
  sBtnName: string;
begin
  Result := TFlatBtn.Create(pParent);
  Result.Parent := pParent;

  sBtnName := GetActionNamePrefix(pAction.Name) + 'FlatBtn';
  Result.Name := sBtnName;
  Result.Action := pAction;

  Result.Left := pLeft;
  Result.Top := pTop;
  Result.WIdth := pWidth;
  Result.Height := pHeight;

  pLeft := pLeft + pWidth;
end;

end.
