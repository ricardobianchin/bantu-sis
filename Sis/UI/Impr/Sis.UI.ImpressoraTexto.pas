unit Sis.UI.ImpressoraTexto;

interface

uses Sis.UI.Impressora;

type
  IImpressoraTexto = interface(IImpressora)
    ['{513E3F3B-D446-4BE4-893B-1414730690EF}']
    procedure ImprimaTexto(pDocTitulo, pTexto: string);
  end;

implementation

end.
