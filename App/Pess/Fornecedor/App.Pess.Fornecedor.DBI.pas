unit App.Pess.Fornecedor.DBI;

interface

uses App.Pess.DBI;

type
  IPessFornecedorDBI = interface(IPessDBI)
    ['{7996A1F3-5596-422F-BCB7-0EA7A7581AA6}']
    procedure ApelidoTem(pApelido: string; out pEncontrado: Boolean;
      out pEncontradoLojaId: smallint; out pEncontradoPessoaId: integer;
      out pEncontradoNome: string; pExcetoLojaId: smallint = 0;
      pExcetoPessoaId: integer = 0);
  end;

implementation

end.
