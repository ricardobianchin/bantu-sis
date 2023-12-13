unit Sis.DB.Updater.Comando.List_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.List, Sis.DB.Updater.Comando;

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
