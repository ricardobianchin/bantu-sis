unit App.Pess.DBI;

interface

uses App.Ent.DBI, System.Classes;

type
  IPessDBI = interface(IEntDBI)
    ['{F31062A5-21BA-4E75-836A-F7B0CD38D903}']
    procedure MunicipioPrepareLista(pUFSigla: string; pSL: TStrings);
    function CToIdLojaTermRecord(const C: string; out pLojaId: smallint;
      out pTerminalId: smallint; out pPessoaId: integer;
      out pNome: string): boolean;
  end;

implementation

end.
