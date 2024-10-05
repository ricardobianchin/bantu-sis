unit App.UI.Sessoes.BotModulo.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.UITypes;

type
  TBotaoModuloFrame = class(TBasFrame)
    FundoPanel: TPanel;
    IconPanel: TPanel;
    IconImage: TImage;
    TitLabel: TLabel;
    ApelidoLabel: TLabel;
  private
    { Private declarations }
    FImageIndex: TImageIndex;
    FOnBotClick: TNotifyEvent;
    function GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function GetBotCaption: string;
    procedure SetBotCaption(const Value: string);
    function GetBotComments: string;
    procedure SetBotComments(const Value: string);
    function GetOnBotClick: TNotifyEvent;
    procedure SetOnBotClick(const Value: TNotifyEvent);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex;
    property BotCaption: string read GetBotCaption write SetBotCaption;
    property BotComments: string read GetBotComments write SetBotComments;
    property OnBotClick: TNotifyEvent read GetOnBotClick write SetOnBotClick;
  end;

var
  BotaoModuloFrame: TBotaoModuloFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.ImgDM;

{ TBotaoModuloFrame }

constructor TBotaoModuloFrame.Create(AOwner: TComponent);
begin
  inherited;
  SetCursorToChilds(Self, crHandPoint);
//  ClearStyleElements(Self);
end;

function TBotaoModuloFrame.GetBotCaption: string;
begin
  Result := TitLabel.Caption;
end;

function TBotaoModuloFrame.GetBotComments: string;
begin
  Result := ApelidoLabel.Caption;
end;

function TBotaoModuloFrame.GetImageIndex: TImageIndex;
begin
  Result := FImageIndex;
end;

function TBotaoModuloFrame.GetOnBotClick: TNotifyEvent;
begin
  Result := FOnBotClick;
end;

procedure TBotaoModuloFrame.SetBotCaption(const Value: string);
begin
  TitLabel.Caption := Value;
end;

procedure TBotaoModuloFrame.SetBotComments(const Value: string);
begin
  ApelidoLabel.Caption := Value;
end;

procedure TBotaoModuloFrame.SetImageIndex(Value: TImageIndex);
begin
  FImageIndex := Value;
  SisImgDataModule.PrincImageList89.GetBitmap(Value, IconImage.Picture.Bitmap);
end;

procedure TBotaoModuloFrame.SetOnBotClick(const Value: TNotifyEvent);
begin
  FOnBotClick := Value;
  SetOnClickToChilds(Self, Value);
end;

end.
