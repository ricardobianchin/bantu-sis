unit App.Ent.Ed.Id.Descr;

interface

uses App.Ent.Ed.Id;

type
  IEntIdDescr = interface(IEntEdId)
    ['{591AE5D3-EB61-45B6-88EE-DB9485262210}']
    function GetDescr: string;
    procedure SetDescr(Value: string);
    property Descr: string read GetDescr write SetDescr;

    function GetDescrCaption: string;
    property DescrCaption: string read GetDescrCaption;

    function GetStrDescreve: string;
    property StrDescreve: string read GetStrDescreve;
  end;

implementation

end.
