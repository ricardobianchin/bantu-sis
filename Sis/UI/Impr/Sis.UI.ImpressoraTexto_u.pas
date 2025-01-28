unit Sis.UI.ImpressoraTexto_u;

interface

uses Sis.UI.Impressora_u, Sis.UI.ImpressoraTexto, Winapi.WinSpool;

type
  TImpressoraTexto = class(TImpressora, IImpressoraTexto)
  private
    HPrinter: THandle;
  protected
    function Abrir(pDocTItulo: string): Boolean; override;
    procedure Fechar; override;
    procedure ImprTexto(pTexto: string);
  public
    procedure ImprimaTexto(pDocTitulo, pTexto: string);
  end;

implementation

uses System.SysUtils;

{ TImpressoraTexto }

function TImpressoraTexto.Abrir(pDocTItulo: string): Boolean;
var
  sNome: string;
  Doc: Doc_Info_1;
begin
  sNome := Nome;
  OpenPrinter(PChar(sNome), HPrinter, nil);
  Doc.pDocName := PWideChar(pDocTItulo);
  Doc.pOutputFile := '';
  Doc.pDatatype := 'RAW';
  StartDocPrinter(HPrinter, 1, @Doc);
  result := True;
end;

procedure TImpressoraTexto.Fechar;
begin
  inherited;
  EndDocPrinter(HPrinter);
  ClosePrinter(HPrinter);
end;

procedure TImpressoraTexto.ImprimaTexto(pDocTitulo, pTexto: string);
begin
  Abrir(pDocTitulo);
  ImprTexto(pTexto);
  Fechar;
end;

procedure TImpressoraTexto.ImprTexto(pTexto: string);
var
  s: String;
  iRet: Longword;
  iSize: Cardinal;
begin
  s := pTexto;
  iSize := Strlen(PChar(s));

  WritePrinter(HPrinter, @s[1], iSize, iRet);
end;

end.
