unit App.Entidade.Ed.Unid_u;

interface

uses App.Entidade.Ed.Id.Descr_u, App.Entidade.Ed.Unid, Data.DB, Sis.Entidade;

type
  TEntUnid = class(TEntIdDescr, IEntUnid)
  private
    FSigla: string;
    function GetSigla: string;
    procedure SetSigla(Value: string);
  public
    property Sigla: string read GetSigla write SetSigla;

    function EhIgualA(pOutraEntidade: IEntidade): boolean; override;
    procedure PegueDe(pOutraEntidade: IEntidade); override;
    procedure Clear; override;
    function GetAsString: string; override;

    constructor Create(pState: TDataSetState; pId: integer = 0;
      pDescr: string = ''; pSigla: string = ''{ pDescrCaption: string = 'Descrição'}); reintroduce;
  end;

implementation

uses System.SysUtils;

{ TEntUnid }

procedure TEntUnid.Clear;
begin
  inherited;
  FSigla := '';
end;

constructor TEntUnid.Create(pState: TDataSetState; pId: integer; pDescr,
  pSigla: string);
begin
  inherited Create(pState, pId, pDescr, 'Descrição');
  FSigla := pSigla;
end;

function TEntUnid.EhIgualA(pOutraEntidade: IEntidade): boolean;
begin
  Result := Supports(Self, IEntUnid);
  if not Result then
    exit;

  Result := Supports(pOutraEntidade, IEntUnid);
  if not Result then
    exit;

  Result := FSigla = IEntUnid(pOutraEntidade).Sigla;
  if not Result then
    exit;

  Result := inherited EhIgualA(pOutraEntidade);
  if not Result then
    exit;
end;

function TEntUnid.GetAsString: string;
var
  s: string;
begin
  s := inherited GetAsString + ' - ' + FSigla;
  Result := s;
end;

function TEntUnid.GetSigla: string;
begin
  Result := FSigla;
end;

procedure TEntUnid.PegueDe(pOutraEntidade: IEntidade);
begin
  inherited PegueDe(pOutraEntidade);
  FSigla := TEntUnid(pOutraEntidade).Sigla;
end;

procedure TEntUnid.SetSigla(Value: string);
begin
  FSigla := Value;
end;

end.
