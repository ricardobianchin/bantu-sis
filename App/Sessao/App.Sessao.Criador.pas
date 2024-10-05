unit App.Sessao.Criador;

interface

uses App.Sessao, Sis.ModuloSistema.Types, Sis.Entities.Types;

type
  ISessaoCriador = interface(IInterface)
    ['{B03BDF27-40D7-462A-836C-961392F704F2}']
    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    procedure SetTipoOpcaoSisModulo(Value: TOpcaoSisIdModulo);
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo
      write SetTipoOpcaoSisModulo;

    function SessaoCreate: ISessao;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    function GetTitulo: string;
    procedure SetTitulo(Value: string);
    property Titulo: string read GetTitulo write SetTitulo;

    function GetApelido: string;
    procedure SetApelido(Value: string);
    property Apelido: string read GetApelido write SetApelido;

    function GetNFSerie: smallint;
    procedure SetNFSerie(Value: smallint);
    property NFSerie: smallint read GetNFSerie write SetNFSerie;

    function GetSempreOffline: boolean;
    procedure SetSempreOffline(Value: boolean);
    property SempreOffline: boolean read GetSempreOffline write SetSempreOffline;
  end;

implementation

end.
