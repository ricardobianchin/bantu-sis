unit btu.lib.entit.factory;

interface

uses btu.lib.entit.loja;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;

implementation

uses btu.lib.entit.loja_u;

function LojaCreate(pDescr:string; pId:integer): ILoja;
begin
  result := TLoja.Create(pDescr, pId);
end;

end.
