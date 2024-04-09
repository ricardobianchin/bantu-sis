unit App.AppInfo_u;

interface

uses App.AppInfo, Vcl.Graphics, App.AppInfo.Types;

type
  TAppInfo = class(TInterfacedObject, IAppInfo)
  private
    FExeName: string;
    FPessoaDonoId: integer;
    FFundoCor: TColor;
    FFonteCor: TColor;
    FNomeExib: string;

    FPasta: string;
    FPastaBin: string;
    FPastaConfigs: string;
    FPastaDados: string;
    FPastaImg: string;
    FPastaComandos: string;
    FPastaConsultas: string;
    FPastaConsTabViews: string;

    FAtualizExeSubPasta: string;
    FAtualizExeURL: string;

    FSisTipoAtividade: TSisTipoAtividade;


    function GetExeName: string;

    function GetPessoaDonoId: integer;
    procedure SetPessoaDonoId(Value: integer);

    function GetFundoCor: TColor;
    procedure SetFundoCor(Value: TColor);

    function GetFonteCor: TColor;
    procedure SetFonteCor(Value: TColor);

    function GetNomeExib: string;
    procedure SetNomeExib(Value: string);

    function GetPasta: string;
    function GetPastaImg: string;
    function GetPastaComandos: string;
    function GetPastaConsultas: string;
    function GetPastaConsTabViews: string;

    function GetPastaBin: string;
    function GetPastaConfigs: string;

    function GetPastaDados: string;

    function GetAtualizExeSubPasta: string;
    function GetAtualizExeURL: string;

    function Get_InstUpdate_ExcluiLocalAntesDoDownload: boolean;


    function GetSisTipoAtividade: TSisTipoAtividade;
    procedure SetSisTipoAtividade(Value: TSisTipoAtividade);

  public
    property ExeName: string read GetExeName;

    property SisTipoAtividade: TSisTipoAtividade read GetSisTipoAtividade write SetSisTipoAtividade;
    property PessoaDonoId: integer read GetPessoaDonoId write SetPessoaDonoId;
    property FundoCor: TColor read GetFundoCor write SetFundoCor;
    property FonteCor: TColor read GetFonteCor write SetFonteCor;
    property NomeExib: string read GetNomeExib;

    property Pasta: string read GetPasta;
    property PastaImg: string read GetPastaImg;
    property PastaComandos: string read GetPastaComandos;
    property PastaConsultas: string read GetPastaConsultas;
    property PastaConsTabViews: string read GetPastaConsTabViews;

    property PastaBin: string read GetPastaBin;
    property PastaConfigs: string read GetPastaConfigs;
    property PastaDados: string read GetPastaDados;

    property AtualizExeSubPasta: string read GetAtualizExeSubPasta;
    property AtualizExeURL: string read GetAtualizExeURL;

    property InstUpdate_ExcluiLocalAntesDoDownload: boolean
      read Get_InstUpdate_ExcluiLocalAntesDoDownload;

    constructor Create(pExeName: string; pAtualizExeSubPasta: string;
      pAtualizExeURL: string);
  end;

implementation

uses Sis.UI.IO.Files, Sis.UI.Controls.Utils;

{ TAppInfo }

constructor TAppInfo.Create(pExeName: string; pAtualizExeSubPasta: string;
  pAtualizExeURL: string);
begin
  FExeName := pExeName;
  FPastaBin := GetPastaDoArquivo(FExeName);
  FPasta := PastaAcima(FPastaBin);
  FPastaConfigs := FPasta + 'Configs\';
  FPastaImg := FPasta + 'Img\';
  FPastaComandos := FPasta + 'Comandos\';
  FPastaDados := FPasta + 'Dados\';
  FPastaConsultas := FPasta + 'Cons\';
  FPastaConsTabViews := FPastaConsultas + 'TabViews\';
end;

function TAppInfo.GetAtualizExeSubPasta: string;
begin
  Result := FAtualizExeSubPasta;
end;

function TAppInfo.GetAtualizExeURL: string;
begin
  Result := FAtualizExeURL;
end;

function TAppInfo.GetExeName: string;
begin
  Result := FExeName;
end;

function TAppInfo.GetFonteCor: TColor;
begin
  Result := FFonteCor;
end;

function TAppInfo.GetFundoCor: TColor;
begin
  Result := FFundoCor;
end;

function TAppInfo.GetNomeExib: string;
begin
  Result := FNomeExib;
end;

function TAppInfo.GetPasta: string;
begin
  Result := FPasta;
end;

function TAppInfo.GetPastaBin: string;
begin
  Result := FPastaBin;
end;

function TAppInfo.GetPastaComandos: string;
begin
  Result := FPastaComandos;
end;

function TAppInfo.GetPastaConfigs: string;
begin
  Result := FPastaConfigs;
end;

function TAppInfo.GetPastaConsTabViews: string;
begin
  Result := FPastaConsTabViews;
end;

function TAppInfo.GetPastaConsultas: string;
begin
  Result := FPastaConsultas;
end;

function TAppInfo.GetPastaDados: string;
begin
  Result := FPastaDados;
end;

function TAppInfo.GetPastaImg: string;
begin
  Result := FPastaImg;
end;

function TAppInfo.GetPessoaDonoId: integer;
begin
  Result := FPessoaDonoId;
end;

function TAppInfo.GetSisTipoAtividade: TSisTipoAtividade;
begin
  Result := FSisTipoAtividade;
end;

function TAppInfo.Get_InstUpdate_ExcluiLocalAntesDoDownload: boolean;
begin
  Result := True;
end;

procedure TAppInfo.SetFonteCor(Value: TColor);
begin
  FFonteCor := Value;
end;

procedure TAppInfo.SetFundoCor(Value: TColor);
begin
  FFundoCor := Value;
end;

procedure TAppInfo.SetNomeExib(Value: string);
begin
  FNomeExib := Value;
end;

procedure TAppInfo.SetPessoaDonoId(Value: integer);
begin
  FPessoaDonoId := Value;
end;

procedure TAppInfo.SetSisTipoAtividade(Value: TSisTipoAtividade);
begin
  FSisTipoAtividade := Value;
end;

end.
