unit Sis.DB.DBConfig;

interface

type
  IDBConfig = interface(IInterface)
    ['{5B5BC24C-3F0B-4F67-8BAC-25655DC42B6E}']
    procedure SetAsString(pChave: string; pValor: string);

    function GetAsString(pChave: string): string; overload;
    function GetAsString(pChave: string; pDefaultValor: string): string; overload;


    procedure SetAsBoolean(pChave: Boolean; pValor: Boolean);

    function GetAsBoolean(pChave: Boolean): Boolean; overload;
    function GetAsBoolean(pChave: Boolean; pDefaultValor: Boolean): Boolean; overload;


    procedure SetAsInteger(pChave: integer; pValor: integer);

    function GetAsInteger(pChave: integer): integer; overload;
    function GetAsInteger(pChave: integer; pDefaultValor: integer): integer; overload;
  end;

implementation

end.
