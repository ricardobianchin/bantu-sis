unit App.UI.Config.ConfigPergForm_u.CarregaServ;

interface

procedure ConfigArqLeiaDoServ(pNomeArqXML: string; out pNomeNaRede: string; out pIp: string);

implementation

uses 
  System.SysUtils, System.Classes, Xml.XMLDoc, Xml.XMLIntf, Vcl.Dialogs;

{**
 * Lê o arquivo XML de configuração do servidor e extrai o nome na rede e o IP.
 * @param pNomeArqXML Nome do arquivo XML a ser lido.
 * @param pNomeNaRede Nome do servidor na rede.
 * @param pIp Endereço IP do servidor.
 * @raises Exception Se ocorrer algum erro ao ler o arquivo XML ou se os dados estiverem ausentes.
}

procedure ConfigArqLeiaDoServ(pNomeArqXML: string; out pNomeNaRede: string; out pIp: string);
var
  XmlDoc: IXMLDocument;
  RootNode, ServerNode: IXMLNode;  
begin
  if not FileExists(pNomeArqXML) then
    raise Exception.Create('Caminho inválido para o arquivo de configurações do servidor.');

    XmlDoc := LoadXMLDocument(pNomeArqXML);
    XmlDoc.Active := True;

    RootNode := XmlDoc.DocumentElement;
    if RootNode = nil then
        raise Exception.Create('Erro ao carregar o arquivo XML: Raiz não encontrada.');

    ServerNode := RootNode.ChildNodes.FindNode('SERVER');
    if ServerNode = nil then
        raise Exception.Create('Erro ao carregar o arquivo XML: Nó SERVER não encontrado.');
    
    pNomeNaRede := ServerNode.ChildNodes['NOME'].Text;
    pIp := ServerNode.ChildNodes['IP'].Text;
    
    if (pNomeNaRede = '') or (pIp = '') then
        raise Exception.Create('Erro ao carregar o arquivo XML: NOME ou IP vazio.');

end;

end.
