unit App.Testes.Config.ModuRetag.Ajuda.BemVindo.Terminais;

interface

type
  ITesteConfigModuRetagAjudaBemVindoTerminais = interface(IInterface)
    ['{84FE6DC3-2DAC-4D31-AF1B-AF439C07B304}']
    function GetSelectTerminalIds: string;
    procedure SetSelectTerminalIds(Value: string);
    property SelectTerminalIds: string read GetSelectTerminalIds write SetSelectTerminalIds;

    procedure SetAutoExec(Value: Boolean);
    function GetAutoExec: boolean;
    property AutoExec: Boolean read GetAutoExec write SetAutoExec;
  end;

implementation

end.
