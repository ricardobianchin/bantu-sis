unit btu.lib.config.factory;

interface

uses btu.lib.config.machineid, btu.lib.config;

function MachineIdCreate: IMachineId;
function SisConfigCreate: ISisConfig;

implementation

uses btu.lib.config.machineid_u, btu.lib.config_u, btu.lib.win.factory, btu.lib.win.VersionInfo;

function MachineIdCreate: IMachineId;
begin
  result := TMachineId.Create;
end;

function SisConfigCreate: ISisConfig;
var
  vLocalMachineId, vServerMachineId: IMachineId;
  vWinVersionInfo: IWinVersionInfo;

begin
  vLocalMachineId := MachineIdCreate;
  vServerMachineId := MachineIdCreate;
  vWinVersionInfo := WinVersionCreate;

  result := TISisConfig.Create(vLocalMachineId, vServerMachineId, vWinVersionInfo)
end;

end.
