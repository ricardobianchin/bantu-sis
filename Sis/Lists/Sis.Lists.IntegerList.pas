unit Sis.Lists.IntegerList;

interface

uses Sis.Lists.Lista, System.Classes;

type
  IIntegerList = interface(ILista)
    ['{47D2A81E-E7D8-4D30-B5AE-3C5DFD20C99E}']
    function Add(Valor: integer): integer;
    function GetInteger(Index: integer): integer;
    property Integers[Index:integer]: integer read GetInteger; default;
  end;

implementation

end.
