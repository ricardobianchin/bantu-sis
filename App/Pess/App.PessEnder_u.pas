unit App.PessEnder_u;

interface

uses App.PessEnder;

type
  TPessEnder = class(TInterfacedObject, IPessEnder)
  private
    FOrdem: smallint;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FUFSigla: string;
    FCEP: string;
    FMunicipioIbgeId: string;
    FMunicipioNome: string;
    FDDD: string;
    FFone1: string;
    FFone2: string;
    FFone3: string;
    FContato: string;
    FReferencia: string;
    FCriadoEm: TDateTime;
    FAlteradoEm: TDateTime;

    function GetOrdem: smallint;
    procedure SetOrdem(const Value: smallint);

    function GetLogradouro: string;
    procedure SetLogradouro(const Value: string);

    function GetNumero: string;
    procedure SetNumero(const Value: string);

    function GetComplemento: string;
    procedure SetComplemento(const Value: string);

    function GetBairro: string;
    procedure SetBairro(const Value: string);

    function GetMunicipioNome: string;
    procedure SetMunicipioNome(const Value: string);

    function GetUFSigla: string;
    procedure SetUFSigla(const Value: string);

    function GetCEP: string;
    procedure SetCEP(const Value: string);

    function GetMunicipioIbgeId: string;
    procedure SetMunicipioIbgeId(const Value: string);

    function GetDDD: string;
    procedure SetDDD(const Value: string);

    function GetFone1: string;
    procedure SetFone1(const Value: string);

    function GetFone2: string;
    procedure SetFone2(const Value: string);

    function GetFone3: string;
    procedure SetFone3(const Value: string);

    function GetContato: string;
    procedure SetContato(const Value: string);

    function GetReferencia: string;
    procedure SetReferencia(const Value: string);

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(const Value: TDateTime);

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(const Value: TDateTime);

    function GetEnder1: string;
    function GetEnder2: string;
    function GetEnder3: string;
  public
    property Ordem: smallint read GetOrdem write SetOrdem;
    property Logradouro: string read GetLogradouro write SetLogradouro;
    property Numero: string read GetNumero write SetNumero;
    property Complemento: string read GetComplemento write SetComplemento;
    property Bairro: string read GetBairro write SetBairro;
    property MunicipioIbgeId: string read GetMunicipioIbgeId
      write SetMunicipioIbgeId;
    property MunicipioNome: string read GetMunicipioNome write SetMunicipioNome;
    property UFSigla: string read GetUFSigla write SetUFSigla;
    property CEP: string read GetCEP write SetCEP;

    property DDD: string read GetDDD write SetDDD;
    property Fone1: string read GetFone1 write SetFone1;
    property Fone2: string read GetFone2 write SetFone2;
    property Fone3: string read GetFone3 write SetFone3;
    property Contato: string read GetContato write SetContato;
    property Referencia: string read GetReferencia write SetReferencia;
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;
    property Ender1: string read GetEnder1;
    property Ender2: string read GetEnder2;
    property Ender3: string read GetEnder3;
  end;

implementation

uses Sis.Types.Codigos.Utils;

{ TPessEnder }

function TPessEnder.GetBairro: string;
begin
  Result := FBairro;
end;

function TPessEnder.GetCEP: string;
begin
  Result := FCEP;
end;

function TPessEnder.GetComplemento: string;
begin
  Result := FComplemento;
end;

function TPessEnder.GetContato: string;
begin
  Result := FContato;
end;

function TPessEnder.GetCriadoEm: TDateTime;
begin
  Result := FCriadoEm;
end;

function TPessEnder.GetDDD: string;
begin
  Result := FDDD;
end;

function TPessEnder.GetEnder1: string;
var
  sn: string;
begin
  sn := '';

  if FNumero <> '' then
    sn := sn + FNumero;

  if FComplemento <> '' then
    sn := sn + ' ' + FComplemento;

  if sn <> '' then
    sn := ', ' + sn;

  Result := Logradouro + sn;

  if Bairro <> '' then
    Result := Result + ' ' + Bairro;
end;

function TPessEnder.GetEnder2: string;
begin
  Result := MunicipioNome + ' - ' + UFSigla;
end;

function TPessEnder.GetEnder3: string;
begin
  Result := 'Telefone: (' + DDD + ') ' + FoneComMasc(Fone1);
end;

function TPessEnder.GetAlteradoEm: TDateTime;
begin
  Result := FAlteradoEm;
end;

function TPessEnder.GetFone1: string;
begin
  Result := FFone1;
end;

function TPessEnder.GetFone2: string;
begin
  Result := FFone2;
end;

function TPessEnder.GetFone3: string;
begin
  Result := FFone3;
end;

function TPessEnder.GetLogradouro: string;
begin
  Result := FLogradouro;
end;

function TPessEnder.GetMunicipioIbgeId: string;
begin
  Result := FMunicipioIbgeId;
end;

function TPessEnder.GetMunicipioNome: string;
begin
  Result := FMunicipioNome;
end;

function TPessEnder.GetNumero: string;
begin
  Result := FNumero;
end;

function TPessEnder.GetOrdem: smallint;
begin
  Result := FOrdem;
end;

function TPessEnder.GetReferencia: string;
begin
  Result := FReferencia;
end;

function TPessEnder.GetUFSigla: string;
begin
  Result := FUFSigla;
end;

procedure TPessEnder.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TPessEnder.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TPessEnder.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TPessEnder.SetContato(const Value: string);
begin
  FContato := Value;
end;

procedure TPessEnder.SetCriadoEm(const Value: TDateTime);
begin
  FCriadoEm := Value;
end;

procedure TPessEnder.SetDDD(const Value: string);
begin
  FDDD := Value;
end;

procedure TPessEnder.SetAlteradoEm(const Value: TDateTime);
begin
  FAlteradoEm := Value;
end;

procedure TPessEnder.SetFone1(const Value: string);
begin
  FFone1 := Value;
end;

procedure TPessEnder.SetFone2(const Value: string);
begin
  FFone2 := Value;
end;

procedure TPessEnder.SetFone3(const Value: string);
begin
  FFone3 := Value;
end;

procedure TPessEnder.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TPessEnder.SetMunicipioIbgeId(const Value: string);
begin
  FMunicipioIbgeId := Value;
end;

procedure TPessEnder.SetMunicipioNome(const Value: string);
begin
  FMunicipioNome := Value;
end;

procedure TPessEnder.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TPessEnder.SetOrdem(const Value: smallint);
begin
  FOrdem := Value;
end;

procedure TPessEnder.SetReferencia(const Value: string);
begin
  FReferencia := Value;
end;

procedure TPessEnder.SetUFSigla(const Value: string);
begin
  FUFSigla := Value;
end;

end.
