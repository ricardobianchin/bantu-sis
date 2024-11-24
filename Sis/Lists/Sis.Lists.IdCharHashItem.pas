unit Sis.Lists.IdCharHashItem;

interface

uses Sis.Lists.IdCharItem;

type
  IIdCharHashItem = interface(IIdCharItem)
    ['{5B88D905-4A6B-4722-97ED-324B005EE69E}']
    function GetDescr: string;
    procedure SetDescr(const Value: string);
    property Descr: string read GetDescr write SetDescr;
  end;

implementation

end.
