unit sis.ui.io.log.LogRecord;

interface

type
  ILogRecord = interface(IInterface)
    ['{2BDB314C-B9F3-4835-B707-6C10E6D6FC29}']
    function GetDtH: TDateTime;
    procedure SetDtH(Value: TDateTime);
    property DtH: TDateTime read GetDth write SetDtH;

    function GetTexto: string;
    procedure SetTexto(Value: string);
    property Texto: string read GetTexto write SetTexto;

    function GetAsTab: string;
    property AsTab: string read GetAsTab;
  end;

implementation

end.
