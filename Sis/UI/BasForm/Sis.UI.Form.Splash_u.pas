unit Sis.UI.Form.Splash_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Sis.UI.IO.Output;

type
  TSplashForm = class(TForm)
    Image1: TImage;
    MensLabel: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FOutput: IOutput;

  public
    { Public declarations }
    procedure CarregarLogo(pNomeArqJpg: string);

    property Output: IOutput read FOutput;
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.TImage, Sis.UI.IO.Factory;

{ TSplashForm }

procedure TSplashForm.CarregarLogo(pNomeArqJpg: string);
begin
  Sis.UI.Controls.TImage.TImageCarretarJpg(Image1, pNomeArqJpg);
end;

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  FOutput := LabelOutputCreate(MensLabel);
end;

end.
