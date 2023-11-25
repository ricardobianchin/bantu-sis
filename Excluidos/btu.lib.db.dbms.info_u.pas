unit btu.lib.db.dbms.info_u;

interface

uses btu.lib.db.types;

type
  TDBMSInfo = class(TInterfacedObject, IDBMSInfo)
  private
    FVersion: TDBVersion;
    FDBMSType: TDBMSType;
    FDBFramework: TDBFramework;

    function GetVersion: TDBVersion;
    procedure SetVersion(Value: TDBVersion);

    function GeTDBMSType: TDBMSType;
    procedure SeTDBMSType(Value: TDBMSType);

    function GetDBFramework: TDBFramework;
    procedure SetDBFramework(Value: TDBFramework);

   function GetNome: string;
  public
    property Version: TDBVersion read GetVersion write SetVersion;
    property DBMSType: TDBMSType read GeTDBMSType write SeTDBMSType;
    property DBFramework: TDBFramework read GetDBFramework write SetDBFramework;
    property Nome: string read GetNome;

    constructor Create(pVersion: TDBVersion = 0; pDBMSType: TDBMSType = dbmstUnknown; pDBFramework: TDBFramework = dbfrFireDAC);
  end;

implementation

{ TDBMSInfo }

constructor TDBMSInfo.Create(pVersion: TDBVersion;
  pDBMSType: TDBMSType; pDBFramework: TDBFramework);
begin
  FVersion := pVersion;
  FDBMSType := pDBMSType;
  FDBFramework := pDBFramework;
end;

function TDBMSInfo.GetDBFramework: TDBFramework;
begin
  result := FDBFramework;
end;

function TDBMSInfo.GeTDBMSType: TDBMSType;
begin
  Result := FDBMSType;
end;

function TDBMSInfo.GetNome: string;
begin
  Result := DBMSNames[FDBMSType];
end;

function TDBMSInfo.GetVersion: TDBVersion;
begin
  Result := FVersion;
end;

procedure TDBMSInfo.SetDBFramework(Value: TDBFramework);
begin
  FDBFramework := Value;
end;

procedure TDBMSInfo.SeTDBMSType(Value: TDBMSType);
begin
  FDBMSType := Value;
end;

procedure TDBMSInfo.SetVersion(Value: TDBVersion);
begin
  FVersion := Value;
end;

end.
