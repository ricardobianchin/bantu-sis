unit sis.ui.io.log_u;

interface

uses sis.ui.io.log, sis.ui.io.log.LogRecord, Vcl.Dialogs;

type
  TLog = class(TInterfacedObject, ILog)
  private
    FLogRecord: ILogRecord;
    FEnabled: boolean;

    function GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
  protected
    property LogRecord: ILogRecord read FLogRecord;
  public
    property Enabled: boolean read GetEnabled write SetEnabled;
    procedure Exibir(pFrase: string); virtual;
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType); virtual;
    constructor Create; virtual;
  end;

implementation

{ TLog }

uses sis.ui.io.log.factory, System.SysUtils;

constructor TLog.Create;
begin
  FLogRecord := LogRecordCreate;
  SetEnabled(true);
end;

procedure TLog.Exibir(pFrase: string);
begin
  LogRecord.DtH := Now;
  LogRecord.Texto := pFrase;
end;

procedure TLog.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

function TLog.GetEnabled: boolean;
begin
  result := FEnabled;
end;

procedure TLog.SetEnabled(Value: boolean);
begin
  FEnabled := Value;
end;

end.
