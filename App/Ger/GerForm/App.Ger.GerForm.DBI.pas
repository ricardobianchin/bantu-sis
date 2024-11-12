unit App.Ger.GerForm.DBI;

interface

uses Sis.DBI;

type
  IGerFormDBI = interface(IDBI)
    ['{07F19A0E-0EAD-4E51-87D9-B6B2E9C82383}']
    procedure PegarConfigs(out pSempreVisivel: boolean; out pAutoOpen: boolean);
    procedure SempreVisivelGravar(pValor: Boolean);
    procedure AutoOpenGravar(pValor: Boolean);
  end;

implementation

end.
