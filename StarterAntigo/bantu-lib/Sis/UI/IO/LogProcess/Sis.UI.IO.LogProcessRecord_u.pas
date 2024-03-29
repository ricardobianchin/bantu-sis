unit Sis.UI.IO.LogProcessRecord_u;

interface

uses sis.ui.io.LogProcessRecord, sis.sis.constants, sis.types.constants, Sis.UI.IO.LogProcess.Constants;

type
  TLogProcessRecord = class(TInterfacedObject, ILogProcessRecord)
  private
    FDtH: TDateTime;
    FTexto: string;
    FTipo: TLogProcessTipo;

    function GetDtH: TDateTime;
    procedure SetDtH(Value: TDateTime);

    function GetTipo: TLogProcessTipo;
    procedure SetTipo(Value: TLogProcessTipo);

    function GetTexto: string;
    procedure SetTexto(Value: string);

  public
    property DtH: TDateTime read GetDth write SetDtH;
    property Tipo: TLogProcessTipo read GetTipo write SetTipo;
    property Texto: string read GetTexto write SetTexto;

    function GetAsTab: string;
    property AsTab: string read GetAsTab;

    constructor Create;
  end;

implementation

uses System.SysUtils, System.StrUtils;

{ TLogProcessRecord }

constructor TLogProcessRecord.Create;
begin
  FDtH := 0;
  FTexto := '';
end;

function TLogProcessRecord.GetAsTab: string;
begin
  result :=
    FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', FDtH)
    +cTAB
    +FTexto
    ;
end;

function TLogProcessRecord.GetDtH: TDateTime;
begin
  result := FDtH;
end;

function TLogProcessRecord.GetTexto: string;
begin
  result := FTexto;
end;

function TLogProcessRecord.GetTipo: TLogProcessTipo;
begin
  Result := FTipo;
end;

procedure TLogProcessRecord.SetDtH(Value: TDateTime);
begin
  FDtH := Value;
end;

procedure TLogProcessRecord.SetTexto(Value: string);
begin
//substitute  Value := StringReplace(Value, ';', '_', [rfReplaceAll, rfIgnoreCase]);
  FTexto := Value;
end;

procedure TLogProcessRecord.SetTipo(Value: TLogProcessTipo);
begin
  FTipo := Value;
end;

end.
