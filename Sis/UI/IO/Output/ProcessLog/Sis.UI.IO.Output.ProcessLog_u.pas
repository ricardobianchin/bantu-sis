unit Sis.UI.IO.Output.ProcessLog_u;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output.ProcessLog.LogRecord,
  Vcl.Dialogs, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog.Types,
  Sis.Types.strings.Stack;

type
  TProcessLog = class(TInterfacedObject, IProcessLog)
  private
    FProcessLogRecord: IProcessLogRecord;
    FAtivo: boolean;
    FAssuntoStack: IStrStack;
    FLocalStack: IStrStack;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  protected
    property ProcessLogRecord: IProcessLogRecord read FProcessLogRecord;
  public
    property Ativo: boolean read GetAtivo write SetAtivo;
    procedure Exibir(pFrase: string); virtual;
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType); virtual;

    constructor Create; virtual;
  end;

implementation

{ TProcessLog }

uses System.SysUtils, Sis.UI.IO.Output.ProcessLog.Factory, Sis.Types.Factory;

constructor TProcessLog.Create;
begin
  FProcessLogRecord := ProcessLogRecordCreate;
  FAssuntoStack := StrStackCreate;
  FLocalStack := StrStackCreate;

  SetAtivo(True);
end;

procedure TProcessLog.Exibir(pFrase: string);
begin
  ProcessLogRecord.DtH := Now;
  ProcessLogRecord.Texto := pFrase;
end;

procedure TProcessLog.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

function TProcessLog.GetAtivo: boolean;
begin
  result := FAtivo;
end;

procedure TProcessLog.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
