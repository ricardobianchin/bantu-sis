unit Sis.UI.IO.ProcessLog_u;

interface

uses sis.ui.io.ProcessLog, sis.ui.io.ProcessLogRecord, Vcl.Dialogs;

type
  TProcessLog = class(TInterfacedObject, IProcessLog)
  private
    FProcessLogRecord: IProcessLogRecord;
    FAtivo: boolean;

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

uses sis.ui.io.ProcessLog.factory, System.SysUtils;

constructor TProcessLog.Create;
begin
  FProcessLogRecord := ProcessLogRecordCreate;
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
