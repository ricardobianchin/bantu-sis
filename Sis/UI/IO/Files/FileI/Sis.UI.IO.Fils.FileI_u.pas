unit Sis.UI.IO.Fils.FileI_u;

interface

uses Sis.UI.IO.Fils.FileI, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TFileI = class(TInterfacedObject, IFileI)
  private
    FNome: string;
    FExt: string;
    FPasta: string;
    FNomeCompleto: string;
    FAutoCreate: boolean;

    FProcessLog: IProcessLog;
    FOutput: IOutput;

  protected
    property ProcessLog: IProcessLog read FProcessLog;
    property Output: IOutput read FOutput;
    property NomeCompleto: string read FNomeCompleto;
  public

    function Ler: boolean; virtual;
    Procedure Gravar; virtual; abstract;
    constructor Create(pNome: string; pExt: string = '';
      pPasta: string = ''; pAutoCreate: boolean = false;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

uses System.SysUtils;

{ TFileI }

constructor TFileI.Create(pNome, pExt, pPasta: string; pAutoCreate: boolean;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FNome := pNome;
  FExt := pExt;
  FPasta := pPasta;
  FNomeCompleto := IncludeTrailingPathDelimiter(pPasta) + pNome + pExt;
  FProcessLog := pProcessLog;
  FOutput := pOutput;

  FAutoCreate := pAutoCreate;
  if FAutoCreate then
    ForceDirectories(pPasta);
end;

function TFileI.Ler: boolean;
begin
  Result := FileExists(FNomeCompleto);
end;

end.
