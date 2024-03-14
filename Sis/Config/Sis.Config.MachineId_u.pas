unit Sis.Config.MachineId_u;

interface

uses Sis.Config.MachineId;

type
  TMachineId = class(TInterfacedObject, IMachineId)
  private
    FName: string;
    FIp: string;
    FIdentId: smallint;

    function GetName: string;
    procedure SetName(const Value: string);

    function GetIp: string;
    procedure SetIp(const Value: string);

    function GetIdentId: smallint;
    procedure SetIdentId(const Value: smallint);

  public
    property Name: string read GetName write SetName;
    property Ip: string read GetIp write SetIp;

    function GetIsDataOk: boolean;
    property IsDataOk: boolean read GetIsDataOk;

    function GetIdent: string;

    procedure Zerar;

    constructor Create;

    property IdentId: smallint read GetIdentId write SetIdentId;

  end;

implementation

uses System.SysUtils, Sis.Types.Utils_u, Sis.Types.Bool_u;

{ TMachineId }

constructor TMachineId.Create;
begin
  Zerar;
end;

function TMachineId.GetIp: string;
begin
  Result := FIp;
end;

function TMachineId.GetIsDataOk: boolean;
begin
  Result := (FName <> '') or (FIp <> '')
end;

function TMachineId.GetName: string;
begin
  Result := FName;
end;

function TMachineId.GetIdent: string;
begin
  result := Iif(FName = '', FIp, FName);
end;

function TMachineId.GetIdentId: smallint;
begin
  Result := FIdentId;
end;

procedure TMachineId.SetIdentId(const Value: smallint);
begin
  FIdentId := Value;
end;

procedure TMachineId.SetIp(const Value: string);
begin
  FIp := Trim(Value);
end;

procedure TMachineId.SetName(const Value: string);
begin
  FName := Trim(Value);
end;

procedure TMachineId.Zerar;
begin
  FName := '';
  FIp := '';
end;

end.
