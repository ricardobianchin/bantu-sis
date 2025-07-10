unit App.SisConfig.Garantir;

interface

uses Sis.Sis.Executavel;

type
  IAppSisConfigGarantirXML = interface (IExecutavel)
    ['{58297DB6-5133-41EF-8B0D-016FFA0EC08D}']
    function GetCriouTerminais: Boolean;
    procedure SetCriouTerminais(const Value: Boolean);
    property CriouTerminais: Boolean read GetCriouTerminais write SetCriouTerminais;
  end;


implementation

end.
