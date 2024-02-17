unit Sis.Lists.AlignmentList;

interface

uses Sis.Lists.Lista, System.Classes;

type
  IAlignmentList = interface(ILista)
    ['{47D2A81E-E7D8-4D30-B5AE-3C5DFD20C99E}']
    function Add(Valor: TAlignment): integer;
    function GetAlignment(Index: integer): TAlignment;
    property Alignment[Index:integer]: TAlignment read GetAlignment; default;
  end;

implementation

end.
