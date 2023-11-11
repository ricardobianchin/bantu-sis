unit Sis.UI.IO.LogProcessFile_u;

interface

uses Sis.UI.IO.LogProcess_u;

type
  TLogProcessFile = class(TLogProcess)
  private
    FF: TextFile;
    FDtHIni: TDateTime;
    FDtHFile: TDateTime;
    FPasta: string;
    FNomeArq: string;
    FExt: string;
  public
    procedure Exibir(pFrase: string); override;
    constructor Create(pAssunto: string; pAcrescentaDtH: boolean = True;
      pPasta: string = ''; pDtH: TDateTime = 0; pExt: string = '.txt');
      reintroduce;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, sis.types.strings, sis.types.bool.utils,
  sis.win.pastas, sis.files;

{ TLogProcessFile }

constructor TLogProcessFile.Create(pAssunto: string; pAcrescentaDtH: boolean = True;
  pPasta: string = ''; pDtH: TDateTime = 0; pExt: string = '.txt');
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
    sPasta := PastaAcima(sPasta)+'tmp\LogProcess\'+DateToPath();
  end;

  ForceDirectories(sPasta);
  FPasta := IncludeTrailingPathDelimiter(sPasta);

  sAssunto := Trim(pAssunto);
  if sAssunto = '' then
    sAssunto := '_';

  sAssunto := StrToNomeArq(Trim(pAssunto));

  FNomeArq := 'LogProcess ' + sAssunto;

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
    CloseFile(FF);
  end;
  Exibir(sLog);
end;

destructor TLogProcessFile.Destroy;
begin
  Exibir('TLogProcessFile.Destroy');
  inherited;
end;

procedure TLogProcessFile.Exibir(pFrase: string);
begin
  if not Ativo then
    exit;

  inherited Exibir(pFrase);
//  if FileExists(FPasta + FNomeArq + FExt) then
    Append(FF)
  //else
//    Rewrite(FF)
    ;

  Writeln(FF, LogProcessRecord.AsTab);

  CloseFile(FF);
end;

end.
