unit App.Loja_u;

interface

uses App.PessEnder, Sis.Loja_u, App.Loja;

type
  TAppLoja = class(TSisLoja, IAppLoja)
  private
    FApelido: string;
    FNome: string;
    FNomeFantasia: string;
    FC: string;
    FI: string;
    FM: string;
    FMUF: string;
    FEMail: string;

    FEnder: IPessEnder;

    function GetApelido: string;
    procedure SetApelido(const Value: string);

    function GetNome: string;
    procedure SetNome(Value: string);

    function GetNomeFantasia: string;
    procedure SetNomeFantasia(Value: string);

    function GetC: string;
    procedure SetC(const Value: string);

    function GetI: string;
    procedure SetI(const Value: string);

    function GetM: string;
    procedure SetM(const Value: string);

    function GetMUF: string;
    procedure SetMUF(const Value: string);

    function GetEMail: string;
    procedure SetEMail(const Value: string);

    function GetEnder: IPessEnder;
  public
    property Apelido: string read GetApelido write SetApelido;
    property Nome: string read GetNome write SetNome;
    property NomeFantasia: string read GetNomeFantasia write SetNomeFantasia;
    property C: string read GetC write SetC;
    property I: string read GetI write SetI;
    property M: string read GetM write SetM;
    property MUF: string read GetMUF write SetMUF;
    property EMail: string read GetEMail write SetEMail;
    property Ender: IPessEnder read GetEnder;

    constructor Create(pDescr: string = ''; pId: integer = 0);
  end;

implementation

uses App.Pess.Ent.Factory_u;

{ TAppLoja }

constructor TAppLoja.Create(pDescr: string; pId: integer);
begin
  inherited Create(pDescr, pId);
  FEnder := PessEnderCreate;
end;

function TAppLoja.GetApelido: string;
begin
  Result := FApelido;
end;

function TAppLoja.GetC: string;
begin
  Result := FC;
end;

function TAppLoja.GetEMail: string;
begin
  Result := FEMail;
end;

function TAppLoja.GetEnder: IPessEnder;
begin
  Result := FEnder;
end;

function TAppLoja.GetI: string;
begin
  Result := FI;
end;

function TAppLoja.GetM: string;
begin
  Result := FM;
end;

function TAppLoja.GetMUF: string;
begin
  Result := FMUF;
end;

function TAppLoja.GetNome: string;
begin
  Result := FNome;
end;

function TAppLoja.GetNomeFantasia: string;
begin
  Result := FNomeFantasia;
end;

procedure TAppLoja.SetApelido(const Value: string);
begin
  FApelido := Value;
end;

procedure TAppLoja.SetC(const Value: string);
begin
  FC := Value;
end;

procedure TAppLoja.SetEMail(const Value: string);
begin
  FEMail := Value;
end;

procedure TAppLoja.SetI(const Value: string);
begin
  FI := Value;
end;

procedure TAppLoja.SetM(const Value: string);
begin
  FM := Value;
end;

procedure TAppLoja.SetMUF(const Value: string);
begin
  FMUF := Value;
end;

procedure TAppLoja.SetNome(Value: string);
begin
  FNome := Value;
end;

procedure TAppLoja.SetNomeFantasia(Value: string);
begin
  FNomeFantasia := Value;
end;

end.
