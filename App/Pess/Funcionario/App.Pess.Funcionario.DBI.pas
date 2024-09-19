unit App.Pess.Funcionario.DBI;

interface

uses App.Pess.DBI, Vcl.CheckLst, Sis.UI.IO.Output;

type
  IPessFuncionarioDBI = interface(IPessDBI)
    ['{011541C3-B696-4319-9AD7-BB2CF164DE88}']
    function GravarSenha(pNovaSenha: string; pCryVer: integer;
      out pMens: string): Boolean;

    function PreencherCheckListBox(pCheckListBox: TCheckListBox;
      pErroOutput: IOutput): Boolean;
  end;

implementation

end.
