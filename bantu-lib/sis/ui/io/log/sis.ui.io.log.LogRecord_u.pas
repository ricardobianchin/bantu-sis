unit sis.ui.io.log.LogRecord_u;

interface

uses sis.ui.io.log.LogRecord, sis.sis.constants, sis.types.constants;

type
  TLogRecord = class(TInterfacedObject, ILogRecord)
  private
    FDtH: TDateTime;
    FTexto: string;

    function GetDtH: TDateTime;
    procedure SetDtH(Value: TDateTime);

    function GetTexto: string;
    procedure SetTexto(Value: string);

  public
    property DtH: TDateTime read GetDth write SetDtH;
    property Texto: string read GetTexto write SetTexto;

    function GetAsTab: string;
    property AsTab: string read GetAsTab;

    constructor Create;
  end;

implementation

uses System.SysUtils, System.StrUtils;

{ TLogRecord }

constructor TLogRecord.Create;
begin
  FDtH := 0;
  FTexto := '';
end;

function TLogRecord.GetAsTab: string;
begin
  result :=
    FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', FDtH)
    +cTAB
    +FTexto
    ;
end;

function TLogRecord.GetDtH: TDateTime;
begin
  result := FDtH;
end;

function TLogRecord.GetTexto: string;
begin
  result := FTexto;
end;

procedure TLogRecord.SetDtH(Value: TDateTime);
begin
  FDtH := Value;
end;

procedure TLogRecord.SetTexto(Value: string);
begin
//substitute  Value := StringReplace(Value, ';', '_', [rfReplaceAll, rfIgnoreCase]);
  FTexto := Value;
end;

end.
