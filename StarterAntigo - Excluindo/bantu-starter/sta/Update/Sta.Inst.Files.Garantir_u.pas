unit Sta.Inst.Files.Garantir_u;

interface

uses Sta.Inst.Files.Garantir, sis.ui.io.output, sis.ui.io.ProcessLog;

type
  TInstGarantir = class(TInterfacedObject, IInstGarantir)
  private
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    procedure GarantirMSI;
    procedure GarantirArqsInstalacao;
  public
    function Execute: Boolean;
    constructor Create(pProcessLog: IProcessLog; pOutput: IOutput);
  end;

implementation

{ TInstGarantir }

constructor TInstGarantir.Create(pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FProcessLog := pProcessLog;
  FOutput := pOutput;
end;

function TInstGarantir.Execute: Boolean;
begin
  GarantirMSI;
  GarantirArqsInstalacao;
end;

procedure TInstGarantir.GarantirArqsInstalacao;
var
  sLog: string;
begin
  sLog := 'TInstGarantir.GarantirArqsInstalacao';
  FOutput.Exibir('Garantir arquivos instalados inicio');
  try

  finally
    FOutput.Exibir('Garantir arquivos instalados fim');
    FProcessLog.Exibir(sLog);
  end;
end;

procedure TInstGarantir.GarantirMSI;
begin

end;

end.
