unit Sis.ModuloSistema_u;

interface

uses Sis.ModuloSistema, Sis.ModuloSistema.Types;

//  TTipoOpcaoSisModulo = (moduConfiguracoes = 1, moduRetaguarda = 2,
//    moduPDV = 3);

{
    function GetTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
    property TipoOpcaoSisModulo: TTipoOpcaoSisModulo read GetTipoOpcaoSisModulo;

    function GetTipoOpcaoSisModuloDescr: string;
    property TipoOpcaoSisModuloDescr: string read GetTipoOpcaoSisModuloDescr;

    function GetTipoModuloSistemaInt: integer;
    property TipoModuloSistemaInt: integer read GetTipoModuloSistemaInt;

}
type
  TModuloSistema = class(TInterfacedObject, IModuloSistema)
  private
    FTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
    FTipoOpcaoSisModuloDescr: string;
    FTipoOpcaoSisModuloInt: integer;

    function GetTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
    function GetTipoOpcaoSisModuloDescr: string;

    function GetTipoModuloSistemaInt: integer;

  public
    property TipoOpcaoSisModulo: TTipoOpcaoSisModulo read GetTipoOpcaoSisModulo;
    property TipoModuloSistemaDescr: string read GetTipoOpcaoSisModuloDescr;
    property TipoModuloSistemaInt: integer read GetTipoModuloSistemaInt;

    constructor Create(pTipoOpcaoSisModulo: TTipoOpcaoSisModulo);
  end;

implementation

{ TModuloSistema }

constructor TModuloSistema.Create(pTipoOpcaoSisModulo: TTipoOpcaoSisModulo);
begin
  FTipoOpcaoSisModulo := pTipoOpcaoSisModulo;
  FTipoOpcaoSisModuloDescr := TipoOpcaoSisModuloToStr(FTipoOpcaoSisModulo);
  FTipoOpcaoSisModuloInt := integer(FTipoOpcaoSisModulo);
end;

function TModuloSistema.GetTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
begin
  Result := FTipoOpcaoSisModulo;
end;

function TModuloSistema.GetTipoModuloSistemaInt: integer;
begin
  Result := FTipoOpcaoSisModuloInt;
end;

function TModuloSistema.GetTipoOpcaoSisModuloDescr: string;
begin
  Result := FTipoOpcaoSisModuloDescr;
end;

end.
