unit Sis.UI.FormCreator;

interface

uses Vcl.Forms, System.Classes;

type
  IFormCreator = interface(IInterface)
    ['{BBC99441-8A90-456D-9648-19EBEF4E8A82}']
    function FormCreate(AOwner: TComponent): TForm;
    function GetTitulo: string;
    property Titulo: string read GetTitulo;

    function GetFormClassName: string;
    property FormClassName: string read GetFormClassName;
  end;

implementation

end.
