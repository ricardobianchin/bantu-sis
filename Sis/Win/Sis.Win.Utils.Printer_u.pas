unit Sis.Win.Utils.Printer_u;

interface

procedure ImprimaWinSpool(pNomeImpressora, pTitulo, pTexto: string);
procedure ImprimaDireta(pPorta, pTexto: string);

implementation

uses Winapi.WinSpool, System.SysUtils;

procedure ImprimaWinSpool(pNomeImpressora, pTitulo, pTexto: string);
var
  Doc: Doc_Info_1;
  iRet: Longword;
  HPrinter: THandle;
  iSize: Cardinal;
begin
  OpenPrinter(PChar(pNomeImpressora), HPrinter, nil);
  Doc.pDocName := PWideChar(pTitulo);
  Doc.pOutputFile := '';
  Doc.pDatatype := 'RAW';
  StartDocPrinter(HPrinter, 1, @Doc);

  iSize := Strlen(PChar(pTexto));

  WritePrinter(HPrinter, @pTexto[1], iSize, iRet);
  EndDocPrinter(HPrinter);
  ClosePrinter(HPrinter);
end;

procedure ImprimaDireta(pPorta, pTexto: string);
var
  F: TextFile;
begin
  AssignFile(F, pPorta);
  Rewrite(F);
  Writeln(F, pTexto);
  CloseFile(F);
end;

end.
