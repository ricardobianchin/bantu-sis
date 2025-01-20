unit Sis.Win.Utils.Printer_u;

interface

procedure ImprimaWinSpool(pNomeImpressora, pTitulo, pTexto: string);

implementation

uses Winapi.WinSpool, System.SysUtils;

procedure ImprimaWinSpool(pNomeImpressora, pTitulo, pTexto: string);
var
  Doc: Doc_Info_1;
  iRet: Longword;
  s: String;
  HPrinter: THandle;
  iSize: Cardinal;
begin
  OpenPrinter(PChar(pNomeImpressora), HPrinter, nil);
  Doc.pDocName := PWideChar(pTitulo);
  Doc.pOutputFile := '';
  Doc.pDatatype := 'RAW';
  StartDocPrinter(HPrinter, 1, @Doc);

  s := pTexto;
  iSize := Strlen(PChar(s));

  WritePrinter(HPrinter, @s[1], iSize, iRet);
  EndDocPrinter(HPrinter);
  ClosePrinter(HPrinter);
end;

end.
