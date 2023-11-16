unit Sis.UI.IO.Output.ProcessLog.Properties;

interface

uses Sis.UI.IO.Output.ProcessLog.Types;

type
  IProcessLogProperties = interface(IInterface)
    ['{965CD73A-406E-4193-9C8B-D1A44718DFD9}']

    function GetTipo: TProcessLogTipo;
    procedure SetTipo(Value: TProcessLogTipo);
    property Tipo: TProcessLogTipo read GetTipo write SetTipo;

    function GetAssunto: TProcessLogAssunto;
    procedure SetAssunto(Value: TProcessLogAssunto);
    property Assunto: TProcessLogAssunto read GetAssunto write SetAssunto;

    function GetNome: TProcessLogNome;
    procedure SetNome(Value: TProcessLogNome);
    property Nome: TProcessLogNome read GetNome write SetNome;
  end;

implementation

end.
