unit btu.lib.lists.HashItem_i;

interface

uses btu.lib.lists.IdItem, Vcl.Controls;

type
  IHashItem=interface(IIdItem)
    ['{6F65B9D7-4ED6-4D94-B886-CBBE7C6B12EB}']
    procedure Zerar;

    function GetDescr:string;
    procedure SetDescr(const Value:string);
    property Descr:string read GetDescr write SetDescr;

    function GetAsStringCSV: string;
    property AsStringCSV: string read GetAsStringCSV;

    function GetAsCaption: TCaption;
    property AsCaption: TCaption read GetAsCaption;
  end;

implementation

end.
