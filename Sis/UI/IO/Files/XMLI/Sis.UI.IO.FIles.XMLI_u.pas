unit Sis.UI.IO.FIles.XMLI_u;

interface

uses Sis.UI.IO.FIles.XMLI, Xml.XMLDoc, Xml.XMLIntf,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Files.FileI_u;

type
  TXMLI = class(TFileI, IXMLI)
  private
    FXMLDocument1: IXMLDocument;
    FRootNode: IXMLNODE;
    FRootNodeName: string;
  protected
    property XMLDocument1: IXMLDocument read FXMLDocument1 write FXMLDocument1;
    property RootNode: IXMLNode read FRootNode write FRootNode;

    function PrepLer: boolean; virtual;
    function PrepGravar: boolean; virtual;
    function GetRootNodeName: string; virtual; abstract;
  public
    function Ler: boolean; override;
    function Gravar: boolean; override;

    constructor Create(pRootNodeName: string; pNomeArq: string; pExt: string = '';
      pPasta: string = ''; pAutoCreateFile: boolean = false;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);

  end;

implementation

uses WinApi.ActiveX;

{ TXMLI }

constructor TXMLI.Create(pRootNodeName: string; pNomeArq, pExt, pPasta: string; pAutoCreateFile: boolean;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create(pNomeArq, pExt, pPasta, pAutoCreateFile, pProcessLog, pOutput);
  FRootNodeName := pRootNodeName;
end;

function TXMLI.Gravar: boolean;
begin
  Result := PrepGravar;
  if not Result then
    exit;
  XMLDocument1.SaveToFile(NomeCompletoArq);
end;

function TXMLI.Ler: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  CoInitialize(nil);
  try
    XMLDocument1 := LoadXMLDocument(NomeCompletoArq);
    RootNode := XMLDocument1.DocumentElement;
    Result := PrepLer;
  finally
    CoUninitialize;
  end;
end;

function TXMLI.PrepGravar: boolean;
begin
  XMLDocument1:=NewXMLDocument;
  XMLDocument1.Encoding := 'utf-8';
  XMLDocument1.Options := [doNodeAutoIndent]; // looks better in Editor ;)
  RootNode := XMLDocument1.AddChild(FRootNodeName);
  Result := true;
end;

function TXMLI.PrepLer: boolean;
begin
  Result := True;
end;

end.
