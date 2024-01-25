unit Sis.Usuario.DBI;

interface

uses Sis.DBI;

type
  IUsuarioDBI = interface(IDBI)
    ['{AAE3F320-DDBC-47E9-B444-DC8CDCA066E5}']
    function LoginTente(pNomeUsuDig: string; pSenhaDig: string; out pMens: string): boolean;
  end;

implementation

end.
