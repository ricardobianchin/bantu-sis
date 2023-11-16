unit btu.lib.db.updater.comando.list_u;

interface

uses btu.lib.db.updater.comando.list, System.Classes, btu.lib.db.updater.comando;

type
  TComandoList = class(TInterfaceList, IComandoList)
  private
    function GetComando(Index: integer): IComando;
  public
    property Comando[Index: integer]: IComando read GetComando; default;
  end;

implementation

{ TComandoList }

function TComandoList.GetComando(Index: integer): IComando;
begin
  Result := IComando(Items[Index]);
end;

end.
