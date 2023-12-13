unit Sis.UI.IO.Output.ProcessLog.Registrador_u;

interface

uses Sis.UI.IO.Output.ProcessLog.Registrador, Sis.UI.IO.Output.ProcessLog;

type
  TProcessLogRegistrador = class(TInterfacedObject, IProcessLogRegistrador)
  private
    FProcessLogTipo: TProcessLogTipo;
    FNome: TProcessLogNome;
    FProcessLog: IProcessLog;
  public
    procedure Registre(pFrase: string);
    constructor Create(pProcessLog: IProcessLog;
      pProcessLogTipo: TProcessLogTipo; pNome: TProcessLogNome);
  end;

implementation

{ TProcessLogRegistrador }

constructor TProcessLogRegistrador.Create(pProcessLog: IProcessLog;
  pProcessLogTipo: TProcessLogTipo; pNome: TProcessLogNome);
begin
  FProcessLog := pProcessLog;
  FProcessLogTipo := pProcessLogTipo;
  FNome := pNome;
end;

procedure TProcessLogRegistrador.Registre(pFrase: string);
begin
  FProcessLog.RegistreLog(pFrase, 0, TProcessLogTipo.lptDB, FNome);
end;

end.
