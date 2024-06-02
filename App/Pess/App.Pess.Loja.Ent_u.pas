unit App.Pess.Loja.Ent_u;

interface

uses App.Pess.Loja.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Types;

type
  TPessLojaEnt = class(TPessEnt, IPessLojaEnt)
  private
  public
    constructor Create(pPessEnderList: IPessEnderList);
  end;

implementation

uses Data.DB;

{ TPessLojaEnt }

constructor TPessLojaEnt.Create(pPessEnderList: IPessEnderList);
begin
  inherited Create(dsBrowse, pPessEnderList,
    TEnderQuantidadePermitida.endqtdUm);
end;

end.
