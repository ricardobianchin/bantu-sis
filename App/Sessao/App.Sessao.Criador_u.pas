unit App.Sessao.Criador_u;

interface

uses App.Sessao.Criador, App.Sessao, Sis.ModuloSistema.Types;

type
  TSessaoCriador = class(TInterfacedObject, ISessaoCriador)
  private
    FTipoModuloSistema: TTipoModuloSistema;
    function GetCaption: string;
  protected
    function GetTipoModuloSistema: TTipoModuloSistema;
    procedure SetTipoModuloSistema(Value: TTipoModuloSistema);
  public
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema write SetTipoModuloSistema;
    function SessaoCreate: ISessao; virtual; abstract;
    procedure CriarActionExecute(Sender: TObject);

  end;


implementation

{ TSessaoCriador }

procedure TSessaoCriador.CriarActionExecute(Sender: TObject);
begin

end;

function TSessaoCriador.GetCaption: string;
begin
  Result := TipoModuloSistemaToStr(FTipoModuloSistema);
end;

function TSessaoCriador.GetTipoModuloSistema: TTipoModuloSistema;
begin
  Result := FTipoModuloSistema;
end;

procedure TSessaoCriador.SetTipoModuloSistema(Value: TTipoModuloSistema);
begin
  FTipoModuloSistema := Value;
end;

end.
