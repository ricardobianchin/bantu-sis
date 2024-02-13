unit App.Entidade.Ed.Id.Descr;

interface

uses App.Entidade.Ed.Id;

type
  IEntIdDescr = interface(IEntId)
    ['{591AE5D3-EB61-45B6-88EE-DB9485262210}']
    function GetDescr: string;
    procedure SetDescr(Value: string);
    property Descr: string read GetDescr write SetDescr;
  end;

implementation

end.
