unit Sis.Entities.Factory;

interface

uses Sis.Loja;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;

implementation

uses Sis.Usuario_u, Sis.Loja_u;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;
begin
  Result := TLoja.Create(pDescr, pId);
end;

end.
