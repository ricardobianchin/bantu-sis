unit App.PessEnder;

interface

type
  IPessEnder = interface(IInterface)
    ['{38263291-0E56-4DB5-A18A-DBB53DA7C285}']
    function GetOrdem: smallint;
    procedure SetOrdem(const Value: smallint);
    property Ordem: smallint read GetOrdem write SetOrdem;

    function GetLogradouro: string;
    procedure SetLogradouro(const Value: string);
    property Logradouro: string read GetLogradouro write SetLogradouro;

    function GetNumero: string;
    procedure SetNumero(const Value: string);
    property Numero: string read GetNumero write SetNumero;

    function GetComplemento: string;
    procedure SetComplemento(const Value: string);
    property Complemento: string read GetComplemento write SetComplemento;

    function GetBairro: string;
    procedure SetBairro(const Value: string);
    property Bairro: string read GetBairro write SetBairro;

    function GetUFSigla: string;
    procedure SetUFSigla(const Value: string);
    property UFSigla: string read GetUFSigla write SetUFSigla;

    function GetCEP: string;
    procedure SetCEP(const Value: string);
    property CEP: string read GetCEP write SetCEP;

    function GetMunicipioIbgeId: string;
    procedure SetMunicipioIbgeId(const Value: string);
    property MunicipioIbgeId: string read GetMunicipioIbgeId write SetMunicipioIbgeId;

    function GetMunicipioNome: string;
    procedure SetMunicipioNome(const Value: string);
    property MunicipioNome: string read GetMunicipioNome write SetMunicipioNome;

    function GetDDD: string;
    procedure SetDDD(const Value: string);
    property DDD: string read GetDDD write SetDDD;

    function GetFone1: string;
    procedure SetFone1(const Value: string);
    property Fone1: string read GetFone1 write SetFone1;

    function GetFone2: string;
    procedure SetFone2(const Value: string);
    property Fone2: string read GetFone2 write SetFone2;

    function GetFone3: string;
    procedure SetFone3(const Value: string);
    property Fone3: string read GetFone3 write SetFone3;

    function GetContato: string;
    procedure SetContato(const Value: string);
    property Contato: string read GetContato write SetContato;

    function GetReferencia: string;
    procedure SetReferencia(const Value: string);
    property Referencia: string read GetReferencia write SetReferencia;

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(const Value: TDateTime);
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(const Value: TDateTime);
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    function GetEnder1: string;
    property Ender1: string read GetEnder1;

    function GetEnder2: string;
    property Ender2: string read GetEnder2;

    function GetEnder3: string;
    property Ender3: string read GetEnder3;
  end;

implementation

end.
