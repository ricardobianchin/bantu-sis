unit Sis.UI.Controls.ComboBoxManager;

interface

type
  IComboBoxManager = interface(IInterface)
    ['{5E857579-21FE-4385-8D57-46437B303C2D}']
    procedure Cicle;
    procedure Clear;

    function GetId: integer;
    procedure SetId(const pId: integer);
    property Id: integer read GetId write SetId;

    function GetIdChar: Char;
    procedure SetIdChar(const pId: Char);
    property IdChar: Char read GetIdChar write SetIdChar;

    function GetText: string;
    procedure SetText(const Value: string);
    property Text: string read GetText write SetText;
  end;

implementation

end.
