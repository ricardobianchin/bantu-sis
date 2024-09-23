unit Sis.ModuloSistema;

interface

uses Sis.ModuloSistema.Types;

type
  IModuloSistema = interface(IInterface)
    ['{2D1DB5D8-BECB-48B7-AA43-57D1F8144A42}']
    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo;

    function GetTipoOpcaoSisModuloDescr: string;
    property TipoOpcaoSisModuloDescr: string read GetTipoOpcaoSisModuloDescr;

    function GetTipoModuloSistemaInt: integer;
    property TipoModuloSistemaInt: integer read GetTipoModuloSistemaInt;
  end;

implementation

end.
