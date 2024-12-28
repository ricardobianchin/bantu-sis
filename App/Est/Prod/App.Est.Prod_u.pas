unit App.Est.Prod_u;

interface

uses App.Est.Prod, Sis.Types;

type
  TProd = class(TInterfacedObject, IProd)
  private
    FId: TId;
    FDescrRed: string;
    FFabrNome: string;
    FUnidSigla: string;

    function GetId: TId;
    procedure SetId(Value: TId);

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetFabrNome: string;
    procedure SetFabrNome(Value: string);

    function GetUnidSigla: string;
    procedure SetUnidSigla(Value: string);
  public
    property Id: TId read GetId write SetId;
    property DescrRed: string read GetDescrRed write SetDescrRed;
    property FabrNome: string read GetFabrNome write SetFabrNome;
    property UnidSigla: string read GetUnidSigla write SetUnidSigla;

    constructor Create(pId: TId; pDescrRed, pFabrNome, pUnidSigla: string);
  end;

implementation

{ TProd }

constructor TProd.Create(pId: TId; pDescrRed, pFabrNome, pUnidSigla: string);
begin
  FId := pId;
  FDescrRed := pDescrRed;
  FFabrNome := pFabrNome;
  FUnidSigla := pUnidSigla;
end;

function TProd.GetDescrRed: string;
begin
  Result := FDescrRed;
end;

function TProd.GetFabrNome: string;
begin
  Result := FFabrNome;
end;

function TProd.GetId: TId;
begin
  Result := FId;
end;

function TProd.GetUnidSigla: string;
begin
  Result := FUnidSigla;
end;

procedure TProd.SetDescrRed(Value: string);
begin
  FDescrRed := Value;
end;

procedure TProd.SetFabrNome(Value: string);
begin
  FFabrNome := Value;
end;

procedure TProd.SetId(Value: TId);
begin
  FId := Value;
end;

procedure TProd.SetUnidSigla(Value: string);
begin
  FUnidSigla := Value;
end;

end.
