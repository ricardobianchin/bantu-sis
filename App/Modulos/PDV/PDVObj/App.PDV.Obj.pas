unit App.PDV.Obj;

interface

uses App.PDV.UI.Gaveta;

type
  IPDVObj = interface(IInterface)
    ['{0CF2C3F1-A284-4C82-855C-0270CC6B34F1}']
    function GetFiscal: Boolean;
    property Fiscal: Boolean read GetFiscal;

    function GetGaveta: IGaveta;
    property Gaveta: IGaveta read GetGaveta;
  end;

implementation

end.
