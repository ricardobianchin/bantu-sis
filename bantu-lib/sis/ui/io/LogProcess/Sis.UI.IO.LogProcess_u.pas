unit Sis.UI.IO.LogProcess_u;

interface

uses sis.ui.io.LogProcess, sis.ui.io.LogProcessRecord, Vcl.Dialogs;

type
  TLogProcess = class(TInterfacedObject, ILogProcess)
  private
    FLogProcessRecord: ILogProcessRecord;
    FAtivo: boolean;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  protected
    property LogProcessRecord: ILogProcessRecord read FLogProcessRecord;
  public
    property Ativo: boolean read GetAtivo write SetAtivo;
    procedure Exibir(pFrase: string); virtual;
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType); virtual;
    constructor Create; virtual;
  end;

implementation

{ TLogProcess }

uses sis.ui.io.LogProcess.factory, System.SysUtils;

constructor TLogProcess.Create;
begin
  FLogProcessRecord := LogProcessRecordCreate;
  SetAtivo(True);
end;

procedure TLogProcess.Exibir(pFrase: string);
begin
  LogProcessRecord.DtH := Now;
  LogProcessRecord.Texto := pFrase;
end;

procedure TLogProcess.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

function TLogProcess.GetAtivo: boolean;
begin
  result := FAtivo;
end;

procedure TLogProcess.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
