unit Sis.UI.IO.Output.ProcessLog_u;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output.ProcessLog.LogRecord,
  Vcl.Dialogs, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog.Types;

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

    constructor Create; virtual;

    procedure PegueAssunto(pAssunto: TProcessLogAssunto);
    procedure RetorneAssunto;

    procedure PegueLocal(pLocal: TProcessLogLocal);
    procedure RetorneLocal;

    procedure RegistreLog(pTexto: string;
      pDtH: TDateTime = 0;
      pTipo: TProcessLogTipo = TProcessLogTipo.lptNaoDefinido;
      pNome: TProcessLogNome = ''
      ); virtual;
  end;

implementation

{ TProcessLog }

uses System.SysUtils, Sis.UI.IO.Output.ProcessLog.Factory;

constructor TProcessLog.Create;
begin
  FProcessLogRecord := ProcessLogRecordCreate;

  ProcessLogRecord.Tipo := TProcessLogTipo.lptProcess;

  PegueLocal('TProcessLog.Create');

  SetAtivo(True);
end;

function TProcessLog.GetAtivo: boolean;
begin
  result := FAtivo;
end;

procedure TProcessLog.PegueAssunto(pAssunto: TProcessLogAssunto);
begin
  FProcessLogRecord.PegueAssunto(pAssunto);
end;

procedure TProcessLog.PegueLocal(pLocal: TProcessLogLocal);
begin
  FProcessLogRecord.PegueLocal(pLocal);
end;

procedure TProcessLog.RegistreLog(pTexto: string; pDtH: TDateTime;
  pTipo: TProcessLogTipo; pNome: TProcessLogNome);
begin
  ProcessLogRecord.Texto := pTexto;

  if pDtH = 0 then
    ProcessLogRecord.DtH := Now
  else
    ProcessLogRecord.DtH := pDtH;

  ProcessLogRecord.Nome := pNome;

  if pTipo = TProcessLogTipo.lptNaoDefinido then
    ProcessLogRecord.Tipo := TProcessLogTipo.lptProcess
  else
    ProcessLogRecord.Tipo := pTipo;
end;

procedure TProcessLog.RetorneAssunto;
begin
  FProcessLogRecord.RetorneAssunto;
end;

procedure TProcessLog.RetorneLocal;
begin
  FProcessLogRecord.RetorneLocal;
end;

procedure TProcessLog.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
