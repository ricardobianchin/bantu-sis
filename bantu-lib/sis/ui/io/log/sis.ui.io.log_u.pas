unit sis.ui.io.log_u;

interface

uses sis.ui.io.log, sis.ui.io.log.LogRecord, Vcl.Dialogs;

type
  TLog = class(TInterfacedObject, ILog)
  private
    FLogRecord: ILogRecord;
    FAtivo: boolean;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  protected
    property LogRecord: ILogRecord read FLogRecord;
  public
    property Ativo: boolean read GetAtivo write SetAtivo;
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
  SetAtivo(True);
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

function TLog.GetAtivo: boolean;
begin
  result := FAtivo;
end;

procedure TLog.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
