unit Sis.UI.IO.Output.ProcessLog.ProcessLogFile_u;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output.ProcessLog_u;

type
  TProcessLogFile = class(TProcessLog)
  private
    FF: TextFile;
    FDtHIni: TDateTime;
    FDtHFile: TDateTime;
    FPasta: string;
    FNomeArq: string;
    FExt: string;
  private
    procedure InsiraLinha(pLinha: string);
  public

    procedure RegistreLog(pTexto: string;
      pDtH: TDateTime = 0;
      pTipo: TProcessLogTipo = TProcessLogTipo.lptNaoDefinido;
      pNome: TProcessLogNome = ''
      ); override;

    constructor Create(pAssunto: string; pAcrescentaDtH: boolean = True;
      pPasta: string = ''; pDtH: TDateTime = 0; pExt: string = '.processlog.txt');
      reintroduce;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.UI.IO.Files, Sis.Types.strings_u, Sis.Types.Bool_u;

{ TProcessLogFile }

constructor TProcessLogFile.Create(pAssunto: string; pAcrescentaDtH: boolean;
  pPasta: string; pDtH: TDateTime; pExt: string);
var
  sAssunto: string;
  sPasta: string;
  sLog: string;
begin
  inherited Create;
  FDtHIni := Now;

  if pDtH = 0 then
    pDtH := FDtHIni;

  FDtHFile := pDtH;

  sPasta := pPasta;
  if sPasta = '' then
  begin
    sPasta := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
    sPasta := PastaAcima(sPasta)+'Tmp\ProcessLog\'+DateToPath();
  end;

  ForceDirectories(sPasta);
  FPasta := IncludeTrailingPathDelimiter(sPasta);

  sAssunto := Trim(pAssunto);
  if sAssunto = '' then
    sAssunto := '_';

  sAssunto := StrToNomeArq(Trim(pAssunto));

  FNomeArq := sAssunto;

  if pAcrescentaDtH then
    FNomeArq := FNomeArq + ' ' + FormatDateTime('yyyy-mm-dd_hh-nn-ss',
      FDtHFile);

  FExt := pExt;

  AssignFile(FF, FPasta + FNomeArq + FExt);

  sLog := 'TLogFile.Create' + ',' + sAssunto + ',' +
    iif(pAcrescentaDtH, 'acrescDth', 'nao acrescDth') + ',' + sPasta + ',' +
    DateTimeToStr(pDtH) + ',' + pExt;

  if not FileExists(FPasta + FNomeArq + FExt) then
  begin
    Rewrite(FF);
    WriteLn(FF, ProcessLogRecord.GetTitAsTab);
    CloseFile(FF);
  end;

  RegistreLog(sLog, pDtH);

  RetorneLocal;
end;

destructor TProcessLogFile.Destroy;
begin
  PegueLocal('TProcessLogFile.Destroy');
  RegistreLog('Destroy');
  inherited;
end;

procedure TProcessLogFile.InsiraLinha(pLinha: string);
begin
  Append(FF);
  Writeln(FF, pLinha);
  CloseFile(FF);
end;

procedure TProcessLogFile.RegistreLog(pTexto: string; pDtH: TDateTime;
  pTipo: TProcessLogTipo; pNome: TProcessLogNome);
begin
  if not Ativo then
    exit;

  if Trim(pTexto) = '' then
    exit;

  inherited RegistreLog(pTexto, pDtH, pTipo, pNome);

  InsiraLinha(ProcessLogRecord.AsTab);
end;

end.
