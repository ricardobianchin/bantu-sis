unit Sis.UI.IO.Files.ApagueAntigos_u;

interface
{

var
  bCompletou: Boolean;
  sErro: string;
begin
  bCompletou := False;
  repeat
    DeleteOldFilesAndEmptyDirs('C:\Caminho\Para\Pasta', Now - 30, True, True, bCompletou, sErro);
    // Aqui você pode adicionar um Sleep(10) ou Application.ProcessMessages
    // para não travar a aplicação, se o diretório for muito grande.
  until bCompletou;

  if sErro <> '' then
    ShowMessage(sErro);
end;

}

uses
  System.SysUtils, System.Classes;

const
  MAX_FILES_TO_DELETE = 60000;

procedure DeleteOldFilesAndEmptyDirs(const APath: string;
  const AOlderThan: TDateTime; pRemoverVazias: Boolean;
  pRecursivamente: Boolean; var pCompletei: Boolean; out pErroMens: string);

implementation

procedure DeleteOldFilesAndEmptyDirs(const APath: string;
  const AOlderThan: TDateTime; pRemoverVazias: Boolean;
  pRecursivamente: Boolean; var pCompletei: Boolean; out pErroMens: string);
var
  SR: TSearchRec;
  FullPath: string;
  FilesToDelete: TStringList;
begin
  pErroMens := '';
  pCompletei := False;
  FilesToDelete := TStringList.Create;
  try
    if FindFirst(IncludeTrailingPathDelimiter(APath) + '*.*', faAnyFile, SR) = 0 then
    begin
      try
        repeat
          if (SR.Name <> '.') and (SR.Name <> '..') then
          begin
            FullPath := IncludeTrailingPathDelimiter(APath) + SR.Name;

            if (SR.Attr and faDirectory) = faDirectory then
            begin
              // Se é um diretório, mas a recursividade não está ativada,
              // apenas continue, pois não fazemos nada com ele.
              if pRecursivamente then
              begin
                // Chamada recursiva para subdiretórios
                DeleteOldFilesAndEmptyDirs(FullPath, AOlderThan,
                  pRemoverVazias, pRecursivamente, pCompletei, pErroMens);

                // Se o subdiretório não completou, saia do método.
                if not pCompletei then
                  Exit;
              end;
            end
            else // É um arquivo
            begin
              // Se a lista de arquivos a serem apagados atingiu o limite,
              // a operação não pode ser completada nesta chamada.
              if FilesToDelete.Count >= MAX_FILES_TO_DELETE then
              begin
                pCompletei := False;
                Break; // Interrompe o loop de busca
              end;

              // Adiciona o arquivo à lista se ele for mais velho que a data limite.
              if FileDateToDateTime(SR.Time) < AOlderThan then
                FilesToDelete.Add(FullPath);
            end;
          end;
        until FindNext(SR) <> 0;
      finally
        FindClose(SR);
      end;
    end;

    // Se o loop de busca terminou naturalmente, significa que completou.
    if FindNext(SR) <> 0 then
      pCompletei := False
    else
      pCompletei := True;

    // Excluir arquivos coletados no lote atual
    for FullPath in FilesToDelete do
    begin
      try
        if not DeleteFile(FullPath) then
          pErroMens := 'Erro ao excluir: ' + FullPath;
      except
        on E: Exception do
          pErroMens := 'Erro ao excluir ' + FullPath + ': ' + E.Message;
      end;
    end;

    // Só tenta remover a pasta se o processo foi completado
    if pRemoverVazias and pCompletei then
    begin
      try
        if not RemoveDir(APath) then
          pErroMens := 'Erro ao remover pasta: ' + APath;
      except
        on E: Exception do
          pErroMens := 'Erro ao remover pasta ' + APath + ': ' + E.Message;
      end;
    end;

  finally
    FilesToDelete.Free;
  end;
end;

end.
