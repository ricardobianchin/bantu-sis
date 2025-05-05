unit Sis.ModuloSistema.Types;

interface

type
  TOpcaoSisId = integer;

  TOpcaoSisIdModulo = (opmoduConfiguracoes = 1, opmoduRetaguarda = 2,
    opmoduPDV = 3);

  TTiposOpcaoSisModulo = set of TOpcaoSisIdModulo;

function TipoOpcaoSisModuloToStr(pTipoModulo: TOpcaoSisIdModulo): string;
function TipoOpcaoSisModuloToName(pTipoModulo: TOpcaoSisIdModulo): string;
function NameToTipoOpcaoSisModulo(pName: string): TOpcaoSisIdModulo;

implementation

uses Sis.Types.strings_u;

function TipoOpcaoSisModuloToStr(pTipoModulo: TOpcaoSisIdModulo): string;
begin
  case pTipoModulo of
    opmoduConfiguracoes:
      Result := 'Configurações';
    opmoduRetaguarda:
      Result := 'Administração'; //'Retaguarda';
    opmoduPDV:
      Result := 'PDV';
  else
    Result := 'Nao indicado';
  end;
end;

function TipoOpcaoSisModuloToName(pTipoModulo: TOpcaoSisIdModulo): string;
begin
  case pTipoModulo of
    opmoduConfiguracoes:
      Result := 'CONFIG';
    opmoduRetaguarda:
      Result := 'RETAG';
    opmoduPDV:
      Result := 'PDV';
  else
    Result := 'NAO_INDICADO';
  end;
end;

function NameToTipoOpcaoSisModulo(pName: string): TOpcaoSisIdModulo;
begin
  pName := StrToName(pName);
  if pName = 'CONFIG' then
    Result := opmoduConfiguracoes
  else if pName = 'PDV' then
    Result := opmoduPDV
  else //if pName = 'RETAG' then
    Result := opmoduRetaguarda;
end;

end.
