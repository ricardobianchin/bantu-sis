unit App.Entidade.Ed.Id.Descr_u;

interface

uses App.Entidade.Ed.Id.Descr, App.Entidade.Ed.Id_u, Data.DB, Sis.Entidade;

type
  TEntIdDescr = class(TEntId, IEntIdDescr)
  private
    FDescr: string;
  protected
    function GetDescr: string;
    procedure SetDescr(Value: string);
  public
    property Descr: string read GetDescr write SetDescr;

    constructor Create(pState: TDataSetState; pId: integer = 0; pDescr: string = '');
    function EhIgualA(pOutraEntidade: IEntidade): boolean; override;
    procedure PegueDe(pOutraEntidade: IEntidade); override;
    procedure Clear; override;
    function GetAsString: string; override;
  end;

implementation

uses System.SysUtils;

{ TEntIdDescr }

procedure TEntIdDescr.Clear;
begin
  inherited Clear;
  FDescr := '';
end;

constructor TEntIdDescr.Create(pState: TDataSetState; pId: integer;
  pDescr: string);
begin
  inherited Create(pState, pId);
  FDescr := pDescr;
end;

function TEntIdDescr.EhIgualA(pOutraEntidade: IEntidade): boolean;
begin
  Result := Supports(Self, IEntIdDescr);
  if not Result then
    exit;

  Result := Supports(pOutraEntidade, IEntIdDescr);
  if not Result then
    exit;

  Result := inherited EhIgualA(pOutraEntidade);
  if not Result then
    exit;
  Result := FDescr = IEntIdDescr(pOutraEntidade).Descr;
end;

function TEntIdDescr.GetAsString: string;
var
  s: string;
begin
  s := inherited GetAsString +' - '+ FDescr;
  Result := s;
end;

function TEntIdDescr.GetDescr: string;
begin
  Result := FDescr;
end;

procedure TEntIdDescr.PegueDe(pOutraEntidade: IEntidade);
begin
  inherited PegueDe(pOutraEntidade);
  FDescr := TEntIdDescr(pOutraEntidade).Descr;
end;

procedure TEntIdDescr.SetDescr(Value: string);
begin
  FDescr := Value;
end;

end.
