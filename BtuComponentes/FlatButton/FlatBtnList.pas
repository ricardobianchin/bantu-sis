unit FlatBtnList;

interface

uses System.Classes, FlatBtn, Vcl.Controls, Vcl.ActnList;

type
  TFlatBtnList = class(TList)
  private

    FLeftAtual: integer;
    FTopAtual: integer;

    FMargEsq: integer;
    FMargSup: integer;

    function GetFlatBtns(Index: integer): TFlatBtn;
    function GetFlatBtnByName(pName: string): TFlatBtn;
    procedure SetMargEsq(const Value: integer);
    procedure SetMargSup(const Value: integer);
  public
    function Add(pFlatBtn: TFlatBtn): Integer;

    property LeftAtual: integer read FLeftAtual write FLeftAtual;
    property TopAtual: integer read FTopAtual write FTopAtual;

    property MargEsq: integer read FMargEsq write SetMargEsq;
    property MargSup: integer read FMargSup write SetMargSup;

    function AddFlatBtn(pParent: TWinControl; pWidth: integer; pHeight: integer;
      pAction: TAction; pMaxLarg: integer = 0): integer;

    property FlatBtns[Index: integer]: TFlatBtn read GetFlatBtns; default;
    property FlatBtnByName[pName: string]: TFlatBtn read GetFlatBtnByName;
    constructor Create(pMargEsq: integer = 0; pMargSup: integer = 0);
  end;

implementation

{ TFlatBtnList }

uses Sis.UI.Controls.TAction, Sis.UI.Controls.TFlatBtn;

function TFlatBtnList.Add(pFlatBtn: TFlatBtn): Integer;
begin
  Result := inherited Add(pFlatBtn);
end;

function TFlatBtnList.AddFlatBtn(pParent: TWinControl; pWidth, pHeight: integer;
  pAction: TAction; pMaxLarg: integer): integer;
var
  sName: string;
  oFlatBtn: TFlatBtn;
begin
  sName := GetActionNamePrefix(pAction.Name)+'FlatBtn';

  oFlatBtn := TFlatBtn.Create(pParent);
  oFlatBtn.Parent := pParent;
  oFlatBtn.Left := FLeftAtual;
  oFlatBtn.Top := FTopAtual;
  oFlatBtn.WIdth := pWidth;
  oFlatBtn.Height := pHeight;
  oFlatBtn.Action := pAction;

  FLeftAtual := FLeftAtual + pWidth;
end;

constructor TFlatBtnList.Create(pMargEsq: integer; pMargSup: integer);
begin
  inherited Create;
  SetMargEsq(pMargEsq);
  SetMargSup(pMargSup);
end;

function TFlatBtnList.GetFlatBtnByName(pName: string): TFlatBtn;
var
  I: Integer;
  oFlatBtn: TFlatBtn;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    oFlatBtn := GetFlatBtns(I);
    if oFlatBtn.Name = pName then
    begin
      Result := oFlatBtn;
      break;
    end;
  end;
end;

function TFlatBtnList.GetFlatBtns(Index: integer): TFlatBtn;
begin
  Result := TFlatBtn(Items[Index]);
end;

procedure TFlatBtnList.SetMargEsq(const Value: integer);
begin
  FMargEsq := Value;
  FLeftAtual := Value;
end;

procedure TFlatBtnList.SetMargSup(const Value: integer);
begin
  FMargSup := Value;
  FTopAtual := Value;
end;

end.
