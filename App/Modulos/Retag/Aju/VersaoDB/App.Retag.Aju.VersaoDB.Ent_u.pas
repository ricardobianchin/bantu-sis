unit App.Retag.Aju.VersaoDB.Ent_u;

interface

uses App.Ent.Ed.Id_u, Data.DB, Sis.DB.DBTypes, Sis.Types.Utils_u, App.Retag.Aju.VersaoDB.Ent;

type
  TVersaoDBEnt = class(TEntEdId, IVersaoDBEnt)
  private
    FDtHIns: TDateTime;
    FAssunto: string;
    FObjetivo: string;
    FObs: string;

    function GetDtHIns: TDateTime;
    procedure SetDtHIns(Value: TDateTime);

    function GetAssunto: string;
    procedure SetAssunto(Value: string);

    function GetObjetivo: string;
    procedure SetObjetivo(Value: string);

    function GetObs: string;
    procedure SetObs(Value: string);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property DtHIns: TDateTime read GetDtHIns write SetDtHIns;
    property Assunto: string read GetAssunto write SetAssunto;
    property Objetivo: string read GetObjetivo write SetObjetivo;
    property Obs: string read GetObs write SetObs;

    procedure LimparEnt; override;
  end;

  implementation

{ TVersaoDBEnt }

function TVersaoDBEnt.GetAssunto: string;
begin
  Result := FAssunto;
end;

function TVersaoDBEnt.GetDtHIns: TDateTime;
begin
  Result := FDtHIns;
end;

function TVersaoDBEnt.GetNomeEnt: string;
begin
  Result := 'Versão do DB';
end;

function TVersaoDBEnt.GetNomeEntAbrev: string;
begin
  Result := 'VrDB';
end;

function TVersaoDBEnt.GetObjetivo: string;
begin
  Result := FObjetivo;
end;

function TVersaoDBEnt.GetObs: string;
begin
  Result := FObs;
end;

function TVersaoDBEnt.GetTitulo: string;
begin
  Result := 'Versões do DB';
end;

procedure TVersaoDBEnt.LimparEnt;
begin
  FDtHIns := 0;
  FAssunto := '';
  FObjetivo := '';
  FObs := '';
end;

procedure TVersaoDBEnt.SetAssunto(Value: string);
begin
  FAssunto := Value;
end;

procedure TVersaoDBEnt.SetDtHIns(Value: TDateTime);
begin
  FDtHIns := Value;
end;

procedure TVersaoDBEnt.SetObjetivo(Value: string);
begin
  FObjetivo := Value;
end;

procedure TVersaoDBEnt.SetObs(Value: string);
begin
  FObs := Value;
end;

end.
