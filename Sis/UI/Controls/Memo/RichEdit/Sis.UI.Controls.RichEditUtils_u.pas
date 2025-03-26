unit Sis.UI.Controls.RichEditUtils_u;

interface

uses Vcl.ComCtrls;

procedure AddMarkdownLine(pRichEdit1: TRichEdit; pLine: string);

implementation

uses System.SysUtils, Sis.Types.strings_u, Vcl.Graphics, Windows,
  Sis.UI.Controls.Utils;

const
  EM_LINEINDEX = $BB;
  EM_SCROLLCARET = $B7;

procedure SeparePrimeiraPalavra(pStrOrigem: string; out pStrIni: string;
  out pStrFim: string);
var
  iPosSpace: integer;
begin
  if (Trim(pStrOrigem) = '') then
  begin
    pStrIni := '';
    pStrFim := '';
    exit;
  end;

  iPosSpace := Pos(' ', pStrOrigem);

  Sis.Types.strings_u.StrSepareInicio(pStrOrigem, iPosSpace, pStrIni, pStrFim);
end;

procedure AddMarkdownLine(pRichEdit1: TRichEdit; pLine: string);
var
  iSize: integer;
  sStrIni, sStrFim: string;
  sTrimIni: string;
  cPrim: Char;
  PosInicioUltimaLinha: integer;
begin
  SeparePrimeiraPalavra(pLine, sStrIni, sStrFim);

  if Trim(sStrFim) = '' then
  begin
    pRichEdit1.Lines.Add('');
    exit;
  end;

  iSize := 9;

  sTrimIni := Trim(sStrIni);

  if Trim(sTrimIni) = '' then
    cPrim := #0
  else
    cPrim := sTrimIni[1];

  if sTrimIni = '#' then
    iSize := 18
  else if sTrimIni = '##' then
    iSize := 16
  else if sTrimIni = '###' then
    iSize := 14
  else if sTrimIni = '####' then
    iSize := 12
  else if sTrimIni = '#####' then
    iSize := 10
  else if cPrim = '-' then
    sStrFim := '  ' + sStrIni + ' ' + sStrFim;

  pRichEdit1.Lines.Add(sStrFim);

//  SimuleTecla( vk_end, pRichEdit1);
//  pRichEdit1.Perform( EM_SCROLLCARET, 0, 0 );
//
//  PosInicioUltimaLinha := pRichEdit1.Perform(EM_LINEINDEX,
//    pRichEdit1.Lines.Count - 1, 0);
//  pRichEdit1.SelStart := PosInicioUltimaLinha;
//
//  pRichEdit1.SelLength := Length(sStrFim);
//
//  if cPrim = '#' then
//    pRichEdit1.Font.Style := pRichEdit1.SelAttributes.Style + [fsBold]
//  else
//    pRichEdit1.Font.Style := pRichEdit1.SelAttributes.Style - [fsBold];
//
//  //// Linha 1: Título 'doc', negrito, tamanho 16
//  //// RichEdit1.SelAttributes.Name := 'Arial'; // Define a fonte (opcional, ajuste conforme necessário)
//  //// pRichEdit1.SelAttributes.Style := [fsBold]; // Negrito
//  pRichEdit1.SelAttributes.Size := iSize;

end;

end.
