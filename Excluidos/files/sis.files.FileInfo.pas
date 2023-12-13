unit sis.files.FileInfo;

interface

type
  IFileInfo = interface
    ['{8A995B1F-0E1D-4C40-ADE8-88A6F4C4199E}']
    function GetPasta: string;
//    procedure SetPasta(const Value: string);

    function GetNome: string;
//    procedure SetNome(const Value: string);

    function GetData: TDateTime;
//    procedure SetData(const Value: TDateTime);

    function GetCaminhoCompleto: string;

    property Pasta: string read GetPasta {write SetPasta};
    property Nome: string read GetNome {write SetNome};
    property Data: TDateTime read GetData {write SetData};

    procedure PegarDe(pOutroFileInfo: IFileInfo);
  end;

implementation

end.
