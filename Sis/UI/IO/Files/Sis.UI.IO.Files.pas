unit Sis.UI.IO.Files;

interface

uses System.Classes, Sis.UI.IO.Output.ProcessLog;

// entra na pasta
procedure VaParaPasta(pPasta: string);
function VaParaPastaDoArquivo(const pNomeArq: string;
  pProcessLog: IProcessLog): string;
function PastaCriarEntrar(const pCaminho: string): boolean;
function PastaAcima(pPastaOrigem: string = ''): string;
function PastaAtual: string;

// garantir pasta
procedure GarantirPasta(const pPasta: string);
function GarantirPastaDoArquivo(const pNomeArq: string): string;

// date time
function DateTimeToNomeArq(pDtH: TDateTime = 0): string;
function DateToPath(pDtH: TDateTime = 0): string;

// fragmenta caminho
function GetPastaDoArquivo(const pNomeArq: string): string;

// dir
procedure LeDiretorio(pPasta: string; pNomesArqSL: TStrings;
  pZeraAntes: boolean; pMascara: string = '*.*');

// gravar
procedure EscreverArquivo(pStr: string; pNomeArq: string);

// Ler
function LerDoArquivo(pNomeArq: string; out pConteudo: string): boolean;

// selecionar
function EscolhaArquivo(var pNomeArq: string; pFiltros: string = '';
  pTitulo: string = ''): boolean;

implementation

uses System.SysUtils, System.IOUtils, System.StrUtils, Vcl.Dialogs,
  Sis.Types.strings_u;

function DateTimeToNomeArq(pDtH: TDateTime): string;
var
  ano, mes, dia, hora, minuto, segundo, milisegundo: word;
begin
  // Se o valor datetime n?o for informado, usa o valor atual
  if pDtH = 0 then
    pDtH := Now;

  // Extrai os componentes do valor datetime
  DecodeDate(pDtH, ano, mes, dia);
  DecodeTime(pDtH, hora, minuto, segundo, milisegundo);

  // Formata o resultado no formato YYYY-mm-dd_hh-nn-ss-zzz
  Result := Format('%.4d-%.2d-%.2d_%.2d-%.2d-%.2d-%.3d',
    [ano, mes, dia, hora, minuto, segundo, milisegundo]);
end;

function PastaCriarEntrar(const pCaminho: string): boolean;
begin
  ForceDirectories(pCaminho);

  Result := SetCurrentDir(pCaminho);
end;

procedure EscreverArquivo(pStr: string; pNomeArq: string);
var
  Arquivo: TFileStream;
  Buffer: TBytes;
begin
  Arquivo := TFileStream.Create(pNomeArq, fmCreate or fmShareDenyWrite);
  try
    Buffer := TEncoding.UTF8.GetBytes(pStr);
    Arquivo.Write(Buffer, Length(Buffer));
  finally
    Arquivo.Free;
  end;
end;

function LerDoArquivo(pNomeArq: string; out pConteudo: string): boolean;
var
  Arquivo: TFileStream;
  Buffer: TBytes;
begin
  Result := FileExists(pNomeArq);

  if not Result then
    exit;

  // Cria um objeto TFileStream para ler o arquivo
  Arquivo := TFileStream.Create(pNomeArq, fmOpenRead or fmShareDenyWrite);
  try
    // Define o tamanho do buffer de acordo com o tamanho do arquivo
    SetLength(Buffer, Arquivo.Size);
    // Lê o arquivo para o buffer
    Arquivo.Read(Buffer, Length(Buffer));
    // Converte o buffer em string usando a codificação UTF-8
    pConteudo := TEncoding.UTF8.GetString(Buffer);
    Result := true; // Retorna true se a leitura foi bem sucedida
  finally
    // Libera o objeto TFileStream
    Arquivo.Free;
  end;
end;

function GetPastaDoArquivo(const pNomeArq: string): string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(pNomeArq));
end;

procedure GarantirPasta(const pPasta: string);
begin
  ForceDirectories(pPasta);
end;

function GarantirPastaDoArquivo(const pNomeArq: string): string;
begin
  Result := GetPastaDoArquivo(pNomeArq);
  GarantirPasta(Result);
end;

function PastaAcima(pPastaOrigem: string = ''): string;
var
  rp: integer;
begin
  if pPastaOrigem = '' then
    pPastaOrigem := PastaAtual;

  pPastaOrigem := ExcludeTrailingPathDelimiter(pPastaOrigem);
  rp := RightPos('\', pPastaOrigem);
  Result := ExcludeTrailingPathDelimiter(LeftStr(pPastaOrigem, rp));
  Result := IncludeTrailingPathDelimiter(Result);
end;

function PastaAtual: string;
begin
  GetDir(0, Result);
  Result := IncludeTrailingPathDelimiter(Result);
end;

function DateToPath(pDtH: TDateTime = 0): string;
var
  ano, mes, dia: word;
begin
  // Se o valor datetime n?o for informado, usa o valor atual
  if pDtH = 0 then
    pDtH := Date;

  // Extrai os componentes do valor datetime
  DecodeDate(pDtH, ano, mes, dia);

  // Formata o resultado no formato YYYY-mm-dd_hh-nn-ss-zzz
  // Result := Format('%.4d-%.2d-%.2d_%.2d-%.2d-%.2d-%.3d', [ano, mes, dia, hora, minuto, segundo, milisegundo]);
  Result := Format('%.4d\%.2d\%.2d\', [ano, mes, dia]);
end;

procedure LeDiretorio(pPasta: string; pNomesArqSL: TStrings;
  pZeraAntes: boolean; pMascara: string);
var
  F: TSearchRec;
begin
  if pZeraAntes then
    pNomesArqSL.Clear;

  if FindFirst(TPath.Combine(pPasta, pMascara), faAnyFile and not faDirectory,
    F) = 0 then
  begin
    try
      repeat
        if (F.Name <> '.') and (F.Name <> '..') then
          pNomesArqSL.Add(F.Name);
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;
  end;
end;

procedure VaParaPasta(pPasta: string);
begin
  SetCurrentDir(pPasta);
end;

function VaParaPastaDoArquivo(const pNomeArq: string;
  pProcessLog: IProcessLog): string;
var
  sPasta: string;
  sLog: string;
begin
  sLog := 'NomeArq=' + pNomeArq;
  pProcessLog.PegueLocal('Sis.UI.IO.Files function VaParaPastaDoArquivo');

  sPasta := GarantirPastaDoArquivo(pNomeArq);
  sLog := sLog + ',Pasta=' + sPasta;
  pProcessLog.RegistreLog(sLog);
  VaParaPasta(sPasta);
  pProcessLog.RetorneLocal;
end;

function EscolhaArquivo(var pNomeArq: string; pFiltros: string;
  pTitulo: string): boolean;
var
  OpenDialog1: TOpenDialog;
begin
  OpenDialog1 := TOpenDialog.Create(nil);
  try
    if pFiltros = '' then
      pFiltros := '*.*|*.*';

    if pTitulo = '' then
      pTitulo := 'Escolha o arquivo...';

    OpenDialog1.Filter := pFiltros;
    OpenDialog1.Title := pTitulo;
    OpenDialog1.FileName := pNomeArq;

    Result := OpenDialog1.Execute;

    if Result then
      pNomeArq := OpenDialog1.FileName;
  finally
    OpenDialog1.Free;
  end;
end;

end.
