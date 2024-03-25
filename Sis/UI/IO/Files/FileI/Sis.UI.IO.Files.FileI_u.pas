unit Sis.UI.IO.Files.FileI_u;

interface

uses Sis.UI.IO.Files.FileI, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TFileI = class(TInterfacedObject, IFileI)
  private
    FNomeArq: string;
    FExt: string;
    FPasta: string;
    FNomeCompletoArq: string;
    FAutoCreate: boolean;

    FProcessLog: IProcessLog;
    FOutput: IOutput;

  protected
    property ProcessLog: IProcessLog read FProcessLog;
    property Output: IOutput read FOutput;
    property NomeCompletoArq: string read FNomeCompletoArq;
    procedure Inicialize; virtual;
  public

    function Ler: boolean; virtual;
    function Gravar: boolean; virtual; abstract;
    constructor Create(pNomeArq: string; pExt: string = '';
      pPasta: string = ''; pAutoCreate: boolean = false;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

uses System.SysUtils, Sis.UI.IO.Factory, Sis.UI.IO.Output.ProcessLog.Factory;

{ TFileI }

constructor TFileI.Create(pNomeArq, pExt, pPasta: string; pAutoCreate: boolean;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FNomeArq := pNomeArq;
  FExt := pExt;
  FPasta := pPasta;

  if FPasta = '' then
    FPasta := IncludeTrailingPathDelimiter( ExtractFilePath( ParamStr(0)));

  FNomeCompletoArq := FPasta + FNomeArq + FExt;

  FProcessLog := pProcessLog;
  if pProcessLog = nil then
    FProcessLog := MudoProcessLogCreate;

  FOutput := pOutput;
  if pOutput = nil then
    FOutput := MudoOutputCreate;

  FAutoCreate := pAutoCreate;
  if FAutoCreate then
    ForceDirectories(pPasta);
end;

procedure TFileI.Inicialize;
begin

end;

function TFileI.Ler: boolean;
begin
  Result := FileExists(FNomeCompletoArq);
end;

end.
