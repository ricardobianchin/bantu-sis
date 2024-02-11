unit App.AppInfo;

interface

uses Vcl.Graphics;

type
  IAppInfo = interface(IInterface)
    ['{3F6A4F41-7A6D-4A75-BCE3-66797F458974}']
    function GetExeName: string;
    property ExeName: string read GetExeName;

    function GetPessoaDonoId: integer;
    procedure SetPessoaDonoId(Value: integer);
    property PessoaDonoId: integer read GetPessoaDonoId write SetPessoaDonoId;

    function GetFundoCor: TColor;
    procedure SetFundoCor(Value: TColor);
    property FundoCor: TColor read GetFundoCor write SetFundoCor;

    function GetFonteCor: TColor;
    procedure SetFonteCor(Value: TColor);
    property FonteCor: TColor read GetFonteCor write SetFonteCor;

    function GetNomeExib: string;
    procedure SetNomeExib(Value: string);
    property NomeExib: string read GetNomeExib write SetNomeExib;

    function GetPasta: string;
    property Pasta: string read GetPasta;

    function GetPastaBin: string;
    property PastaBin: string read GetPastaBin;

    function GetPastaDados: string;
    property PastaDados: string read GetPastaDados;

    function GetPastaImg: string;
    property PastaImg: string read GetPastaImg;

    function GetPastaComandos: string;
    property PastaComandos: string read GetPastaComandos;

    function GetPastaConsultas: string;
    property PastaConsultas: string read GetPastaConsultas;

    function GetPastaConsTabViews: string;
    property PastaConsTabViews: string read GetPastaConsTabViews;

    function GetAtualizExeSubPasta: string;
    property AtualizExeSubPasta: string read GetAtualizExeSubPasta;

    function GetAtualizExeURL: string;
    property AtualizExeURL: string read GetAtualizExeURL;

    function Get_InstUpdate_ExcluiLocalAntesDoDownload: boolean;
    property InstUpdate_ExcluiLocalAntesDoDownload: boolean
      read Get_InstUpdate_ExcluiLocalAntesDoDownload;
  end;

implementation

end.
