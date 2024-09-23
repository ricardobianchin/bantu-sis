unit App.Sessao.Criador_u;

interface

uses App.Sessao.Criador, App.Sessao, Sis.ModuloSistema.Types;

type
  TSessaoCriador = class(TInterfacedObject, ISessaoCriador)
  private
    FTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    function GetCaption: string;
  protected
    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    procedure SetTipoOpcaoSisModulo(Value: TOpcaoSisIdModulo);
  public
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo
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

function TSessaoCriador.GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
begin
  Result := FTipoOpcaoSisModulo;
end;

procedure TSessaoCriador.SetTipoOpcaoSisModulo(Value: TOpcaoSisIdModulo);
begin
  FTipoOpcaoSisModulo := Value;
end;

end.
