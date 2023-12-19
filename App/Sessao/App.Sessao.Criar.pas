unit App.Sessao.Criar;

interface

uses App.Sessao;

type
  ISessaoCriar = interface(IInterface)
    ['{B03BDF27-40D7-462A-836C-961392F704F2}']

    function SessaoCreate: ISessao;
  end;

implementation

end.
