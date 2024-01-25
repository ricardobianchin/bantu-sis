unit Sis.DB.Updater.Campo;

interface

type
  ICampo = interface(IInterface)
    ['{4C487CD4-971E-48CB-B1BE-56EE6D6B37D4}']

    function GetNome: string;
    procedure SetNome(Value: string);
    property Nome: string read GetNome write SetNome;

    function GetTipo: string;
    procedure SetTipo(Value: string);
    property Tipo: string read GetTipo write SetTipo;

    function GetPrimaryKey: boolean;
    procedure SetPrimaryKey(Value: boolean);
    property PrimaryKey: boolean read GetPrimaryKey write SetPrimaryKey;

    function GetNotNull: boolean;
    procedure SetNotNull(Value: boolean);
    property NotNull: boolean read GetNotNull write SetNotNull;

    function GetUnique: boolean;
    procedure SetUnique(Value: boolean);
    property Unique: boolean read GetUnique write SetUnique;

    function GetAsCreateTableField: string;
    property AsCreateTableField: string read GetAsCreateTableField;
  end;

implementation

end.
