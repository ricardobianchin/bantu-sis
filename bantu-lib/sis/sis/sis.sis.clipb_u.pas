unit sis.sis.clipb_u;

interface

function GetClipboardText: string;
procedure SetClipboardText(const AText: string);

implementation

uses
  Clipbrd // unit necess�ria para manipular a �rea de transfer�ncia
  , Winapi.Windows
  ;

// fun��o que retorna o conte�do da �rea de transfer�ncia como uma string
function GetClipboardText: string;
begin
  // verifica se a �rea de transfer�ncia cont�m texto
  if Clipboard.HasFormat(CF_TEXT) then
    // retorna o texto da �rea de transfer�ncia
    Result := Clipboard.AsText
  else
    // retorna uma string vazia se n�o houver texto
    Result := '';
end;

// procedimento que recebe uma string e coloca na �rea de transfer�ncia
procedure SetClipboardText(const AText: string);
begin
  // limpa a �rea de transfer�ncia
  Clipboard.Clear;
  // coloca a string na �rea de transfer�ncia
  Clipboard.AsText := AText;
end;

end.
