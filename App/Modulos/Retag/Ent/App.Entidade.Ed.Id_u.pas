unit App.Entidade.Ed.Id_u;

interface

uses App.Entidade.Ed.Id, Data.DB, App.Entidade.Ed_u, Sis.Entidade;

type
  TEntId = class(TEntidadeEd, IEntId)
  private
    FId: integer;
  protected
    function GetId: integer; virtual;
    procedure SetId(Value: integer); virtual;
    function GetAsString: string; virtual;
  public
    property AsString: string read GetAsString;
    property Id: integer read GetId write SetId;
    constructor Create(pState: TDataSetState; pId: integer = 0);
    function EhIgualA(pOutraEntidade: IEntidade): boolean; override;
    procedure PegueDe(pOutraEntidade: IEntidade); override;
    procedure Clear; override;
  end;

implementation

uses System.SysUtils;

{ TEntId }

procedure TEntId.Clear;
begin
  inherited Clear;
  FId := 0;
end;

constructor TEntId.Create(pState: TDataSetState; pId: integer);
begin
  inherited Create(pState);
  FId := pId;
end;

function TEntId.EhIgualA(pOutraEntidade: IEntidade): boolean;
begin
  Result := Supports(Self, IEntId);
  if not Result then
    exit;

  Result := Supports(pOutraEntidade, IEntId);
  if not Result then
    exit;

  Result := State = dsInsert;
  if Result then
    exit;

  Result := FId = IEntId(pOutraEntidade).Id;
end;

function TEntId.GetAsString: string;
begin
  Result := IntToStr(FId);
end;

function TEntId.GetId: integer;
begin
  Result := FId;
end;

procedure TEntId.PegueDe(pOutraEntidade: IEntidade);
begin
  inherited;
  FId := TEntId(pOutraEntidade).Id;
end;

procedure TEntId.SetId(Value: integer);
begin
  FId := Value;
end;

end.

