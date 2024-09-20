unit Sis.ModuloSistema.Types;

interface

type
  TTipoOpcaoSisModulo = (moduConfiguracoes = 1, moduRetaguarda = 2,
    moduPDV = 3);

  TTiposOpcaoSisModulo = set of TTipoOpcaoSisModulo;

function TipoOpcaoSisModuloToStr(pTipoModulo: TTipoOpcaoSisModulo): string;
function TipoOpcaoSisModuloToName(pTipoModulo: TTipoOpcaoSisModulo): string;
function NameToTipoOpcaoSisModulo(pName: string): TTipoOpcaoSisModulo;

implementation

uses Sis.Types.strings_u;

function TipoOpcaoSisModuloToStr(pTipoModulo: TTipoOpcaoSisModulo): string;
begin
  case pTipoModulo of
    moduConfiguracoes:
      Result := 'Configuracoes';
    moduRetaguarda:
      Result := 'Retaguarda';
    moduPDV:
      Result := 'PDV';
  else
    Result := 'Nao indicado';
  end;
end;

function TipoOpcaoSisModuloToName(pTipoModulo: TTipoOpcaoSisModulo): string;
begin
  case pTipoModulo of
    moduConfiguracoes:
      Result := 'CONFIG';
    moduRetaguarda:
      Result := 'RETAG';
    moduPDV:
      Result := 'PDV';
  else
    Result := 'NAO_INDICADO';
  end;
end;

function NameToTipoOpcaoSisModulo(pName: string): TTipoOpcaoSisModulo;
begin
  pName := StrToName(pName);
  if pName = 'CONFIG' then
    Result := moduConfiguracoes
  else if pName = 'PDV' then
    Result := moduPDV
  else //if pName = 'RETAG' then
    Result := moduRetaguarda;
end;

end.
