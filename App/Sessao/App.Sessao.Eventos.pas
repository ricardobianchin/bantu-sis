unit App.Sessao.Eventos;

interface

uses App.Constants;

type
  ISessaoEventos = interface(IInterface)
    ['{8A393416-9C17-4779-9EEE-3B4E5C2D3340}']
    procedure DoCancel;
    procedure DoOk;
    procedure DoAposModuloOcultar;
    procedure DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
    procedure DoFecharSessao(pSessaoIndex: TSessaoIndex);
    procedure DoAbrirSessao(pSessaoIndex: TSessaoIndex);
  end;

implementation

end.
