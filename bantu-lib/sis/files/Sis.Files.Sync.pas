unit Sis.Files.Sync;

interface

uses Sis.Files.FileInfo, Generics.Collections, System.Classes;

procedure PopularListaArquivos(pPasta: string; var pLista: TList<IFileInfo>);
function GetDataArquivo(const NomeArquivo: string): TDateTime;
function BuscarArquivo(pArquivosLista: TList<IFileInfo>; sNomeBusca: string;
  var pArquivoEncontrado: IFileInfo): boolean;
procedure VerificarArquivosDesatualizados(pOrigemLista: TList<IFileInfo>;
  pDestinoLista: TList<IFileInfo>; pDesatualizadosSL: TStrings);

implementation

uses System.SysUtils, System.IOUtils, Sis.Files.factory;

procedure PopularListaArquivos(pPasta: string; var pLista: TList<IFileInfo>);
var
  SR: TSearchRec;
  oFileInfo: IFileInfo;
  Dth: TDateTime;
  bResult: boolean;
begin
  if FindFirst(IncludeTrailingPathDelimiter(pPasta) + '*.*', faAnyFile, SR) = 0
  then
  begin
    try
      repeat
        bResult := (SR.Name <> '.') and (SR.Name <> '..') and
          ((SR.Attr and faDirectory) <> faDirectory);

        if bResult then
        begin
          Dth := FileDateToDateTime(SR.Time);
          oFileInfo := FIleInfoCreate(pPasta, SR.Name, Dth);
          pLista.Add(oFileInfo);
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
  end;
end;

function GetDataArquivo(const NomeArquivo: string): TDateTime;
var
  SR: TSearchRec;
begin
  if FindFirst(NomeArquivo, faAnyFile, SR) = 0 then
  begin
    Result := FileDateToDateTime(SR.Time);
    FindClose(SR);
  end
  else
    Result := 0;
  // raise Exception.CreateFmt('Arquivo %s não encontrado', [NomeArquivo]);
end;

function BuscarArquivo(pArquivosLista: TList<IFileInfo>; sNomeBusca: string;
  var pArquivoEncontrado: IFileInfo): boolean;
var
  FI: IFileInfo;
begin
  Result := False;

  for FI in pArquivosLista do
  begin
    Result := FI.Nome = sNomeBusca;

    if Result then
    begin
      pArquivoEncontrado.PegarDe(FI);
      Result := True;
      Break;
    end;
  end;
end;

procedure VerificarArquivosDesatualizados(pOrigemLista: TList<IFileInfo>;
  pDestinoLista: TList<IFileInfo>; pDesatualizadosSL: TStrings);
var
  i: Integer;
  ArquivoOrigem, ArquivoDestino: IFileInfo;
  Resultado: boolean;
begin
  pDesatualizadosSL.Clear;

  for ArquivoOrigem in pOrigemLista do
  begin
    Resultado := BuscarArquivo(pDestinoLista, ArquivoOrigem.Nome,
      ArquivoDestino);
    if not Resultado then
      Continue;

    if ArquivoOrigem.Data > ArquivoDestino.Data then
      pDesatualizadosSL.Add(ArquivoOrigem.Nome);
  end;
end;

procedure AtualizarArquivos(pPastaOrigem, pPastaDestino: string);
var
  OrigemLista, DestinoLista: TList<IFileInfo>;
  oDesatualizadosSL: TStringList;
  i: Integer;
  sOrigem, sDestino: string;
begin
  OrigemLista := TList<IFileInfo>.Create;
  DestinoLista := TList<IFileInfo>.Create;
  oDesatualizadosSL := TStringList.Create;

  pPastaOrigem := IncludeTrailingPathDelimiter(pPastaOrigem);
  pPastaDestino := IncludeTrailingPathDelimiter(pPastaDestino);

  try
    // Popular as listas com os arquivos das pastas de origem e destino
    PopularListaArquivos(pPastaOrigem, OrigemLista);
    PopularListaArquivos(pPastaDestino, DestinoLista);

    // Verificar quais arquivos estão desatualizados
    VerificarArquivosDesatualizados(OrigemLista, DestinoLista,
      oDesatualizadosSL);

    // Copiar os arquivos desatualizados da pasta de origem para a pasta de destino
    for i := 0 to oDesatualizadosSL.Count - 1 do
    begin
      sOrigem := pPastaOrigem + oDesatualizadosSL[i];
      sDestino := pPastaDestino + oDesatualizadosSL[i];
      TFile.Copy(sOrigem, sDestino, True);
    end;

  finally
    OrigemLista.Free;
    DestinoLista.Free;
    oDesatualizadosSL.Free;
  end;
end;

end.
