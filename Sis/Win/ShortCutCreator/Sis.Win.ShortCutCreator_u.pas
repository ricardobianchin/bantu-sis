unit Sis.Win.ShortCutCreator_u;

interface

uses Sis.Win.ShortCutCreator, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Sis.Executavel_u, System.Classes;

type
  TShortCutCreator = class(TExecutavel, IShortCutCreator)
  private
    FMens: string;
    FScriptSL: TStrings;
    FAssunto, FPastaComandos, FPastaDesktop: string;
  protected
    property ScriptSL: TStrings read FScriptSL;
    property Assunto: string read FAssunto;
    property PastaComandos: string read FPastaComandos;
    property PastaDesktop: string read FPastaDesktop;
    function GetMens: string; virtual;
    procedure SetMens(Value: string);
  public
    procedure AddScriptFor(pNomeAtalho, pExe, pParams, pStartIn: string);
      virtual; abstract;
    function Execute: Boolean; virtual; abstract;
    property Mens: string read GetMens write SetMens;

    procedure Inicialize(pAssunto, pPastaComandos, pPastaDesktop: string);
    constructor Create(pOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.UI.IO.Files;

{ TShortCutCreator }

constructor TShortCutCreator.Create(pOutput: IOutput; pProcessLog: IProcessLog);
begin
  inherited Create(pOutput, pProcessLog);
  FScriptSL := TStringList.Create;
end;

destructor TShortCutCreator.Destroy;
begin
  FScriptSL.Free;
  inherited;
end;

function TShortCutCreator.GetMens: string;
begin
  Result := FMens;
end;

procedure TShortCutCreator.Inicialize(pAssunto, pPastaComandos,
  pPastaDesktop: string);
begin
  FAssunto := pAssunto;
  FPastaComandos := GarantaPasta(pPastaComandos);
  FPastaDesktop := IncludeTrailingPathDelimiter(pPastaDesktop);
end;

procedure TShortCutCreator.SetMens(Value: string);
begin
  FMens := Value;
end;

end.
