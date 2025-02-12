unit Sis.UI.IO.Serial.Utils_u;

interface

uses System.Classes;

const
  PortaNomes: array [0 .. 8] of string = ( //
    'COM1' //
    , 'COM2' //
    , 'COM3' //
    , 'COM4' //
    , 'LPT1' //
    , 'LPT2' //
    , 'LPT3' //
    , 'LPT4' //
    , 'TCP:192.168.0.31:9100' //
    );

  PortaDataBits: array [0 .. 3] of integer = ( //
    5 //
    , 6 //
    , 7 //
    , 8 //
    );

  PortaBaudRates: array [0 .. 11] of integer = ( //
    110 //
    , 300 //
    , 600 //
    , 1200 //
    , 2400 //
    , 4800 //
    , 9600 //
    , 14400 //
    , 19200 //
    , 38400 //
    , 56000 //
    , 57600 //
    );

procedure PortaSLPreencher(pSL: TStrings);

implementation

procedure PortaSLPreencher(pSL: TStrings);
var
  I: integer;
begin
  pSL.Clear;
  for I := Low(PortaNomes) to High(PortaNomes) do
  begin
    pSL.Add(PortaNomes[I]);
  end;
end;

end.
