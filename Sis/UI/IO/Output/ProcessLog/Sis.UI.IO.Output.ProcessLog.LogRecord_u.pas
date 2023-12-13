unit Sis.UI.IO.Output.ProcessLog.LogRecord_u;

interface

uses Sis.UI.IO.Output.ProcessLog.LogRecord, Sis.Types.strings.Stack,
  Sis.UI.IO.Output.ProcessLog;

type
  TProcessLogRecord = class(TInterfacedObject, IProcessLogRecord)
  private
    FDtH: TDateTime;
    FTipo: TProcessLogTipo;
    FNome: string;
    FLocal: TProcessLogLocal;
    FAssunto: string;
    FTexto: string;

    FAssuntoStack: IStrStack;
    FLocalStack: IStrStack;

    FQtdRecords: integer;

    function GetVersao: integer;

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

    function GetAsTab: string;
    function GetTitAsTab: string;
    function GetTitAsTab1: string;
    function GetAsTab1: string;

    function GetQtdRecords: integer;

  public
    property Versao: integer read GetVersao;
    property DtH: TDateTime read GetDtH write SetDtH;
    property Tipo: TProcessLogTipo read GetTipo write SetTipo;

    property Local: TProcessLogLocal read GetLocal write SetLocal;
    property Assunto: TProcessLogAssunto read GetAssunto write SetAssunto;
    property Nome: TProcessLogNome read GetNome write SetNome;
    property Texto: TProcessLogTexto read GetTexto write SetTexto;

    property AsTab: string read GetAsTab;
    property TitAsTab: string read GetTitAsTab;

    procedure PegueAssunto(pAssunto: TProcessLogAssunto);
    procedure RetorneAssunto;

    procedure PegueLocal(pLocal: TProcessLogLocal);
    procedure RetorneLocal;

    property QtdRecords: integer read GetQtdRecords;
    procedure IncGetQtdRecords;
    procedure ResetQtdRecords;

    constructor Create;
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.Utils_u, Sis.Types.strings_u,
  Sis.Types.Factory;

{ TProcessLogRecord }

constructor TProcessLogRecord.Create;
begin
  FDtH := 0;
  FTexto := '';
  FAssunto := 'Princ';
  FAssuntoStack := StrStackCreate;
  FLocalStack := StrStackCreate;
  ResetQtdRecords;
end;

function TProcessLogRecord.GetAssunto: TProcessLogAssunto;
begin
  Result := FAssunto;
end;

function TProcessLogRecord.GetAsTab: string;
var
  sResult: string;
begin
  sResult := '';

  case GetVersao of
    1:
      sResult := GetAsTab1;
  end;

  Result := sResult;
end;

function TProcessLogRecord.GetAsTab1: string;
var
  sRecord: string;
  sHash: string;
  sHashFracao: string;
begin
  sRecord :=
    '1' + CHAR_TAB +
    FQtdRecords.ToHexString + CHAR_TAB +
    FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', FDtH) + CHAR_TAB +
    ProcessLogTipoToStr(FTipo) + CHAR_TAB +
    FAssunto + CHAR_TAB +
    FLocal + CHAR_TAB +
    FLocalStack.Caminho + FLocal + CHAR_TAB +
    FNome + CHAR_TAB +
    FTexto
    ;

  sHash := StrCheckSum(sRecord);

  sHashFracao := RightStr(sHash, 8);

  Result := sRecord + CHAR_TAB + sHashFracao;
end;

function TProcessLogRecord.GetDtH: TDateTime;
begin
  Result := FDtH;
end;

function TProcessLogRecord.GetLocal: TProcessLogLocal;
begin
  Result := FLocal;
end;

function TProcessLogRecord.GetNome: TProcessLogNome;
begin
  Result := FNome;
end;

function TProcessLogRecord.GetQtdRecords: integer;
begin
  Result := FQtdRecords;
end;

function TProcessLogRecord.GetTexto: TProcessLogTexto;
begin
  Result := FTexto;
end;

function TProcessLogRecord.GetTipo: TProcessLogTipo;
begin
  Result := FTipo;
end;

function TProcessLogRecord.GetTitAsTab: string;
var
  sResult: string;
begin
  sResult := '';

  case GetVersao of
    1:
      sResult := GetTitAsTab1;
  end;

  Result := sResult;
end;

function TProcessLogRecord.GetTitAsTab1: string;
var
  sResult: string;
begin
  sResult :=
    'Versao' + CHAR_TAB +
    'Id' + CHAR_TAB +
    'DtH' + CHAR_TAB +
    'Tipo' + CHAR_TAB +
    'Assunto' + CHAR_TAB +
    'Local' + CHAR_TAB +
    'Caminho' + CHAR_TAB +
    'Nome' + CHAR_TAB +
    'Texto' + CHAR_TAB +
    'Hash'
    ;

  Result := sResult;
end;

function TProcessLogRecord.GetVersao: integer;
begin
  Result := 1;
end;

procedure TProcessLogRecord.IncGetQtdRecords;
begin
  Inc(FQtdRecords);
end;

procedure TProcessLogRecord.PegueAssunto(pAssunto: TProcessLogAssunto);
begin
  FAssuntoStack.Push(Assunto);
  Assunto := pAssunto;
end;

procedure TProcessLogRecord.PegueLocal(pLocal: TProcessLogLocal);
begin
  FLocalStack.Push(Local);
  Local := pLocal;
end;

function TProcessLogRecord.ProcessLogTipoToStr(pTipo: TProcessLogTipo): string;
begin
  Result := ProcessLogTipoStr[pTipo];
end;

procedure TProcessLogRecord.ResetQtdRecords;
begin
  FQtdRecords := 0;
end;

procedure TProcessLogRecord.RetorneAssunto;
begin
  Assunto := FAssuntoStack.Pop;
end;

procedure TProcessLogRecord.RetorneLocal;
begin
  Local := FLocalStack.Pop;
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
  FLocal := Value;
end;

procedure TProcessLogRecord.SetNome(Value: TProcessLogNome);
begin
  FNome := Value;
end;

procedure TProcessLogRecord.SetTexto(Value: TProcessLogTexto);
begin
  // substitute  Value := StringReplace(Value, ';', '_', [rfReplaceAll, rfIgnoreCase]);
  FTexto := Value;
end;

procedure TProcessLogRecord.SetTipo(Value: TProcessLogTipo);
begin
  FTipo := Value;
end;

end.
