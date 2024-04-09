unit Sis.DB.UltimoId_u;

interface

uses Sis.DB.UltimoId, Sis.Lists.IdItem_u, Data.DB;

type
  TUltimoId = class(TIdItem, IUltimoId)
  private
    FCodsBarras: string;
    FQ: TDataSet;

  protected
    procedure SetId(Value: integer); override;
    procedure VaiManterId(Value: integer); virtual;
    procedure VaiMudarId(Value: integer); virtual;
    property q: TDataSet read FQ;
  public
    constructor Create(pQ: TDataSet);
  end;

implementation

{ TUltimoId }

procedure TUltimoId.VaiManterId(Value: integer);
begin

end;

procedure TUltimoId.VaiMudarId(Value: integer);
begin
  if q.state in [dsInsert, dsEdit] then
    q.Post;
  q.Append;

end;

constructor TUltimoId.Create(pQ: TDataSet);
begin
  inherited Create(0);
  FQ := pQ;
end;

procedure TUltimoId.SetId(Value: integer);
begin
  if Value = Id then
    VaiManterId(Value)
  else
    VaiMudarId(Value);
  inherited SetId(Value);
end;

end.
