unit App.Pess.Ent.Factory_u;

interface

uses App.PessEnder.List;

function PessEnderListCreate: IPessEnderList;//privativo desta unit

implementation

uses App.PessEnder.List_u;

function PessEnderListCreate: IPessEnderList;//privativo desta unit
begin
  Result := TPessEnderList.Create;
end;


end.
