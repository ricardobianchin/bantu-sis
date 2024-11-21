unit Sis.UI.Controls.BotaoFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.UITypes, System.ImageList, Vcl.ImgList;

type
  TBotaoFrame = class(TBasFrame)
    FundoPanel: TPanel;
    IconPanel: TPanel;
    IconImage: TImage;
    TitLabel: TLabel;
    Tit2Label: TLabel;
  private
    { Private declarations }
    FImageIndex: System.UITypes.TImageIndex;
    FOnBotaoClick: TNotifyEvent;
    FShortCut: TShortCut;
    FImageList: TCustomImageList;

    function GetImageIndex: System.UITypes.TImageIndex;
    function GetTit: string;
    procedure SetTit(const Value: string);
    function GetTit2: string;
    procedure SetTit2(const Value: string);
    function GetOnBotaoClick: TNotifyEvent;
    procedure SetOnBotaoClick(const Value: TNotifyEvent);
  protected
    procedure SetImageIndex(Value: System.UITypes.TImageIndex); virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property ImageIndex: System.UITypes.TImageIndex read GetImageIndex write SetImageIndex;
    property Tit: string read GetTit write SetTit;
    property Tit2: string read GetTit2 write SetTit2;
    property OnBotaoClick: TNotifyEvent read GetOnBotaoClick write SetOnBotaoClick;
    property ShortCut: TShortCut read FShortCut write FShortCut;
    property ImageList: TCustomImageList read FImageList write FImageList;

    procedure BotaoClick;
  end;

var
  BotaoFrame: TBotaoFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TBotaoModuloFrame }

procedure TBotaoFrame.BotaoClick;
begin
  if not Assigned(FOnBotaoClick) then
   exit;

  FOnBotaoClick(Self);
end;

constructor TBotaoFrame.Create(AOwner: TComponent);
begin
  inherited;
  SetCursorToChilds(Self, crHandPoint);
//  ClearStyleElements(Self);
end;

function TBotaoFrame.GetTit: string;
begin
  Result := TitLabel.Caption;
end;

function TBotaoFrame.GetTit2: string;
begin
  Result := Tit2Label.Caption;
end;

function TBotaoFrame.GetImageIndex: System.UITypes.TImageIndex;
begin
  Result := FImageIndex;
end;

function TBotaoFrame.GetOnBotaoClick: TNotifyEvent;
begin
  Result := FOnBotaoClick;
end;

procedure TBotaoFrame.SetTit(const Value: string);
begin
  TitLabel.Caption := Value;
end;

procedure TBotaoFrame.SetTit2(const Value: string);
begin
  Tit2Label.Caption := Value;
end;

procedure TBotaoFrame.SetImageIndex(Value: System.UITypes.TImageIndex);
begin
  FImageIndex := Value;
end;

procedure TBotaoFrame.SetOnBotaoClick(const Value: TNotifyEvent);
begin
  FOnBotaoClick := Value;
  SetOnClickToChilds(Self, Value);
end;

end.
