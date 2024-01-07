unit App.Sessao.Criador;

interface

uses App.Sessao;

type
  ISessaoCriador = interface(IInterface)
    ['{B03BDF27-40D7-462A-836C-961392F704F2}']

    function SessaoCreate: ISessao;
  end;

implementation

end.
