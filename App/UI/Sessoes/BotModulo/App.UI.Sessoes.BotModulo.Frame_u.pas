unit App.UI.Sessoes.BotModulo.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Controls.BotaoFrame_u,
  Vcl.ExtCtrls, Vcl.StdCtrls, System.UITypes, Sis.ModuloSistema.Types, Sis.Entities.Types;

type
  TBotaoModuloFrame = class(TBotaoFrame)
  private
    { Private declarations }
    FOpcaoSisIdModulo: TOpcaoSisIdModulo;
    FTerminalId: TTerminalId;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(const Value: TTerminalId);
  protected
    procedure SetImageIndex(Value: TImageIndex); override;
  public
    { Public declarations }
    property OpcaoSisIdModulo: TOpcaoSisIdModulo read FOpcaoSisIdModulo write FOpcaoSisIdModulo;
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;
  end;

var
  BotaoModuloFrame: TBotaoModuloFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.ImgDM;

{ TBotModuloFrame }

function TBotaoModuloFrame.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

procedure TBotaoModuloFrame.SetImageIndex(Value: TImageIndex);
begin
  inherited;
  SisImgDataModule.PrincImageList89.GetBitmap(Value, IconImage.Picture.Bitmap);
end;

procedure TBotaoModuloFrame.SetTerminalId(const Value: TTerminalId);
begin
  FTerminalId := Value;
end;

end.
