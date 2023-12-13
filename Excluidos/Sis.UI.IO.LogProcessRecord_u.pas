unit Sis.UI.IO.ProcessLogRecord_u;

interface

uses sis.ui.io.ProcessLogRecord, sis.sis.constants, sis.types.constants, Sis.UI.IO.ProcessLog.Constants;

type
  TProcessLogRecord = class(TInterfacedObject, IProcessLogRecord)
  private
    FDtH: TDateTime;
    FTexto: string;
    FTipo: TProcessLogTipo;

    function GetDtH: TDateTime;
    procedure SetDtH(Value: TDateTime);

    function GetTipo: TProcessLogTipo;
    procedure SetTipo(Value: TProcessLogTipo);

    function GetTexto: string;
    procedure SetTexto(Value: string);

  public
    property DtH: TDateTime read GetDth write SetDtH;
    property Tipo: TProcessLogTipo read GetTipo write SetTipo;
    property Texto: string read GetTexto write SetTexto;

    function GetAsTab: string;
    property AsTab: string read GetAsTab;

    constructor Create;
  end;

implementation

uses System.SysUtils, System.StrUtils;

{ TProcessLogRecord }

constructor TProcessLogRecord.Create;
begin
  FDtH := 0;
  FTexto := '';
end;

function TProcessLogRecord.GetAsTab: string;
begin
  result :=
    FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', FDtH)
    +cTAB
    +FTexto
    ;
end;

function TProcessLogRecord.GetDtH: TDateTime;
begin
  result := FDtH;
end;

function TProcessLogRecord.GetTexto: string;
begin
  result := FTexto;
end;

function TProcessLogRecord.GetTipo: TProcessLogTipo;
begin
  Result := FTipo;
end;

procedure TProcessLogRecord.SetDtH(Value: TDateTime);
begin
  FDtH := Value;
end;

procedure TProcessLogRecord.SetTexto(Value: string);
begin
//substitute  Value := StringReplace(Value, ';', '_', [rfReplaceAll, rfIgnoreCase]);
  FTexto := Value;
end;

procedure TProcessLogRecord.SetTipo(Value: TProcessLogTipo);
begin
  FTipo := Value;
end;

end.
