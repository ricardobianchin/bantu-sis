unit Sis.UI.IO.Output.ProcessLog_u;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output.ProcessLog.LogRecord,
  Vcl.Dialogs, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog.Types,
  Sis.UI.IO.Output.ProcessLog.Properties.Stack;

type
  TProcessLog = class(TInterfacedObject, IProcessLog)
  private
    FProcessLogRecord: IProcessLogRecord;
    FAtivo: boolean;
    FProcessLogPropertiesStack: IProcessLogPropertiesStack;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  protected
    property ProcessLogRecord: IProcessLogRecord read FProcessLogRecord;
  public
    property Ativo: boolean read GetAtivo write SetAtivo;
    procedure Exibir(pFrase: string); virtual;
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType); virtual;

    procedure PushProperties(pTipo: TProcessLogTipo;
      pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
    procedure PopProperties;

    constructor Create; virtual;
  end;

implementation

{ TProcessLog }

uses System.SysUtils, Sis.UI.IO.Output.ProcessLog.Factory;

constructor TProcessLog.Create;
begin
  FProcessLogRecord := ProcessLogRecordCreate;
  FProcessLogPropertiesStack := ProcessLogPropertiesStackCreate;
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

procedure TProcessLog.PopProperties;
var
  LTipo: TProcessLogTipo;
  LAssunto: TProcessLogAssunto;
  LNome: TProcessLogNome;
begin
  FProcessLogPropertiesStack.PopProperties(LTipo, LAssunto, LNome);
  FProcessLogRecord.Tipo := LTipo;
  FProcessLogRecord.Assunto := LAssunto;
  FProcessLogRecord.Nome := LNome;
end;

procedure TProcessLog.PushProperties(pTipo: TProcessLogTipo;
  pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
begin
  FProcessLogPropertiesStack.PushProperties(FProcessLogRecord.Tipo,
    FProcessLogRecord.Assunto, FProcessLogRecord.Nome);

  FProcessLogRecord.Tipo := pTipo;
  FProcessLogRecord.Assunto := pAssunto;
  FProcessLogRecord.Nome := pNome;
end;

procedure TProcessLog.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
