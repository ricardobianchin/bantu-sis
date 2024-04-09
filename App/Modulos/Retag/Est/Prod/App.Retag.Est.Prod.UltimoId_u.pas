unit App.Retag.Est.Prod.UltimoId_u;

interface

uses Sis.DB.UltimoId_u, Data.DB;

type
  TProdEdUltimoId = class(TUltimoId)
  private
    FCodsBarras: string;
  protected
    procedure VaiManterId(Value: integer); override;
    procedure VaiMudarId(Value: integer); override;
  public
    procedure Zerar; override;
    constructor Create(pQ: TDataSet);
  end;

implementation

{ TProdEdUltimoId }

constructor TProdEdUltimoId.Create(pQ: TDataSet);
begin
  inherited Create(pQ);
  FCodsBarras := '';
end;

procedure TProdEdUltimoId.VaiManterId(Value: integer);
begin
  inherited;

end;

procedure TProdEdUltimoId.VaiMudarId(Value: integer);
begin
  inherited;

end;

procedure TProdEdUltimoId.Zerar;
begin
  inherited;
  FCodsBarras := '';
end;

end.
