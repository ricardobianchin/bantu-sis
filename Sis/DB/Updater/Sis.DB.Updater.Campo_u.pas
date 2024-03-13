unit Sis.DB.Updater.Campo_u;

interface

uses Sis.DB.Updater.Campo;

type
  TCampo = class(TInterfacedObject, ICampo)
  private
    FNome: string;
    FTipo: string;
    FPrimaryKey: boolean;
    FNotNull: boolean;
    FUnique: boolean;

    procedure PegarStr(pStr: string);

    function GetNome: string;
    procedure SetNome(Value: string);

    function GetTipo: string;
    procedure SetTipo(Value: string);

    function GetPrimaryKey: boolean;
    procedure SetPrimaryKey(Value: boolean);

    function GetNotNull: boolean;
    procedure SetNotNull(Value: boolean);

    function GetUnique: boolean;
    procedure SetUnique(Value: boolean);

    function GetAsCreateTableField: string;
  public
    property Nome: string read GetNome write SetNome;
    property Tipo: string read GetTipo write SetTipo;
    property PrimaryKey: boolean read GetPrimaryKey write SetPrimaryKey;
    property NotNull: boolean read GetNotNull write SetNotNull;
    property Unique: boolean read GetUnique write SetUnique;
    property AsCreateTableField: string read GetAsCreateTableField;

    constructor Create(pStr: string);
  end;

implementation

uses System.SysUtils;

{ TCampo }

constructor TCampo.Create(pStr: string);
begin
  PegarStr(Pstr);
end;

function TCampo.GetAsCreateTableField: string;
begin
  Result := FNome + ' ' + FTipo;

  if FNotNull then
    Result := Result + ' NOT NULL';
end;

function TCampo.GetNome: string;
begin
  Result := FNome;
end;

function TCampo.GetNotNull: boolean;
begin
  Result := FNotNull;
end;

function TCampo.GetPrimaryKey: boolean;
begin
  Result := FPrimaryKey;
end;

function TCampo.GetTipo: string;
begin
  Result := FTipo;
end;

function TCampo.GetUnique: boolean;
begin
  Result := FUnique;
end;

procedure TCampo.PegarStr(pStr: string);
var
  oPartes: TArray<string>;
  iLen: integer;
begin
  // Dividir a string pStr em um array de strings usando a vírgula como separador
  oPartes := pStr.Split([';']);
  iLen := Length(oPartes);
  if iLen = 0 then
    exit;

  // A primeira parte é sempre o nome do campo
  FNome := oPartes[0];
  FNotNull := False;
  FPrimaryKey := False;
  FUnique := False;
  FTipo := '';

  if iLen > 1 then
  begin
    FTipo := oPartes[1];
  end;

  // Se houver mais de uma parte, a segunda parte indica se o campo é not null ou não
  if iLen > 2 then
  begin
    if oPartes[2] = 'S' then
      FNotNull := True;
  end;

  // Se houver mais de duas oPartes, a terceira parte indica se o campo é primary key ou não
  if iLen > 3 then
  begin
    if oPartes[3] = 'S' then
    begin
      FPrimaryKey := True;
      FNotNull := True;
    end;
  end;

  // Se houver mais de duas oPartes, a terceira parte indica se o campo é unique ou não
  if iLen > 4 then
  begin
    if oPartes[4] = 'S' then
      FUnique := True;
  end;
end;

procedure TCampo.SetNome(Value: string);
begin
  FNome := Value;
end;

procedure TCampo.SetNotNull(Value: boolean);
begin
  FNotNull := Value;
end;

procedure TCampo.SetPrimaryKey(Value: boolean);
begin
  FPrimaryKey := Value;
end;

procedure TCampo.SetTipo(Value: string);
begin
  FTipo := Value;
end;

procedure TCampo.SetUnique(Value: boolean);
begin
  FUnique := Value;
end;

end.
