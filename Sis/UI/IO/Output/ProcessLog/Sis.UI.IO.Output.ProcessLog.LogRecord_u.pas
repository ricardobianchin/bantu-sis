unit Sis.UI.IO.Output.ProcessLog.LogRecord_u;

interface

uses Sis.UI.IO.Output.ProcessLog.LogRecord, Sis.UI.IO.Output.ProcessLog.Types;

type
  TProcessLogRecord = class(TInterfacedObject, IProcessLogRecord)
  private
    FDtH: TDateTime;
    FTipo: TProcessLogTipo;
    FNome: string;
    FLocal: TProcessLogLocal;
    FAssunto: string;
    FTexto: string;

    function GetDtH: TDateTime;
    procedure SetDtH(Value: TDateTime);

    function GetTipo: TProcessLogTipo;
    procedure SetTipo(Value: TProcessLogTipo);

    function GetLocal: TProcessLogLocal;
    procedure SetLocal(Value: TProcessLogLocal);

    function GetAssunto: TProcessLogAssunto;
    procedure SetAssunto(Value: TProcessLogAssunto);

    function GetNome: TProcessLogNome;
    procedure SetNome(Value: TProcessLogNome);

    function GetTexto: TProcessLogTexto;
    procedure SetTexto(Value: TProcessLogTexto);

    function ProcessLogTipoToStr(pTipo: TProcessLogTipo): string;

  public
    property DtH: TDateTime read GetDth write SetDtH;
    property Tipo: TProcessLogTipo read GetTipo write SetTipo;

    property Local: TProcessLogLocal read GetLocal write SetLocal;
    property Assunto: TProcessLogAssunto read GetAssunto write SetAssunto;
    property Nome: TProcessLogNome read GetNome write SetNome;
    property Texto: TProcessLogTexto read GetTexto write SetTexto;

    function GetAsTab: string;
    property AsTab: string read GetAsTab;

    constructor Create;
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.Utils_u;

{ TProcessLogRecord }

constructor TProcessLogRecord.Create;
begin
  FDtH := 0;
  FTexto := '';
end;

function TProcessLogRecord.GetAssunto: TProcessLogAssunto;
begin
  Result := FAssunto;
end;

function TProcessLogRecord.GetAsTab: string;
begin
  result :=
    FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', FDtH)
    + CHAR_TAB
    + ProcessLogTipoToStr(FTipo)
    + CHAR_TAB
    + FTexto
    ;
end;

function TProcessLogRecord.GetDtH: TDateTime;
begin
  result := FDtH;
end;

function TProcessLogRecord.GetLocal: TProcessLogLocal;
begin
  Result := FLocal;
end;

function TProcessLogRecord.GetNome: TProcessLogNome;
begin
  Result := FNome;
end;

function TProcessLogRecord.GetTexto: TProcessLogTexto;
begin
  result := FTexto;
end;

function TProcessLogRecord.GetTipo: TProcessLogTipo;
begin
  Result := FTipo;
end;

function TProcessLogRecord.ProcessLogTipoToStr(pTipo: TProcessLogTipo): string;
begin
  Result := ProcessLogTipoStr[pTipo];
end;

procedure TProcessLogRecord.SetAssunto(Value: TProcessLogAssunto);
begin
  FAssunto := Value;
end;

procedure TProcessLogRecord.SetDtH(Value: TDateTime);
begin
  FDtH := Value;
end;

procedure TProcessLogRecord.SetLocal(Value: TProcessLogLocal);
begin
  FLocal := FLocal;
end;

procedure TProcessLogRecord.SetNome(Value: TProcessLogNome);
begin
  FNome := Value;
end;

procedure TProcessLogRecord.SetTexto(Value: TProcessLogTexto);
begin
//substitute  Value := StringReplace(Value, ';', '_', [rfReplaceAll, rfIgnoreCase]);
  FTexto := Value;
end;

procedure TProcessLogRecord.SetTipo(Value: TProcessLogTipo);
begin
  FTipo := Value;
end;

end.

