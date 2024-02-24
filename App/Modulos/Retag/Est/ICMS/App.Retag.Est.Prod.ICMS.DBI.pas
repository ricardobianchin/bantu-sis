unit App.Retag.Est.Prod.ICMS.DBI;

interface

uses App.Ent.DBI;

type
  IProdICMSDBI = interface(IEntDBI)
    ['{36AFD119-0768-44AB-98AC-4EE65A61B5C5}']
    function AtivoSet(pIcmsId: smallint; pValor: boolean): boolean;
  end;

implementation

end.
