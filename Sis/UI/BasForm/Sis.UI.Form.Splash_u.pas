unit Sis.UI.Form.Splash_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Sis.UI.IO.Output;

type
  TSplashForm = class(TForm, IOutput)
    Image1: TImage;
    MensLabel: TLabel;
  private
    { Private declarations }
    FAtivo: boolean;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  public
    { Public declarations }

    property Ativo: boolean read GetAtivo write SetAtivo;

    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    procedure CarregarLogo(pNomeArqJpg: string);
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.TImage;

{ TSplashForm }

procedure TSplashForm.CarregarLogo(pNomeArqJpg: string);
begin
  Sis.UI.Controls.TImage.TImageCarretarJpg(Image1, pNomeArqJpg);
end;

procedure TSplashForm.Exibir(pFrase: string);
begin
  if not Ativo then
    exit;

  MensLabel.Caption := pFrase;
end;

procedure TSplashForm.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
end;

function TSplashForm.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

procedure TSplashForm.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
