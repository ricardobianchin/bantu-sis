unit Sis.UI.IO.Files.Sync;

interface

uses Sis.UI.IO.Files.FileInfo, Generics.Collections, System.Classes,
  Sis.UI.IO.Output;

procedure PopularListaArquivos(pPasta: string; var pLista: TList<IFileInfo>);
function GetDataArquivo(const NomeArquivo: string): TDateTime;

function BuscarArquivo(pArquivosLista: TList<IFileInfo>;
  sNomeBusca: string): integer;

procedure VerificarArquivosDesatualizados(pOrigemLista: TList<IFileInfo>;
  pDestinoLista: TList<IFileInfo>; pDesatualizadosSL: TStrings);
procedure AtualizarArquivos(pPastaOrigem, pPastaDestino: string;
  pOutput: IOutput);

implementation

uses System.SysUtils, System.IOUtils, Sis.UI.IO.Files.Factory;

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
          // Dth := FileDateToDateTime(SR.Time);
          Dth := SR.TimeStamp;
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
    Result := SR.TimeStamp;
    FindClose(SR);
  end
  else
    Result := 0;
  // raise Exception.CreateFmt('Arquivo %s não encontrado', [NomeArquivo]);
end;

function BuscarArquivo(pArquivosLista: TList<IFileInfo>;
  sNomeBusca: string): integer;
var
  FI: IFileInfo;
  I: integer;
  Resultado: boolean;
begin
  Result := -1;

  for I := 0 to pArquivosLista.Count - 1 do
  begin
    FI := pArquivosLista[I];

    Resultado := FI.Nome = sNomeBusca;

    if Resultado then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure VerificarArquivosDesatualizados(pOrigemLista: TList<IFileInfo>;
  pDestinoLista: TList<IFileInfo>; pDesatualizadosSL: TStrings);
var
  ArquivoOrigem, ArquivoDestino: IFileInfo;
  I: integer;
  ArqExiste: boolean;
begin
  pDesatualizadosSL.Clear;

  for ArquivoOrigem in pOrigemLista do
  begin
    I := BuscarArquivo(pDestinoLista, ArquivoOrigem.Nome);
    ArqExiste := I > -1;

    if ArqExiste then
      ArquivoDestino := pDestinoLista[I];

    if (not ArqExiste) or (ArquivoOrigem.Data > ArquivoDestino.Data) then
      pDesatualizadosSL.Add(ArquivoOrigem.Nome);
  end;
end;

procedure AtualizarArquivos(pPastaOrigem, pPastaDestino: string;
  pOutput: IOutput);
var
  OrigemLista, DestinoLista: TList<IFileInfo>;
  oDesatualizadosSL: TStringList;
  I: integer;
  sOrigem, sDestino: string;
begin
  pOutput.Exibir('Sincronizando pasta');
  OrigemLista := TList<IFileInfo>.Create;
  DestinoLista := TList<IFileInfo>.Create;
  oDesatualizadosSL := TStringList.Create;

  pPastaOrigem := IncludeTrailingPathDelimiter(pPastaOrigem);
  pPastaDestino := IncludeTrailingPathDelimiter(pPastaDestino);

  ForceDirectories(pPastaDestino);

  try
    // Popular as listas com os arquivos das pastas de origem e destino
    pOutput.Exibir('Carregando ' + pPastaOrigem);
    PopularListaArquivos(pPastaOrigem, OrigemLista);
    pOutput.Exibir('Carregando ' + pPastaDestino);
    PopularListaArquivos(pPastaDestino, DestinoLista);

    // Verificar quais arquivos estão desatualizados
    pOutput.Exibir('Comparando...');
    VerificarArquivosDesatualizados(OrigemLista, DestinoLista,
      oDesatualizadosSL);

    // Copiar os arquivos desatualizados da pasta de origem para a pasta de destino
    for I := 0 to oDesatualizadosSL.Count - 1 do
    begin
      if (I mod 100) = 0 then
      begin
        pOutput.Exibir((I + 1).ToString + ' / ' +
          oDesatualizadosSL.Count.ToString);
      end;

      sOrigem := pPastaOrigem + oDesatualizadosSL[I];
      sDestino := pPastaDestino + oDesatualizadosSL[I];
      TFile.Copy(sOrigem, sDestino, True);
    end;

  finally
    OrigemLista.Free;
    DestinoLista.Free;
    oDesatualizadosSL.Free;
    pOutput.Exibir('Sincronizando pasta. fim');
  end;
end;

end.
