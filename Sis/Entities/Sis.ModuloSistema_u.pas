unit Sis.ModuloSistema_u;

interface

uses Sis.ModuloSistema, Sis.ModuloSistema.Types;

type
  TModuloSistema = class(TInterfacedObject, IModuloSistema)
  private
    FTipoModuloSistema: TTipoModuloSistema;
    FTipoModuloSistemaDescr: string;

    function GetTipoModuloSistema: TTipoModuloSistema;
    function GetTipoModuloSistemaDescr: string;

  public
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema;
    property TipoModuloSistemaDescr: string read GetTipoModuloSistemaDescr;

    constructor Create(pTipoModuloSistema: TTipoModuloSistema);
  end;

implementation

{ TModuloSistema }

constructor TModuloSistema.Create(pTipoModuloSistema: TTipoModuloSistema);
begin
  FTipoModuloSistema := pTipoModuloSistema;
  FTipoModuloSistemaDescr := TipoModuloSistemaToStr(FTipoModuloSistema);
end;

function TModuloSistema.GetTipoModuloSistema: TTipoModuloSistema;
begin
  Result := FTipoModuloSistema;
end;

function TModuloSistema.GetTipoModuloSistemaDescr: string;
begin
  Result := FTipoModuloSistemaDescr;
end;

end.

end.
