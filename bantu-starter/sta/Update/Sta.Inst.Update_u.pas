unit Sta.Inst.Update_u;

interface

uses btu.lib.config;

procedure InstUpdate(pSisConfig: ISisConfig);

implementation

var
  sArqLocal: string;

procedure InstUpdate(pSisConfig: ISisConfig);
begin
  sArqLocal := pSisConfig.PastaProduto;
end;

end.
