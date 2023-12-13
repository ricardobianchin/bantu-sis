unit Sis.Config.MachineId_u;

interface

uses Sis.Config.MachineId;

type
  TMachineId = class(TInterfacedObject, IMachineId)
  private
    FName: string;
    FIp: string;

    function GetName: string;
    procedure SetName(const Value: string);

    function GetIp: string;
    procedure SetIp(const Value: string);

  public
    property Name: string read GetName write SetName;
    property Ip: string read GetIp write SetIp;

    function GetIsDataOk: boolean;
    property IsDataOk: boolean read GetIsDataOk;

    function GetServerName: string;

    procedure Zerar;

    constructor Create;
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

function TMachineId.GetServerName: string;
begin
  result := Iif(FName = '', FIp, FName);
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
