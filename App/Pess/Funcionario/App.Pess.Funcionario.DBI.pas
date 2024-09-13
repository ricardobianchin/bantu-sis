unit App.Pess.Funcionario.DBI;

interface

uses App.Pess.DBI;

type
  IPessFuncionarioDBI = interface(IPessDBI)
    ['{011541C3-B696-4319-9AD7-BB2CF164DE88}']
    function GravarSenha(pNovaSenha: string; pCryVer: integer;
      out pMens: string): Boolean;
  end;

implementation

end.
