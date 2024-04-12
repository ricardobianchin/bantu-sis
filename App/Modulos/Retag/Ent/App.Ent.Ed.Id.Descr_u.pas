unit App.Ent.Ed.Id.Descr_u;

interface

uses App.Ent.Ed.Id.Descr, App.Ent.Ed.Id_u, Data.DB, Sis.Entidade;

type
  TEntIdDescr = class(TEntEdId, IEntIdDescr)
  private
    FDescr: string;
  protected
    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetDescrCaption: string; virtual;

    { LabeledEdit1.EditLabel.Caption := 'Nome';
      FDescrFieldName
    }

    function GetAsStringExib: string; override;
    function GetStrDescreve: string; virtual;
  public
    property Descr: string read GetDescr write SetDescr;

    function EhIgualA(pOutraEntidade: IEntidade): boolean; override;
    procedure PegueDe(pOutraEntidade: IEntidade); override;
    procedure LimparEnt; override;
    function GetAsString: string; override;
    property DescrCaption: string read GetDescrCaption;

    property StrDescreve: string read GetStrDescreve;

    constructor Create(pState: TDataSetState; pId: integer = 0;
      pDescr: string = '');
  end;

implementation

uses System.SysUtils;

{ TEntIdDescr }

procedure TEntIdDescr.LimparEnt;
begin
  inherited;
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
  s := inherited GetAsString + ' - ' + FDescr;
  Result := s;
end;

function TEntIdDescr.GetAsStringExib: string;
begin
  Result := Id.ToString + ' - ' + Descr;
end;

function TEntIdDescr.GetDescr: string;
begin
  Result := FDescr;
end;

function TEntIdDescr.GetDescrCaption: string;
begin
  Result := 'Descri��o';
end;

function TEntIdDescr.GetStrDescreve: string;
begin
  Result := Id.ToString + ' - ' +Descr;
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
