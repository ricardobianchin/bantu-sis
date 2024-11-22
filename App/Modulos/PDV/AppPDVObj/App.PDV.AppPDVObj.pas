unit App.PDV.AppPDVObj;

interface

uses App.PDV.CaixaSessao;

type
  IAppPDVObj = interface(IInterface)
    ['{0CF2C3F1-A284-4C82-855C-0270CC6B34F1}']
    function GetFiscal: Boolean;
    property Fiscal: Boolean read GetFiscal;
  end;

implementation

end.
