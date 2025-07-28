unit Sis.UI.IO.FIles.XMLI_u;

interface

uses Sis.UI.IO.FIles.XMLI, Xml.XMLDoc, Xml.XMLIntf,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.FIles.FileI_u;

type
  TXMLI = class(TFileI, IXMLI)
  private
    FXMLDocument1: IXMLDocument;
    FRootNode: IXMLNODE;
    FRootNodeName: string;
  protected
    property XMLDocument1: IXMLDocument read FXMLDocument1 write FXMLDocument1;
    property RootNode: IXMLNODE read FRootNode write FRootNode;

    function PrepLer(var sLog: string): boolean; virtual;
    function PrepGravar(var sLog: string): boolean; virtual;
    function TestaNode(pNode: IXMLNODE; pNome: string; var sLog: string): Boolean;
  public
    function Ler: boolean; override;
    function Gravar: boolean; override;

    constructor Create(pRootNodeName: string; pNomeArq: string;
      pExt: string = ''; pPasta: string = ''; pAutoCreateFile: boolean = false;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);

  end;

implementation

uses WinApi.ActiveX, System.SysUtils;

{ TXMLI }

constructor TXMLI.Create(pRootNodeName: string; pNomeArq, pExt, pPasta: string;
  pAutoCreateFile: boolean; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create(pNomeArq, pExt, pPasta, pAutoCreateFile,
    pProcessLog, pOutput);
  FRootNodeName := pRootNodeName;
end;

function TXMLI.Gravar: boolean;
var
  sLog: string;
begin
  sLog := 'TXMLI.Gravar';
  Result := PrepGravar(sLog);
  if not Result then
    exit;
  XMLDocument1.SaveToFile(NomeCompletoArq);
end;

function TXMLI.Ler: boolean;
var
  sLog: string;
begin
  sLog := 'sLog TXMLI.Ler, vai inherited, testa se arq existe '+NomeCompletoArq;
  try
    Result := inherited;
    if not Result then
    begin
      sLog := sLog + ';arquivo nao existia, abortando';
      exit;
    end;

    sLog := sLog + ';arquivo existia, CoInitialize';
    CoInitialize(nil);
    try
      sLog := sLog + ';LoadXMLDocument "' + NomeCompletoArq + '"';
      XMLDocument1 := LoadXMLDocument(NomeCompletoArq);
      // XMLDocument1.Options := [doNormalizeWhitespace, doNodeAutoIndent]; // looks better in Editor ;)  doNormalizeWhitespace

      sLog := sLog + ';vai pegar XMLDocument1.DocumentElement';
      RootNode := XMLDocument1.DocumentElement;

      if RootNode <> nil then
        sLog := sLog + ',RootNode encontrado: ' + RootNode.NodeName
      else
        sLog := sLog + ',RootNode esta nil';

      sLog := sLog + 'vai chamar PrepLer';
      Result := PrepLer(sLog);
    finally
    begin
      sLog := sLog + ',CoUninitialize;';
      CoUninitialize;
    end;
    end;
  except
    on e: exception do
      ProcessLog.RegistreLog(sLog + ' erro ' + e.message);
  end;
end;

function TXMLI.PrepGravar(var sLog: string): boolean;
begin
  sLog := sLog + ',TXMLI.PrepGravar, XMLDocument1 := NewXMLDocument;';
  XMLDocument1 := NewXMLDocument;
  XMLDocument1.Encoding := 'utf-8';
  XMLDocument1.Options := [doNodeAutoIndent];
  // looks better in Editor ;)  doNormalizeWhitespace
  sLog := sLog + ',RootNode := XMLDocument1.AddChild, FRootNodeName='+FRootNodeName;
  RootNode := XMLDocument1.AddChild(FRootNodeName);
  Result := true;
end;

function TXMLI.PrepLer(var sLog: string): boolean;
begin
  Result := true;
end;

function TXMLI.TestaNode(pNode: IXMLNODE; pNome: string; var sLog: string): Boolean;
begin
  sLog := sLog + ',node '+pNome+'=';
  Result := pNode <> nil;
  if Result then
  begin
    sLog := sLog + 'ok'
  end
  else
  begin
    sLog := sLog + 'nil';
  end;
end;

end.
