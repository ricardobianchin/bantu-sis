unit btu.lib.db.updater.comando.list;

interface

uses System.Classes, btu.lib.db.updater.comando;

type
  IComandoList = interface(IInterfaceList)
    ['{0937539B-88C1-45C9-B4AE-36DEE1999DAB}']

    function GetComando(Index: integer): IComando;
    property Comando[Index: integer]: IComando read GetComando; default;
  end;

implementation

end.
