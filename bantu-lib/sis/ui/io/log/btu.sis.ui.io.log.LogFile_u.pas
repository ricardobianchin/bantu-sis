unit btu.sis.ui.io.log.LogFile_u;

interface

uses btu.sis.ui.io.log_u;

type
  TLogFile = class(TLog)
  private
    FF: TextFile;
    FDtHIni: TDateTime;
    FDtHFile: TDateTime;
    FPasta: string;
    FNomeArq: string;
    FExt: string;
  public
    procedure Exibir(pFrase: string); override;
    constructor Create(pAssunto: string; pAcrescentaDtH: boolean=True; pPasta: string=''; pDtH: TDateTime=0; pExt: string='.txt');
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, btn.lib.types.strings, btu.lib.types.bool.utils;

{ TLogFile }

constructor TLogFile.Create(pAssunto: string; pAcrescentaDtH: boolean=True; pPasta: string=''; pDtH: TDateTime=0; pExt: string='.txt');
var
  sAssunto: string;
  sPasta: string;
  sLog: string;
begin
  inherited Create;
  FDtHIni := Now;

  if pDtH=0 then
    pDtH := FDtHIni;

  FDtHFile := pDtH;

  sPasta := pPasta;
  if sPasta='' then
    sPasta := IncludeTrailingPathDelimiter( ExtractFilePath( ParamStr(0)));

  ForceDirectories(sPasta);
  FPasta := IncludeTrailingPathDelimiter(sPasta);

  sAssunto := Trim(pAssunto);
  if sAssunto = '' then
    sAssunto := '_';

  sAssunto := StrToNomeArq(Trim(pAssunto));

  FNomeArq := 'Log '+ sAssunto;

  if pAcrescentaDtH then
    FNomeArq := FNomeArq + ' ' + FormatDateTime('yyyy-mm-dd_hh-nn-ss', FDtHFile);

  FExt := pExt;

  AssignFile(FF, FPasta+FNomeArq+FExt);

  sLog := 'TLogFile.Create'
    +','+sAssunto
    +','+iif(pAcrescentaDtH, 'acrescDth', 'nao acrescDth')
    +','+sPasta
    +','+DateTimeToStr(pDtH)
    +','+pExt
    ;
  Exibir(sLog);
end;

destructor TLogFile.Destroy;
begin
  Exibir('TLogFile.Destroy');
  inherited;
end;

procedure TLogFile.Exibir(pFrase: string);
begin
  if not Enabled then
    exit;

  inherited Exibir(pFrase);
  if FileExists(FPasta+FNomeArq+FExt) then
    Append(FF)
  else
    Rewrite(FF);

  Writeln(FF, LogRecord.AsTab);

  CloseFile(FF);
end;

end.
