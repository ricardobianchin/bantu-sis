unit App.PessEnder.List;

interface

uses App.PessEnder, System.Classes;

type
  IPessEnderList = interface(IInterfaceList)
    ['{D24EE17A-0781-4B6D-A604-061356D75E6B}']
    function GetPessEnder(Index: integer): IPessEnder;
    property PessEnder[Index: integer]: IPessEnder read GetPessEnder;
  end;

implementation

end.
