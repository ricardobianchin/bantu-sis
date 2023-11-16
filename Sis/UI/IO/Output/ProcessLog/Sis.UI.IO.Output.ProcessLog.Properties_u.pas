unit Sis.UI.IO.Output.ProcessLog.Properties_u;

interface

uses Sis.UI.IO.Output.ProcessLog.Types, Sis.UI.IO.Output.ProcessLog.Properties;

type
  TProcessLogProperties = class(TInterfacedObject, IProcessLogProperties)
  private
    FTipo: TProcessLogTipo;
    FNome: string;
    FAssunto: string;

    function GetTipo: TProcessLogTipo;
    procedure SetTipo(Value: TProcessLogTipo);

    function GetAssunto: TProcessLogAssunto;
    procedure SetAssunto(Value: TProcessLogAssunto);

    function GetNome: TProcessLogNome;
    procedure SetNome(Value: TProcessLogNome);
  public
    property Tipo: TProcessLogTipo read GetTipo write SetTipo;
    property Nome: string read GetNome write SetNome;
    property Assunto: string read GetAssunto write SetAssunto;

    constructor Create(pTipo: TProcessLogTipo; pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
  end;

implementation

{ TProcessLogProperties }

constructor TProcessLogProperties.Create(pTipo: TProcessLogTipo; pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
begin
  FTipo := pTipo;
  FAssunto := pAssunto;
  FNome := pNome;
end;

function TProcessLogProperties.GetAssunto: TProcessLogAssunto;
begin
  Result := FAssunto;
end;

function TProcessLogProperties.GetNome: TProcessLogNome;
begin
  Result := FNome;
end;

function TProcessLogProperties.GetTipo: TProcessLogTipo;
begin
  Result := FTipo;
end;

procedure TProcessLogProperties.SetAssunto(Value: TProcessLogAssunto);
begin
  FAssunto := Value;
end;

procedure TProcessLogProperties.SetNome(Value: TProcessLogNome);
begin
  FNome := Value;
end;

procedure TProcessLogProperties.SetTipo(Value: TProcessLogTipo);
begin
  FTipo := Value;
end;

end.
