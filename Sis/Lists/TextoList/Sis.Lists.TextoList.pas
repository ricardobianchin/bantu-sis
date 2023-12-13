unit Sis.Lists.TextoList;

interface

uses System.Classes, Sis.Lists.TextoItem;

type
  ITextoList = interface(IInterfaceList)
    ['{C7C36F94-379F-4495-A875-9C728F9F05B2}']
    procedure PegarTextoItem(pTextoItem: ITextoItem);

    function GetTextos(pTitulo: string): string;
    property Textos[pTitulo: string]: string read GetTextos;

    function GetTextoItem(Index: integer): ITextoItem;
    property TextoItem[Index: integer]: ITextoItem read GetTextoItem; default;

    function GetTitulosComVirgulas: string;
    property TitulosComVirgulas: string read GetTitulosComVirgulas;
  end;

implementation

end.
