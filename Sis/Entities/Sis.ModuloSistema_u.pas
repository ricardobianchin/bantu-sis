unit Sis.ModuloSistema_u;

interface

uses Sis.ModuloSistema, Sis.ModuloSistema.Types;

type
  TModuloSistema = class(TInterfacedObject, IModuloSistema)
  private
    FTipoModuloSistema: TTipoModuloSistema;
    FTipoModuloSistemaDescr: string;
    FTipoModuloSistemaChar: char;

    function GetTipoModuloSistema: TTipoModuloSistema;
    function GetTipoModuloSistemaDescr: string;

    function GetTipoModuloSistemaChar: char;

  public
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema;
    property TipoModuloSistemaDescr: string read GetTipoModuloSistemaDescr;
    property TipoModuloSistemaChar: char read GetTipoModuloSistemaChar;

    constructor Create(pTipoModuloSistema: TTipoModuloSistema);
  end;

implementation

{ TModuloSistema }

constructor TModuloSistema.Create(pTipoModuloSistema: TTipoModuloSistema);
begin
  FTipoModuloSistema := pTipoModuloSistema;
  FTipoModuloSistemaDescr := TipoModuloSistemaToStr(FTipoModuloSistema);
  FTipoModuloSistemaChar := TipoModuloSistemaToChar(FTipoModuloSistema);
end;

function TModuloSistema.GetTipoModuloSistema: TTipoModuloSistema;
begin
  Result := FTipoModuloSistema;
end;

function TModuloSistema.GetTipoModuloSistemaChar: char;
begin
  Result := FTipoModuloSistemaChar;
end;

function TModuloSistema.GetTipoModuloSistemaDescr: string;
begin
  Result := FTipoModuloSistemaDescr;
end;

end.

end.
