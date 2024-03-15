unit Sis.ModuloSistema;

interface

uses Sis.ModuloSistema.Types;

type
  IModuloSistema = interface(IInterface)
    ['{2D1DB5D8-BECB-48B7-AA43-57D1F8144A42}']
    function GetTipoModuloSistema: TTipoModuloSistema;
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema;

    function GetTipoModuloSistemaDescr: string;
    property TipoModuloSistemaDescr: string read GetTipoModuloSistemaDescr;

    function GetTipoModuloSistemaChar: char;
    property TipoModuloSistemaChar: char read GetTipoModuloSistemaChar;
  end;

implementation

end.
