unit App.UI.Form.DataSet.Est.Saldo_u_HistProdFormList_u;

interface

uses App.UI.Form.DataSet.Est.Saldo_u_HistProdFormRecord, Sis.Types, Vcl.Forms,
  App.UI.Form.DataSet.Est.Saldo_u_HistProdFormList, System.Generics.Collections;

type
  THistProdFormList = class(TInterfacedObject, IHistProdFormList)
  private
    FList: TList<THistProdFormRecord>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddRecord(AProdId: TId; AForm: TForm);
    function FindIndexByProdId(AProdId: TId): Integer;
    procedure RemoveByProdId(AProdId: TId);
    procedure Clear;
    function Count: Integer;
    procedure BringToFront(AProdId: TId);
    procedure FecheForms;
  end;

implementation

{ THistProdFormList }

procedure THistProdFormList.AddRecord(AProdId: TId; AForm: TForm);
var
  Rec: THistProdFormRecord;
begin
  Rec.ProdId := AProdId;
  Rec.Form := AForm;
  FList.Add(Rec);
end;

procedure THistProdFormList.BringToFront(AProdId: TId);
var
  i: integer;
begin
  i := FindIndexByProdId(AProdId);
  if i = -1 then
    exit;

  FList[i].Form.BringToFront;
end;

procedure THistProdFormList.Clear;
begin
  FList.Clear;
end;

function THistProdFormList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor THistProdFormList.Create;
begin
  inherited;
  FList := TList<THistProdFormRecord>.Create;
end;

destructor THistProdFormList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

procedure THistProdFormList.FecheForms;
begin
  while FList.Count > 0 do
    FList[0].Form.Close;
end;

function THistProdFormList.FindIndexByProdId(AProdId: TId): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FList.Count - 1 do
    if FList[I].ProdId = AProdId then
    begin
      Result := I;
      Break;
    end;
end;

procedure THistProdFormList.RemoveByProdId(AProdId: TId);
var
  Index: Integer;
begin
  Index := FindIndexByProdId(AProdId);
  if Index >= 0 then
    FList.Delete(Index);
end;

end.
