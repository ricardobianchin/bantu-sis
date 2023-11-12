unit Sta.Inst.Files.Garantir_u;

interface

uses Sta.Inst.Files.Garantir, sis.ui.io.output, sis.ui.io.LogProcess;

type
  TInstGarantir = class(TInterfacedObject, IInstGarantir)
  private
    FLogProcess: ILogProcess;
    FOutput: IOutput;
    procedure GarantirMSI;
    procedure GarantirArqsInstalacao;
  public
    function Execute: Boolean;
    constructor Create(pLogProcess: ILogProcess; pOutput: IOutput);
  end;

implementation

{ TInstGarantir }

constructor TInstGarantir.Create(pLogProcess: ILogProcess; pOutput: IOutput);
begin
  FLogProcess := pLogProcess;
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
    FLogProcess.Exibir(sLog);
  end;
end;

procedure TInstGarantir.GarantirMSI;
begin

end;

end.
