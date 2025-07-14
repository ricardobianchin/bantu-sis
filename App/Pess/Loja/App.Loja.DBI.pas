unit App.Loja.DBI;

interface

uses App.Loja, Sis.Loja.DBI, App.AppObj;

type
  IAppLojaDBI = interface(ISisLojaDBI)
    ['{D2EBF252-2C9E-44BA-837B-896BD5AF5C3F}']
    function LerLojaEMachineId(pAppObj: IAppObj; out pMens: string): Boolean;
  end;

implementation

end.
