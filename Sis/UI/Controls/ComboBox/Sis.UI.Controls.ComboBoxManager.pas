unit Sis.UI.Controls.ComboBoxManager;

interface

type
  IComboBoxManager = interface(IInterface)
    ['{5E857579-21FE-4385-8D57-46437B303C2D}']
    procedure Cicle;

    procedure SetId(const pId: integer);
    function GetId: integer;
    property Id: integer read GetId write SetId;
  end;

implementation

end.
