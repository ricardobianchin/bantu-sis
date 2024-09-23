unit Sis.ModuloSistema_u;

interface

uses Sis.ModuloSistema, Sis.ModuloSistema.Types;

type
  TModuloSistema = class(TInterfacedObject, IModuloSistema)
  private
    FTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    FTipoOpcaoSisModuloDescr: string;
    FTipoOpcaoSisModuloInt: integer;

    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    function GetTipoOpcaoSisModuloDescr: string;

    function GetTipoModuloSistemaInt: integer;

  public
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo;
    property TipoModuloSistemaDescr: string read GetTipoOpcaoSisModuloDescr;
    property TipoModuloSistemaInt: integer read GetTipoModuloSistemaInt;

    constructor Create(pTipoOpcaoSisModulo: TOpcaoSisIdModulo);
  end;

implementation

{ TModuloSistema }

constructor TModuloSistema.Create(pTipoOpcaoSisModulo: TOpcaoSisIdModulo);
begin
  FTipoOpcaoSisModulo := pTipoOpcaoSisModulo;
  FTipoOpcaoSisModuloDescr := TipoOpcaoSisModuloToStr(FTipoOpcaoSisModulo);
  FTipoOpcaoSisModuloInt := integer(FTipoOpcaoSisModulo);
end;

function TModuloSistema.GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
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
