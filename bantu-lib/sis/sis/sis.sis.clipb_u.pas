unit sis.sis.clipb_u;

interface

function GetClipboardText: string;
procedure SetClipboardText(const AText: string);

implementation

uses
  Clipbrd // unit necessária para manipular a área de transferência
  , Winapi.Windows
  ;

// função que retorna o conteúdo da área de transferência como uma string
function GetClipboardText: string;
begin
  // verifica se a área de transferência contém texto
  if Clipboard.HasFormat(CF_TEXT) then
    // retorna o texto da área de transferência
    Result := Clipboard.AsText
  else
    // retorna uma string vazia se não houver texto
    Result := '';
end;

// procedimento que recebe uma string e coloca na área de transferência
procedure SetClipboardText(const AText: string);
begin
  // limpa a área de transferência
  Clipboard.Clear;
  // coloca a string na área de transferência
  Clipboard.AsText := AText;
end;

end.
