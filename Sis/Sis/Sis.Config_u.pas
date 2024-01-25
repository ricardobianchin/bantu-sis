unit Sis.Config_u;

interface

uses Sis.Config, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, Xml.XMLDoc, Xml.XMLIntf;

type
  TConfig = class(TInterfacedObject, IConfig)
  private
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FPasta, FNomeArq, FArqXML: string;
    FXMLDocument1: IXMLDocument;
    FRootNode: IXMLNODE;
  protected
    function Ler: boolean; virtual;
    procedure Gravar; virtual;
    procedure Inicialize; virtual;
    procedure PrepDocGravar;
    function GetNomeArq: string; virtual; abstract;

    property NomeArq: string read GetNomeArq;

    property XMLDocument1: IXMLDocument read FXMLDocument1 write FXMLDocument1;
    property RootNode: IXMLNode read FRootNode write FRootNode;

    procedure XMLDocumentSalvar;
    procedure XMLDocumentLer;

  public
    property ProcessLog: IProcessLog read FProcessLog;
    property Output: IOutput read FOutput;
    constructor Create(pProcessLog: IProcessLog; pOutput: IOutput);
  end;

implementation

uses Sis.UI.IO.Files, System.SysUtils;

{ TConfig }

constructor TConfig.Create(pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FProcessLog := pProcessLog;
  FOutput := pOutput;

  Inicialize;

  if not Ler then
    Gravar;
end;

procedure TConfig.Gravar;
begin
  PrepDocGravar;
end;

procedure TConfig.Inicialize;
begin
  FPasta := GetPastaDoArquivo(ParamStr(0));
  FNomeArq := GetNomeArq;
  FArqXML := FPasta + FNomeArq;
end;

function TConfig.Ler: boolean;
begin
  Result := FileExists(FArqXML);

  if not Result then
    exit;

  XMLDocumentLer;
  RootNode := XMLDocument1.DocumentElement;
end;

procedure TConfig.PrepDocGravar;
begin
  XMLDocument1:=NewXMLDocument;
  XMLDocument1.Encoding := 'utf-8';
  XMLDocument1.Options := [doNodeAutoIndent]; // looks better in Editor ;)

end;

procedure TConfig.XMLDocumentLer;
begin
  XMLDocument1 := LoadXMLDocument(FArqXML);
end;

procedure TConfig.XMLDocumentSalvar;
begin
  XMLDocument1.SaveToFile(FArqXML);
end;

end.
