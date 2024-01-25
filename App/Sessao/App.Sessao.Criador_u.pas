unit App.Sessao.Criador_u;

interface

uses App.Sessao.Criador, App.Sessao, Sis.Modulo.Types;

type
  TSessaoCriador = class(TInterfacedObject, ISessaoCriador)
  private
    FTipoModuloSistema: TTipoModuloSistema;
  protected
    function GetTipoModuloSistema: TTipoModuloSistema; virtual; abstract;
    function GetCaption: string;
    property TipoModuloSistema: TTipoModuloSistema read FTipoModuloSistema write FTipoModuloSistema;
  public
    function SessaoCreate: ISessao; virtual; abstract;

  end;


implementation

{ TSessaoCriador }

function TSessaoCriador.GetCaption: string;
begin
  Result := TipoModuloSistemaToStr(FTipoModuloSistema);
end;

end.
