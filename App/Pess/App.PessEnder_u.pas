unit App.PessEnder_u;

interface

uses App.PessEnder;

type
  TEnder = class(TInterfacedObject, IEnder)
  private
    FOrdem: smallint;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FMunicipio: string;
    FUFSigla: string;
    FCEP: string;
    FMunicipioIbgeId: string;
    FDDD: string;
    FFone1: string;
    FFone2: string;
    FFone3: string;
    FContato: string;
    FEMail: string;
    FReferencia: string;
    FCriadoEm: TDateTime;
    FEditadoEm: TDateTime;

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

    function GetMunicipio: string;
    procedure SetMunicipio(const Value: string);

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

    function GetEMail: string;
    procedure SetEMail(const Value: string);

    function GetReferencia: string;
    procedure SetReferencia(const Value: string);

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(const Value: TDateTime);

    function GetEditadoEm: TDateTime;
    procedure SetEditadoEm(const Value: TDateTime);

  public
    property Ordem: smallint read GetOrdem write SetOrdem;
    property Logradouro: string read GetLogradouro write SetLogradouro;
    property Numero: string read GetNumero write SetNumero;
    property Complemento: string read GetComplemento write SetComplemento;
    property Bairro: string read GetBairro write SetBairro;
    property Municipio: string read GetMunicipio write SetMunicipio;
    property UFSigla: string read GetUFSigla write SetUFSigla;
    property CEP: string read GetCEP write SetCEP;
    property MunicipioIbgeId: string read GetMunicipioIbgeId write SetMunicipioIbgeId;
    property DDD: string read GetDDD write SetDDD;
    property Fone1: string read GetFone1 write SetFone1;
    property Fone2: string read GetFone2 write SetFone2;
    property Fone3: string read GetFone3 write SetFone3;
    property Contato: string read GetContato write SetContato;
    property EMail: string read GetEMail write SetEMail;
    property Referencia: string read GetReferencia write SetReferencia;
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;
    property EditadoEm: TDateTime read GetEditadoEm write SetEditadoEm;
  end;

implementation

{ TEnder }

function TEnder.GetBairro: string;
begin
  Result := FBairro;
end;

function TEnder.GetCEP: string;
begin
  Result := FCEP;
end;

function TEnder.GetComplemento: string;
begin
  Result := FComplemento;
end;

function TEnder.GetContato: string;
begin
  Result := FContato;
end;

function TEnder.GetCriadoEm: TDateTime;
begin
  Result := FCriadoEm;
end;

function TEnder.GetDDD: string;
begin
  Result := FDDD;
end;

function TEnder.GetEditadoEm: TDateTime;
begin
  Result := FEditadoEm;
end;

function TEnder.GetEMail: string;
begin
  Result := FEMail;
end;

function TEnder.GetFone1: string;
begin
  Result := FFone1;
end;

function TEnder.GetFone2: string;
begin
  Result := FFone2;
end;

function TEnder.GetFone3: string;
begin
  Result := FFone3;
end;

function TEnder.GetLogradouro: string;
begin
  Result := FLogradouro;
end;

function TEnder.GetMunicipio: string;
begin
  Result := FMunicipio;
end;

function TEnder.GetMunicipioIbgeId: string;
begin
  Result := FMunicipioIbgeId;
end;

function TEnder.GetNumero: string;
begin
  Result := FNumero;
end;

function TEnder.GetOrdem: smallint;
begin
  Result := FOrdem;
end;

function TEnder.GetReferencia: string;
begin
  Result := FReferencia;
end;

function TEnder.GetUFSigla: string;
begin
  Result := FUFSigla;
end;

procedure TEnder.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEnder.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TEnder.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEnder.SetContato(const Value: string);
begin
  FContato := Value;
end;

procedure TEnder.SetCriadoEm(const Value: TDateTime);
begin
  FCriadoEm := Value;
end;

procedure TEnder.SetDDD(const Value: string);
begin
  FDDD := Value;
end;

procedure TEnder.SetEditadoEm(const Value: TDateTime);
begin
  FEditadoEm := Value;
end;

procedure TEnder.SetEMail(const Value: string);
begin
  FEMail := Value;
end;

procedure TEnder.SetFone1(const Value: string);
begin
  FFone1 := Value;
end;

procedure TEnder.SetFone2(const Value: string);
begin
  FFone2 := Value;
end;

procedure TEnder.SetFone3(const Value: string);
begin
  FFone3 := Value;
end;

procedure TEnder.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TEnder.SetMunicipio(const Value: string);
begin
  FMunicipio := Value;
end;

procedure TEnder.SetMunicipioIbgeId(const Value: string);
begin
  FMunicipioIbgeId := Value;
end;

procedure TEnder.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TEnder.SetOrdem(const Value: smallint);
begin
  FOrdem := Value;
end;

procedure TEnder.SetReferencia(const Value: string);
begin
  FReferencia := Value;
end;

procedure TEnder.SetUFSigla(const Value: string);
begin
  FUFSigla := Value;
end;

end.
