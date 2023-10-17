unit btu.sta.exec_xml_u;

interface

uses
  btu.lib.config;

procedure ConfigXmlCreate(pSisConfig: ISisConfig);
procedure ConfigXmlCarregue(pSisConfig: ISisConfig);

implementation

uses btu.lib.sis.constants, ActiveX, XMLIntf, XMLDoc, btu.lib.types.bool.utils;

procedure ConfigXmlCreate(pSisConfig: ISisConfig);
var
  XMLDoc: IXMLDOCUMENT;
  ConfigNode, ServerNode, ServerNomeNode, ServerIpNode, IsServerNode: IXMLNODE;
  s: string;
begin
  CoInitialize(nil);
  try
    XMLDoc := NewXMLDocument;
    XMLDoc.Options := [doNodeAutoIndent];
    XMLDoc.Encoding := 'utf-8';

    ConfigNode := XMLDoc.AddChild('CONFIG');
    ServerNode := ConfigNode.AddChild('SERVER');

    ServerNomeNode := ServerNode.AddChild('NOME');
    ServerNomeNode.Text := pSisConfig.ServerMachineId.Name;

    ServerIpNode := ServerNode.AddChild('IP');
    ServerIpNode.Text := pSisConfig.ServerMachineId.IP;

    if pSisConfig.LocalMachineIsServer then
      s := 'S'
    else
      s := 'N';

    IsServerNode := ServerNode.AddChild('EH_SERVIDOR');
    IsServerNode.Text := s;

    XMLDoc.SaveToFile(CONFIG_NOME_ARQ);
  finally
    CoUninitialize;
  end;
end;

procedure ConfigXmlCarregue(pSisConfig: ISisConfig);
var
  XMLDoc: IXMLDOCUMENT;
  ConfigNode, ServerNode, ServerNomeNode, ServerIpNode, IsServerNode: IXMLNODE;
  s: string;
begin
  CoInitialize(nil);
  try
    XMLDoc := LoadXMLDocument(CONFIG_NOME_ARQ);
    // carrega o arquivo xml de configuração
    ConfigNode := XMLDoc.ChildNodes.FindNode('CONFIG'); // encontra o nó raiz
    if ConfigNode <> nil then // se o nó raiz existe
    begin
      ServerNode := ConfigNode.ChildNodes.FindNode('SERVER');
      // encontra o nó do servidor
      if ServerNode <> nil then // se o nó do servidor existe
      begin
        ServerNomeNode := ServerNode.ChildNodes.FindNode('NOME');
        // encontra o nó do nome do servidor
        if ServerNomeNode <> nil then // se o nó do nome do servidor existe
          pSisConfig.ServerMachineId.Name := ServerNomeNode.Text;
        // atribui o texto do nó ao nome do servidor

        ServerIpNode := ServerNode.ChildNodes.FindNode('IP');
        // encontra o nó do ip do servidor
        if ServerIpNode <> nil then // se o nó do ip do servidor existe
          pSisConfig.ServerMachineId.IP := ServerIpNode.Text;
        // atribui o texto do nó ao ip do servidor

        IsServerNode := ServerNode.ChildNodes.FindNode('EH_SERVIDOR');
        // encontra o nó que indica se a máquina local é servidor ou não
        if IsServerNode <> nil then // se o nó existe
        begin
          s := IsServerNode.Text; // obtém o texto do nó
          if s = 'S' then // se o texto é 'S'
            pSisConfig.LocalMachineIsServer := true
            // atribui true à propriedade LocalMachineIsServer
          else // if s = 'N' then // se o texto é 'N'
            pSisConfig.LocalMachineIsServer := false;
          // atribui false à propriedade LocalMachineIsServer
        end;
      end;
    end;
  finally
    CoUninitialize;
  end;
end;

end.
