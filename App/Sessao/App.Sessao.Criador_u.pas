unit App.Sessao.Criador_u;

interface

uses App.Sessao.Criador, App.Sessao, Sis.ModuloSistema.Types;

type
  TSessaoCriador = class(TInterfacedObject, ISessaoCriador)
  private
    FTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
    function GetCaption: string;
  protected
    function GetTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
    procedure SetTipoOpcaoSisModulo(Value: TTipoOpcaoSisModulo);
  public
    property TipoOpcaoSisModulo: TTipoOpcaoSisModulo read GetTipoOpcaoSisModulo
      write SetTipoOpcaoSisModulo;
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
  Result := TipoOpcaoSisModuloToStr(FTipoOpcaoSisModulo);
end;

function TSessaoCriador.GetTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
begin
  Result := FTipoOpcaoSisModulo;
end;

procedure TSessaoCriador.SetTipoOpcaoSisModulo(Value: TTipoOpcaoSisModulo);
begin
  FTipoOpcaoSisModulo := Value;
end;

end.
