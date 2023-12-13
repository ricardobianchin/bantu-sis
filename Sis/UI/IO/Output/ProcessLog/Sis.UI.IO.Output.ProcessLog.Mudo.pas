unit Sis.UI.IO.Output.ProcessLog.Mudo;

interface

uses Sis.UI.IO.Output.ProcessLog;

type
  TMudoProcessLog = class(TInterfacedObject, IProcessLog)
  public
    procedure PegueAssunto(pAssunto: TProcessLogAssunto);
    procedure RetorneAssunto;

    procedure PegueLocal(pLocal: TProcessLogLocal);
    procedure RetorneLocal;

    procedure RegistreLog(pTexto: string; pDtH: TDateTime = 0;
      pTipo: TProcessLogTipo = TProcessLogTipo.lptNaoDefinido;
      pNome: TProcessLogNome = '');
  end;

implementation

{ TMudoProcessLog }

procedure TMudoProcessLog.PegueAssunto(pAssunto: TProcessLogAssunto);
begin

end;

procedure TMudoProcessLog.PegueLocal(pLocal: TProcessLogLocal);
begin

end;

procedure TMudoProcessLog.RegistreLog(pTexto: string; pDtH: TDateTime;
  pTipo: TProcessLogTipo; pNome: TProcessLogNome);
begin

end;

procedure TMudoProcessLog.RetorneAssunto;
begin

end;

procedure TMudoProcessLog.RetorneLocal;
begin

end;

end.
