unit App.Sessao.Eventos;

interface

type
  ISessaoEventos = interface(IInterface)
    ['{8A393416-9C17-4779-9EEE-3B4E5C2D3340}']
    procedure DoCancel;
    procedure DoOk;
    procedure DoFecharSessao(pSessaoIndex: Cardinal);
  end;

implementation

end.
