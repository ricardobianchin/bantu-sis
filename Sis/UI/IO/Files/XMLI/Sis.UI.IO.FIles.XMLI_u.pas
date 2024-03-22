unit Sis.UI.IO.FIles.XMLI_u;

interface

uses Sis.UI.IO.Fils.FileI_u, Sis.UI.IO.FIles.XMLI;

type
  TXMLI = class(TFileI, IXMLI)
  private
    FXMLDocument1: IXMLDocument;
    FRootNode: IXMLNODE;
  protected
    property XMLDocument1: IXMLDocument read FXMLDocument1 write FXMLDocument1;
    property RootNode: IXMLNode read FRootNode write FRootNode;
    function PrepLer: boolean; virtual; abstract;
    function PrepGravar: boolean; virtual; abstract;
  public
    function Ler: boolean; virtual;
    function Gravar: boolean; virtual;

    constructor Create(pNome: string; pExt: string = '';
      pPasta: string = ''; pAutoCreate: boolean = false;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);

  end;

implementation

{ TXMLI }

constructor TXMLI.Create(pNome, pExt, pPasta: string; pAutoCreate: boolean;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create(pNome, pExt, pPasta, pAutoCreate, pProcessLog, pOutput);
end;

function TXMLI.Gravar: boolean;
begin
  Result := PrepGravar;
  if not Result then
    exit;
  XMLDocument1.SaveToFile(FArqXML);
end;

function TXMLI.Ler: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  XMLDocument1 := LoadXMLDocument(FArqXML);
  RootNode := XMLDocument1.DocumentElement;
  Result := PrepLer;
end;

end.
