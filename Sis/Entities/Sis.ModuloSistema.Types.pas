unit Sis.ModuloSistema.Types;

interface

type
  TTipoModuloSistema = (modsisNaoIndicado = 32, modsisConfiguracoes = 33,
    modsisRetaguarda = 34, modsisPDV = 35);

  TTiposModuloSistema = set of TTipoModuloSistema;

function TipoModuloSistemaToChar(pTipoModuloSistema: TTipoModuloSistema): char;
function TipoModuloSistemaToStr(pTipoModuloSistema: TTipoModuloSistema): string;
function TipoModuloSistemaToNameStr(pTipoModuloSistema: TTipoModuloSistema): string;
function NameStrToTipoModuloSistema(pNameStr: string): TTipoModuloSistema;

implementation

uses Sis.Types.strings_u;

function TipoModuloSistemaToChar(pTipoModuloSistema: TTipoModuloSistema): char;
begin
  Result := Chr(Integer(pTipoModuloSistema));
end;

function TipoModuloSistemaToStr(pTipoModuloSistema: TTipoModuloSistema): string;
begin
  case pTipoModuloSistema of
    modsisConfiguracoes:
      Result := 'Configuracoes';
    modsisRetaguarda:
      Result := 'Retaguarda';
    modsisPDV:
      Result := 'PDV';
  else
    Result := 'Nao indicado'; // moduloNaoIndicado: ;
  end;
end;

function TipoModuloSistemaToNameStr(pTipoModuloSistema: TTipoModuloSistema): string;
begin
  case pTipoModuloSistema of
    modsisConfiguracoes:
      Result := 'CONFIG';
    modsisRetaguarda:
      Result := 'RETAG';
    modsisPDV:
      Result := 'PDV';
  else
    Result := 'NAO_INDICADO'; // moduloNaoIndicado: ;
  end;
end;

function NameStrToTipoModuloSistema(pNameStr: string): TTipoModuloSistema;
begin
  pNameStr := StrToName(pNameStr);
  if pNameStr = 'CONFIG' then
    Result := modsisConfiguracoes
  else if pNameStr = 'RETAG' then
    Result := modsisRetaguarda
  else if pNameStr = 'PDV' then
    Result := modsisPDV
  else
    Result := modsisNaoIndicado;
end;

end.
