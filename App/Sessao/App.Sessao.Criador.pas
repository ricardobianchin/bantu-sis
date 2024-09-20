unit App.Sessao.Criador;

interface

uses App.Sessao, Sis.ModuloSistema.Types;

type
  ISessaoCriador = interface(IInterface)
    ['{B03BDF27-40D7-462A-836C-961392F704F2}']
    function GetTipoOpcaoSisModulo: TTipoOpcaoSisModulo;
    procedure SetTipoOpcaoSisModulo(Value: TTipoOpcaoSisModulo);
    property TipoOpcaoSisModulo: TTipoOpcaoSisModulo read GetTipoOpcaoSisModulo
      write SetTipoOpcaoSisModulo;

    function SessaoCreate: ISessao;
  end;

implementation

end.
