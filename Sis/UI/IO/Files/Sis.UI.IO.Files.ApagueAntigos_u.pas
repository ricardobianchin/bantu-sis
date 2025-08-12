unit Sis.UI.IO.Files.ApagueAntigos_u;
//unit OldFileCleaner;

interface

uses
  System.SysUtils;

procedure DeleteOldFilesAndEmptyDirs(const APath: string; const AOlderThan: TDateTime; pRemoverVazias: Boolean);

implementation

procedure DeleteOldFilesAndEmptyDirs(const APath: string; const AOlderThan: TDateTime; pRemoverVazias: Boolean);
var
  SR: TSearchRec;
  FullPath: string;
  IsEmpty: Boolean;
begin
  // Primeira passagem: deletar arquivos antigos e recursar em subpastas
  if FindFirst(IncludeTrailingPathDelimiter(APath) + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        FullPath := IncludeTrailingPathDelimiter(APath) + SR.Name;
        if (SR.Attr and faDirectory) = faDirectory then
        begin
          // Chamada recursiva para subpasta
          DeleteOldFilesAndEmptyDirs(FullPath, AOlderThan, pRemoverVazias);
        end
        else
        begin
          // Arquivo: verificar se é mais antigo e deletar
          if FileDateToDateTime(SR.Time) < AOlderThan then
          begin
            DeleteFile(FullPath);
          end;
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;

  if not pRemoverVazias then
    exit;

  // Segunda passagem: verificar se a pasta está vazia (sem arquivos ou subpastas) e remover se for o caso
  IsEmpty := True;
  if FindFirst(IncludeTrailingPathDelimiter(APath) + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        IsEmpty := False;
        Break;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
  if IsEmpty then
  begin
    RemoveDir(APath);
  end;
end;

end.
